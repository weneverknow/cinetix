part of 'service.dart';

class UserService {
  static CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> insertUser(Users user) async {
    _userCollection.doc(user.id).set({
      'email': user.email,
      'firstname': user.firstname,
      'lastname': user.lastname
    });
  }

  static Future<Users> getUsers(String id) async {
    DocumentSnapshot snapshot = await _userCollection.doc(id).get();
    return Users(id, snapshot.data()['email'], snapshot.data()['firstname'],
        password: snapshot.data()['password'],
        lastname: snapshot.data()['lastname']);
  }
}
