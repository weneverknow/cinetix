part of 'service.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<SignUpSignInResult> signUp(
      String email, String password, String firstname, String lastname) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      Users users =
          result.user.convertToUser(firstname: firstname, lastname: lastname);

      await UserService.insertUser(users);
      return SignUpSignInResult(users: users);
    } catch (e) {
      return SignUpSignInResult(message: e.toString().split(',')[1]);
    }
  }

  static Future<SignUpSignInResult> signIn(
      String email, String password) async {
    try {
      UserCredential userlogin = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Users users = await userlogin.user.getFromFirestore();
      return SignUpSignInResult(users: users);
    } catch (e) {
      return SignUpSignInResult(message: e.toString().split(',')[1]);
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Stream<User> get userStream => _auth.authStateChanges();

  static Future<SignUpSignInResult> signOut2() async {
    await _auth.signOut();
    await _auth.authStateChanges().listen((User user) {
      if (user == null) {
        SignUpSignInResult(message: 'User Sign Out');
      } else {
        SignUpSignInResult(message: 'User Sign In');
      }
    });
  }
}

class SignUpSignInResult {
  final Users users;
  final String message;

  SignUpSignInResult({this.users, this.message});
}
