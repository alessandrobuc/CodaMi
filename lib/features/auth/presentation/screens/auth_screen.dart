import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/utils/validators.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_widget.dart';

enum AuthMode { login, signup, forgotPassword }

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  AuthMode _authMode = AuthMode.login;
  bool _resetSent = false;
  var _formKey = GlobalKey<FormState>();
  final _confirmFieldKey = GlobalKey<FormFieldState<String>>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _switchAuthMode(AuthMode mode) {
    FocusScope.of(context).unfocus();
    setState(() {
      _authMode = mode;
      _resetSent = false;
      _formKey = GlobalKey<FormState>();
      _passwordController.clear();
      _confirmPasswordController.clear();
    });
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final auth = ref.read(authProvider.notifier);
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (_authMode == AuthMode.login) {
      await auth.login(email, password);
    } else if (_authMode == AuthMode.signup) {
      final name = _nameController.text.trim();
      await auth.signUp(name, email, password);
    } else {
      await auth.resetPassword(email);
      if (mounted && !ref.read(authProvider).hasError) {
        setState(() => _resetSent = true);
      }
    }
  }

  (String, String) get _headerText {
    if (_resetSent) {
      return (
        'Check your inbox',
        'We\'ve sent you a link to reset your password.',
      );
    }
    return switch (_authMode) {
      AuthMode.login => (
        'Welcome back!',
        'Log in to keep helping pets find their way home.',
      ),
      AuthMode.signup => (
        'Join the pack',
        'Create an account and help your neighbourhood.',
      ),
      AuthMode.forgotPassword => (
        'Forgot password?',
        'No worries, we\'ll email you a reset link.',
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(authProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          final errorMessage = error
              .toString()
              .replaceAll('Exception: ', '')
              .trim();
          SnackbarUtils.showError(context, errorMessage);
        },
      );
    });

    final isLoading = ref.watch(authProvider).isLoading;
    final (title, subtitle) = _headerText;
    final isForgot = _authMode == AuthMode.forgotPassword;

    final topInset = MediaQuery.paddingOf(context).top;
    final compact = MediaQuery.sizeOf(context).height < 760;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.primaryDark,
        body: AuthBackground(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  mainAxisAlignment: isForgot
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: topInset + (isForgot || !compact ? 48 : 12),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: isForgot
                            ? IconButton(
                                onPressed: () =>
                                    _switchAuthMode(AuthMode.login),
                                icon: const Icon(
                                  Icons.arrow_back_rounded,
                                  color: Colors.white,
                                ),
                              )
                            : null,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        24,
                        0,
                        24,
                        isForgot ? 24 : 8,
                      ),
                      child: AuthHeaderContent(
                        title: title,
                        subtitle: subtitle,
                        showMail: isForgot,
                        compact: compact,
                      ),
                    ),
                    AuthSheet(
                      child:
                          _FormCard(
                                child: AnimatedSize(
                                  duration: const Duration(milliseconds: 350),
                                  curve: Curves.easeOutCubic,
                                  alignment: Alignment.topCenter,
                                  child: _resetSent
                                      ? _buildResetSent()
                                      : _buildForm(isLoading),
                                ),
                              )
                              .animate()
                              .fadeIn(duration: 500.ms)
                              .slideY(
                                begin: 0.15,
                                end: 0,
                                curve: Curves.easeOutCubic,
                              ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(bool isLoading) {
    final isLogin = _authMode == AuthMode.login;
    final isSignup = _authMode == AuthMode.signup;
    final isForgot = _authMode == AuthMode.forgotPassword;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!isForgot) ...[
            AuthModeToggle(
              isLogin: isLogin,
              onChanged: (login) =>
                  _switchAuthMode(login ? AuthMode.login : AuthMode.signup),
            ),
            const SizedBox(height: 18),
          ],
          if (isSignup) ...[
            AuthTextField(
              controller: _nameController,
              label: 'Full Name',
              icon: Icons.person_outline_rounded,
              textCapitalization: TextCapitalization.words,
              validator: Validators.name,
              autofillHints: const [AutofillHints.name],
            ),
            const SizedBox(height: 12),
          ],
          AuthTextField(
            controller: _emailController,
            label: 'Email',
            icon: Icons.email_outlined,
            validator: Validators.email,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            textInputAction: isForgot
                ? TextInputAction.done
                : TextInputAction.next,
          ),
          if (!isForgot) ...[
            const SizedBox(height: 12),
            AuthTextField(
              controller: _passwordController,
              label: 'Password',
              icon: Icons.lock_outline_rounded,
              validator: Validators.password,
              onChanged: (_) {
                if (_confirmPasswordController.text.isNotEmpty) {
                  _confirmFieldKey.currentState?.validate();
                }
              },
              isPassword: true,
              autofillHints: [
                isSignup ? AutofillHints.newPassword : AutofillHints.password,
              ],
              textInputAction: isLogin
                  ? TextInputAction.done
                  : TextInputAction.next,
            ),
          ],
          if (isSignup) ...[
            const SizedBox(height: 12),
            AuthTextField(
              controller: _confirmPasswordController,
              label: 'Confirm Password',
              icon: Icons.lock_reset_rounded,
              fieldKey: _confirmFieldKey,
              validator: Validators.confirmPassword(
                () => _passwordController.text,
              ),
              isPassword: true,
              textInputAction: TextInputAction.done,
            ),
          ],
          if (isLogin)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => _switchAuthMode(AuthMode.forgotPassword),
                child: const Text('Forgot Password?'),
              ),
            )
          else
            const SizedBox(height: 18),
          if (isForgot) ...[const SpamNote(), const SizedBox(height: 20)],
          _PrimaryButton(
            label: switch (_authMode) {
              AuthMode.login => 'Log In',
              AuthMode.signup => 'Create Account',
              AuthMode.forgotPassword => 'Send Reset Link',
            },
            isLoading: isLoading,
            onPressed: _submit,
          ),
          if (!isForgot) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                const Expanded(child: Divider(color: AppColors.border)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    'or',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
                  ),
                ),
                const Expanded(child: Divider(color: AppColors.border)),
              ],
            ),
            const SizedBox(height: 16),
            SocialButton(
              asset: AppAssets.google,
              label: 'Continue with Google',
              onPressed: isLoading
                  ? null
                  : () => ref.read(authProvider.notifier).signInWithGoogle(),
            ),
            if (Platform.isIOS) ...[
              const SizedBox(height: 12),
              SocialButton(
                asset: AppAssets.apple,
                label: 'Continue with Apple',
                onPressed: isLoading
                    ? null
                    : () => ref.read(authProvider.notifier).signInWithApple(),
              ),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildResetSent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
              width: 72,
              height: 72,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.mark_email_read_rounded,
                color: AppColors.primary,
                size: 36,
              ),
            )
            .animate()
            .scale(duration: 600.ms, curve: Curves.elasticOut)
            .then()
            .shake(hz: 3, rotation: 0.05),
        const SizedBox(height: 16),
        Text.rich(
          TextSpan(
            text: 'We sent a reset link to\n',
            children: [
              TextSpan(
                text: _emailController.text.trim(),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textMuted,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 20),
        const SpamNote(),
        const SizedBox(height: 20),
        _PrimaryButton(
          label: 'Back to Log In',
          isLoading: false,
          onPressed: () => _switchAuthMode(AuthMode.login),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => setState(() => _resetSent = false),
          child: const Text('Didn\'t get it? Send again'),
        ),
      ],
    );
  }
}

class _FormCard extends StatelessWidget {
  final Widget child;

  const _FormCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.text.withValues(alpha: 0.08),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback onPressed;

  const _PrimaryButton({
    required this.label,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.primary,
                ),
              )
            : Text(label),
      ),
    );
  }
}
