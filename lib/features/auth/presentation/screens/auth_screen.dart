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
import '../../../../core/widgets/language_picker.dart';
import '../../../../l10n/l10n.dart';

enum AuthMode { login, signup, forgotPassword }

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

enum _AuthMethod { form, google, apple }

class _AuthScreenState extends ConsumerState<AuthScreen> {
  AuthMode _authMode = AuthMode.login;
  _AuthMethod _method = _AuthMethod.form;
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
    setState(() => _method = _AuthMethod.form);
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

  void _signInWithGoogle() {
    setState(() => _method = _AuthMethod.google);
    ref.read(authProvider.notifier).signInWithGoogle();
  }

  void _signInWithApple() {
    setState(() => _method = _AuthMethod.apple);
    ref.read(authProvider.notifier).signInWithApple();
  }

  (String, String) get _headerText {
    if (_resetSent) {
      return (
        context.l10n.authResetSentTitle,
        context.l10n.authResetSentSubtitle,
      );
    }
    return switch (_authMode) {
      AuthMode.login => (
        context.l10n.authLoginTitle,
        context.l10n.authLoginSubtitle,
      ),
      AuthMode.signup => (
        context.l10n.authSignupTitle,
        context.l10n.authSignupSubtitle,
      ),
      AuthMode.forgotPassword => (
        context.l10n.authForgotTitle,
        context.l10n.authForgotSubtitle,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(authProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          SnackbarUtils.showError(context, error.toString());
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
                      height: topInset + (isForgot || !compact ? 56 : 48),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: 4,
                          end: 16,
                          bottom: 4,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (isForgot)
                              IconButton(
                                onPressed: () =>
                                    _switchAuthMode(AuthMode.login),
                                icon: const BackButtonIcon(),
                                color: Colors.white,
                              ),
                            const Spacer(),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 4),
                              child: LanguageButton(onDark: true),
                            ),
                          ],
                        ),
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
              label: context.l10n.fullName,
              icon: Icons.person_outline_rounded,
              textCapitalization: TextCapitalization.words,
              validator: Validators.name,
              autofillHints: const [AutofillHints.name],
            ),
            const SizedBox(height: 12),
          ],
          AuthTextField(
            controller: _emailController,
            label: context.l10n.email,
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
              label: context.l10n.password,
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
              label: context.l10n.confirmPassword,
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
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: () => _switchAuthMode(AuthMode.forgotPassword),
                child: Text(context.l10n.forgotPassword),
              ),
            )
          else
            const SizedBox(height: 18),
          if (isForgot) ...[const SpamNote(), const SizedBox(height: 20)],
          _PrimaryButton(
            label: switch (_authMode) {
              AuthMode.login => context.l10n.logIn,
              AuthMode.signup => context.l10n.createAccount,
              AuthMode.forgotPassword => context.l10n.sendResetLink,
            },
            isLoading: isLoading && _method == _AuthMethod.form,
            onPressed: isLoading ? null : _submit,
          ),
          if (!isForgot) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                const Expanded(child: Divider(color: AppColors.border)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    context.l10n.or,
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
              label: context.l10n.continueWithGoogle,
              isLoading: isLoading && _method == _AuthMethod.google,
              onPressed: isLoading ? null : _signInWithGoogle,
            ),
            if (Platform.isIOS) ...[
              const SizedBox(height: 12),
              SocialButton(
                asset: AppAssets.apple,
                label: context.l10n.continueWithApple,
                isLoading: isLoading && _method == _AuthMethod.apple,
                onPressed: isLoading ? null : _signInWithApple,
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
            text: '${context.l10n.resetLinkSentTo}\n',
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
          label: context.l10n.backToLogIn,
          isLoading: false,
          onPressed: () => _switchAuthMode(AuthMode.login),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => setState(() => _resetSent = false),
          child: Text(context.l10n.sendAgain),
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
  final VoidCallback? onPressed;

  const _PrimaryButton({
    required this.label,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
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
