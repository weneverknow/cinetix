part of 'services.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<SignInSignUpResult> signUp(String email, String password,
      String name, List<String> selectedGenre, String selectedLanguage) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password); //insert/create authentication user

      Users users = result.user.convertToUser(
          name: name,
          selectedGenre: selectedGenre,
          selectedLanguage: selectedLanguage);

      await UserServices.updatedUser(users); //insert to firestore
      return SignInSignUpResult(users: users);
    } on FirebaseAuthException catch (e) {
      String msg = '';
      if (e.code == 'weak-password') {
        msg = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        msg = 'The account already exist fo that email';
      }
      return SignInSignUpResult(message: msg);
    } on PlatformException catch (e) {
      return SignInSignUpResult(message: e.message);
    } catch (e) {
      return SignInSignUpResult(message: e.toString());
    }
  }

  static Future<SignInSignUpResult> signInUser(
      {String email, String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Users users = await result.user.getFromFireStore();
      return SignInSignUpResult(users: users);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.toString().trim());
      return SignInSignUpResult(
          message: e.toString().trim(), errorCode: e.code);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().trim());
    }
  }

  static Future<SignInSignUpResult> updateAuthUsers({
    String name,
    String email,
    String password,
    List<String> selectedGenre,
    String selectedLanguage,
  }) async {
    try {
      User firebaseUser = _auth.currentUser;

      // await firebaseUser.reauthenticateWithCredential(
      //     EmailAuthProvider.credential(
      //         email: firebaseUser.email, password: password));

      // print("email and id user before update email n password authentication");
      // print(firebaseUser.email);
      // print(firebaseUser.uid);
      // print("==============================");

      //update authentication users
      // await firebaseUser.updateEmail(email).then((value) async {
      //   print("update email to " + email);
      //   await firebaseUser.updatePassword(password);
      // });
      //await firebaseUser.updateEmail(email);
      //await firebaseUser.updatePassword(password);

      //di loginkan lagi krn untuk mengambil id/email user yg sedang login untuk metod convertToUser dibawah
      // UserCredential credential = await _auth.signInWithEmailAndPassword(
      //     email: email,
      //     password:
      //         password);

      // print("email and id user after update email n password authentication");
      // print(credential.user.email);
      // print(credential.user.uid);
      // print(firebaseUser.email);
      // print(firebaseUser.uid);
      //print(users.email);
      //print(users.id);
      Users users = firebaseUser.convertToUser(
        name: name,
        selectedGenre: selectedGenre,
        selectedLanguage: selectedLanguage,
      ); //method untuk ubah data model Users sesuai dengan yg baru
      //users.email = email; //set email variable with new email

      String currentPicture = await firebaseUser
          .getFromFireStore()
          .then((value) async => value.profilePicture);
      //TODO: email di firestore tidak terupdate
      await UserServices.updatedUser(users.copyWith(
        profilePicture: currentPicture,
      )); //update ke firestore
      // await UserServices.getUser(
      //     firebaseUser.uid); //ambil data users setelah firestore updated
      users = await firebaseUser.getFromFireStore();
      print("users.email " + users.email);
      print("users.name " + users.name);
      return SignInSignUpResult(users: users);
    } catch (e) {
      print(e.toString().trim());
      return SignInSignUpResult(message: e.toString().trim());
    }
  }

  static Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Stream<User> get userStream => _auth.authStateChanges();
}

class SignInSignUpResult {
  final Users users;
  final String message;
  final String errorCode;

  SignInSignUpResult({this.users, this.message, this.errorCode});

  static String getMessage(String errorCode) {
    String result = '';
    switch (errorCode) {
      case 'user-not-found':
        result = 'Pengguna tidak ditemukan';
        break;
      case 'wrong-password':
        result = 'Kata sandi yang anda masukkan salah';
        break;
      case 'network-request-failed':
        result = 'Internet anda bermasalah, periksa jaringan internet anda';
        break;
      default:
        result = 'ada kesalahan. coba beberapa menit kemudian';
        break;
    }
    return result;
  }
}
