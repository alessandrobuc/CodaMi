import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../data/models/user_model.dart';

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
        ?.authorizationForScopes(_googleScopes);

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
    await _firestore.collection('users').doc(user.uid).set(user.toMap());
  }

  Future<void> forgotPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

class AuthNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await ref
          .read(authRepositoryProvider)
          .signIn(email: email, password: password);
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
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
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  Future<void> resetPassword(String email) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(authRepositoryProvider).forgotPassword(email);
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    try {
      await ref.read(authRepositoryProvider).signInWithGoogle();
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  Future<void> signInWithApple() async {
    state = const AsyncValue.loading();
    try {
      await ref.read(authRepositoryProvider).signInWithApple();
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).signOut();
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, void>(
  AuthNotifier.new,
);
