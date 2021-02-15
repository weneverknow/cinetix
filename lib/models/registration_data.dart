part of 'models.dart';

class RegistrationData {
  String name;
  String email;
  String password;
  List<String> selectedGenre;
  String selectedLang;
  File profileImage;

  RegistrationData(
      {this.name = "",
      this.email = "",
      this.password = "",
      this.selectedGenre = const [],
      this.selectedLang = "",
      this.profileImage});
}
