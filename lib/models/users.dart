part of 'models.dart';

class Users extends Equatable {
  final String id;
  final String email;
  final String name;
  final String profilePicture;
  final List<String> selectedGenre;
  final String selectedLanguage;
  final int balance;

  Users(this.id, this.email,
      {this.name,
      this.profilePicture,
      this.selectedGenre,
      this.selectedLanguage,
      this.balance});

  set email(String newEmail) {
    email = newEmail;
  }

  @override
  String toString() {
    return '[$id] - $name - $email';
  }

  Users copyWith({String name, String profilePicture, int balance}) =>
      Users(this.id, this.email,
          name: name ?? this.name,
          profilePicture: profilePicture ?? this.profilePicture,
          balance: balance ?? this.balance,
          selectedGenre: selectedGenre,
          selectedLanguage: selectedLanguage);

  

  @override
  List<Object> get props => [
        id,
        email,
        name,
        profilePicture,
        selectedGenre,
        selectedLanguage,
        balance
      ];
}
