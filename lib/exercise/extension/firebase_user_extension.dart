part of 'extension.dart';

extension FirebaseUserExtension on User {
  Users convertToUser({String firstname = '', String lastname = ''}) =>
      Users(this.uid, this.email, firstname, lastname: lastname);

  Future<Users> getFromFirestore() async =>
      await UserService.getUsers(this.uid);
}
