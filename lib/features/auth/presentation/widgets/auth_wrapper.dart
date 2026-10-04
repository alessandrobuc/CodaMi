import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../location/presentation/screens/city_setup_screen.dart';
import '../../../onboarding/presentation/screens/onboarding_screen.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../../shell/presentation/screens/main_shell.dart';
import '../../data/models/user_model.dart';
import '../providers/auth_provider.dart';
import '../screens/auth_screen.dart';

class AuthWrapper extends ConsumerStatefulWidget {
  const AuthWrapper({super.key});

  @override
  ConsumerState<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends ConsumerState<AuthWrapper> {
  bool _splashReleased = false;
  bool _signedOutThisSession = false;
  Timer? _splashTimeout;

  @override
  void initState() {
    super.initState();
    _splashTimeout = Timer(const Duration(seconds: 3), _releaseSplash);
  }

  @override
  void dispose() {
    _splashTimeout?.cancel();
    super.dispose();
  }

  void _releaseSplash() {
    if (_splashReleased) return;
    _splashReleased = true;
    _splashTimeout?.cancel();
    Future.microtask(WidgetsBinding.instance.allowFirstFrame);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authStateProvider, (previous, next) {
      final wasSignedIn = previous?.value != null;
      final isSignedIn = next.value != null;
      if (previous?.hasValue == true && wasSignedIn != isSignedIn) {
        if (wasSignedIn) setState(() => _signedOutThisSession = true);
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    });

    final authState = ref.watch(authStateProvider);
    final profileState = authState.value == null
        ? null
        : ref.watch(userProfileProvider);

    if (!authState.isLoading && !(profileState?.isLoading ?? false)) {
      _releaseSplash();
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: _buildScreen(authState, profileState),
    );
  }

  Widget _buildScreen(
    AsyncValue<User?> authState,
    AsyncValue<UserModel?>? profileState,
  ) {
    if (authState.isLoading) return const SizedBox.shrink();
    if (profileState == null) {
      return _signedOutThisSession
          ? const AuthScreen(key: ValueKey('auth'))
          : const OnboardingScreen(key: ValueKey('onboarding'));
    }
    if (profileState.isLoading) {
      return const _LoadingView(key: ValueKey('loading'));
    }
    if (profileState.hasError || (profileState.value?.hasCity ?? false)) {
      return const MainShell(key: ValueKey('shell'));
    }
    return const CitySetupScreen(key: ValueKey('city'));
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppAssets.logo, width: 120),
            const SizedBox(height: 28),
            const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
