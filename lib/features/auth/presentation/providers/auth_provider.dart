import '../../../location/data/datasources/places_service.dart';
import '../../../notifications/presentation/providers/notifications_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../data/models/user_model.dart';
import '../../../../l10n/l10n.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  bool _isGoogleInitialized = false;
  final List<String> _googleScopes = ['email', 'profile'];

  AuthRepository({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  }) : _auth = auth,
       _firestore = firestore;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  Future<void> _ensureGoogleInitialized() async {
    if (!_isGoogleInitialized) {
      await GoogleSignIn.instance.initialize();
      _isGoogleInitialized = true;
    }
  }

  Future<UserModel> signInWithGoogle() async {
    await _ensureGoogleInitialized();
    final GoogleSignInAccount? account = await GoogleSignIn.instance
        .authenticate();
    if (account == null) throw 'Sign-in cancelled';

    final GoogleSignInAuthentication googleAuth = await account.authentication;
    final GoogleSignInClientAuthorization? authorization = await account
        .authorizationClient
        .authorizationForScopes(_googleScopes);

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: authorization?.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential = await _auth.signInWithCredential(
      credential,
    );
    final User user = userCredential.user!;
    final userDoc = await _firestore.collection('users').doc(user.uid).get();

    if (!userDoc.exists ||
        (userCredential.additionalUserInfo?.isNewUser ?? false)) {
      final newUser = UserModel(
        uid: user.uid,
        name: account.displayName ?? 'Google User',
        email: account.email,
        photoUrl: account.photoUrl,
        isPremium: false,
        createdAt: DateTime.now(),
      );
      await _saveUserData(newUser);
      return newUser;
    } else {
      return UserModel.fromMap(userDoc.data()!);
    }
  }

  Future<UserModel> signInWithApple() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final idToken = appleCredential.identityToken;
    if (idToken == null) throw 'Apple Sign-In failed: no identity token.';

    final oauthCredential = OAuthProvider('apple.com').credential(
      idToken: idToken,
      accessToken: appleCredential.authorizationCode,
    );

    final UserCredential userCredential = await _auth.signInWithCredential(
      oauthCredential,
    );
    final User user = userCredential.user!;
    final userDoc = await _firestore.collection('users').doc(user.uid).get();

    if (!userDoc.exists ||
        (userCredential.additionalUserInfo?.isNewUser ?? false)) {
      String fullName = 'Apple User';
      if (appleCredential.givenName != null ||
          appleCredential.familyName != null) {
        fullName =
            '${appleCredential.givenName ?? ''} ${appleCredential.familyName ?? ''}'
                .trim();
      } else if (user.displayName != null) {
        fullName = user.displayName!;
      }

      final newUser = UserModel(
        uid: user.uid,
        name: fullName,
        email: user.email ?? appleCredential.email ?? '',
        photoUrl: user.photoURL,
        isPremium: false,
        createdAt: DateTime.now(),
      );
      await _saveUserData(newUser);
      return newUser;
    } else {
      return UserModel.fromMap(userDoc.data()!);
    }
  }

  Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final userModel = UserModel(
      uid: credential.user!.uid,
      name: name,
      email: email,
      isPremium: false,
      createdAt: DateTime.now(),
    );
    await _saveUserData(userModel);
    return userModel;
  }

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return await getUserData(credential.user!.uid);
  }

  Future<UserModel> getUserData(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!);
    } else {
      throw 'User data not found';
    }
  }

  Future<void> _saveUserData(UserModel user) async {
    await _firestore
        .collection('users')
        .doc(user.uid)
        .set(user.toMap(), SetOptions(merge: true));
  }

  Future<void> forgotPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Email accounts confirm with their password; Google and Apple accounts
  // type a confirmation word instead.
  bool get usesPassword =>
      _auth.currentUser?.providerData.any(
        (p) => p.providerId == EmailAuthProvider.PROVIDER_ID,
      ) ??
      false;

  Future<void> reauthenticate(String password) async {
    final user = _auth.currentUser;
    final email = user?.email;
    if (user == null || email == null) {
      throw FirebaseAuthException(code: 'user-not-found');
    }
    await user.reauthenticateWithCredential(
      EmailAuthProvider.credential(email: email, password: password),
    );
    await user.getIdToken(true);
  }

  Future<void> deleteAccount() async {
    await FirebaseFunctions.instanceFor(region: PlacesService.functionsRegion)
        .httpsCallable(
          'deleteAccount',
          options: HttpsCallableOptions(timeout: const Duration(seconds: 60)),
        )
        .call<Object?>();
    if (_isGoogleInitialized) await GoogleSignIn.instance.signOut();
    await _auth.signOut();
  }
}

class AuthNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  void _fail(Object error) {
    final message = authErrorMessage(error);
    state = message == null
        ? const AsyncValue.data(null)
        : AsyncValue.error(message, StackTrace.current);
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await ref
          .read(authRepositoryProvider)
          .signIn(email: email, password: password);
      state = const AsyncValue.data(null);
    } catch (e) {
      _fail(e);
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await ref
          .read(authRepositoryProvider)
          .signUp(email: email, password: password, name: name);
      state = const AsyncValue.data(null);
    } catch (e) {
      _fail(e);
    }
  }

  Future<void> resetPassword(String email) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(authRepositoryProvider).forgotPassword(email);
      state = const AsyncValue.data(null);
    } catch (e) {
      _fail(e);
    }
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    try {
      await ref.read(authRepositoryProvider).signInWithGoogle();
      state = const AsyncValue.data(null);
    } catch (e) {
      _fail(e);
    }
  }

  Future<void> signInWithApple() async {
    state = const AsyncValue.loading();
    try {
      await ref.read(authRepositoryProvider).signInWithApple();
      state = const AsyncValue.data(null);
    } catch (e) {
      _fail(e);
    }
  }

  // Push stops first, so a token refresh can't recreate the deleted profile.
  Future<void> deleteAccount() async {
    await ref.read(pushServiceProvider).stop();
    try {
      await ref.read(authRepositoryProvider).deleteAccount();
    } on FirebaseFunctionsException catch (e) {
      throw switch (e.code) {
        'unavailable' || 'deadline-exceeded' => appL10n.errorOffline,
        'unauthenticated' => appL10n.errorSessionExpired,
        'failed-precondition' => appL10n.confirmPasswordAgain,
        _ => appL10n.deleteAccountFailed,
      };
    } catch (_) {
      throw appL10n.deleteAccountFailed;
    }
  }

  Future<void> logout() async {
    await ref.read(pushServiceProvider).stop();
    await ref.read(authRepositoryProvider).signOut();
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, void>(
  AuthNotifier.new,
);

// null means the user cancelled, which needs no message.
String? authErrorMessage(Object error) {
  final l10n = appL10n;
  if (error is GoogleSignInException &&
      error.code == GoogleSignInExceptionCode.canceled) {
    return null;
  }
  if (error is SignInWithAppleAuthorizationException &&
      error.code == AuthorizationErrorCode.canceled) {
    return null;
  }
  if (error is! FirebaseAuthException) return l10n.authErrorGeneric;
  return switch (error.code) {
    'invalid-email' => l10n.validationEmailInvalid,
    'user-disabled' => l10n.authErrorDisabled,
    'user-not-found' ||
    'wrong-password' ||
    'invalid-credential' ||
    'INVALID_LOGIN_CREDENTIALS' => l10n.authErrorWrongCredentials,
    'email-already-in-use' => l10n.authErrorEmailInUse,
    'weak-password' => l10n.validationPasswordTooShort,
    'too-many-requests' => l10n.authErrorTooManyRequests,
    'network-request-failed' => l10n.errorOffline,
    _ => l10n.authErrorGeneric,
  };
}
