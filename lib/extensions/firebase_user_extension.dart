part of 'extensions.dart';

extension FirebaseUserExtension on User {
  Users convertToUser(
          {String name = 'No Name',
          List<String> selectedGenre = const [],
          String selectedLanguage = 'English',
          int balance = 50000}) =>
      Users(
        this.uid,
        this.email,
        name: name,
        selectedGenre: selectedGenre,
        selectedLanguage: selectedLanguage,
        balance: balance,
      );

  Future<Users> getFromFireStore() async =>
      await UserServices.getUser(this.uid);
}
