part of 'model.dart';

class Users extends Equatable {
  String id;
  String email;
  String password;
  String firstname;
  String lastname;

  Users(this.id, this.email, this.firstname, {this.password, this.lastname});

  @override
  String toString() {
    return '[$id] - $firstname $lastname ($email)';
  }

  @override
  List<Object> get props => throw UnimplementedError();
}
