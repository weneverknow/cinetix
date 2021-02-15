part of 'services.dart';

class UserServices {
  static CollectionReference _userCollection =
      Firestore.instance.collection('users');

  static Future<void> updatedUser(Users users) async {
    String genres = "";
    for (var genre in users.selectedGenre) {
      genres += genre + ((genre != users.selectedGenre.last) ? ',' : '');
    }

    _userCollection.doc(users.id).set({
      'email': users.email,
      'name': users.name,
      'balance': users.balance,
      'selectedGenre': users.selectedGenre,
      'selectedLanguage': users.selectedLanguage,
      'profilePicture': users.profilePicture ?? ''
    });

    // _userCollection.document(users.id).setData({
    //   'email': users.email,
    //   'name': users.name,
    //   'balance': users.balance,
    //   'selectedGenre': genres,
    //   'selectedLanguage': users.selectedLanguage,
    //   'profilePicture': users.profilePicture ?? ''
    // });
  }

  static Future<Users> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.doc(id).get();

    return Users(id, snapshot.data()['email'],
        balance: snapshot.data()['balance'],
        name: snapshot.data()['name'],
        profilePicture: snapshot.data()['profilePicture'],
        selectedGenre: (snapshot.data()['selectedGenre'] as List)
            .map((e) => e.toString())
            .toList(),
        selectedLanguage: snapshot.data()['selectedLanguage']);
  }
}
