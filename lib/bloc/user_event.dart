part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoadUser extends UserEvent {
  final String id;

  LoadUser(this.id);
  @override
  List<Object> get props => [id];
}

class SignOut extends UserEvent {
  @override
  List<Object> get props => [];
}

class UpdateData extends UserEvent {
  final String name;
  final String profileImage;
  UpdateData({this.name, this.profileImage});
  @override
  // TODO: implement props
  List<Object> get props => [name, profileImage];
}

class TopUp extends UserEvent {
  final int amount;
  TopUp(this.amount);
  @override
  // TODO: implement props
  List<Object> get props => [amount];
}

class Purchase extends UserEvent {
  final int amount;
  Purchase(this.amount);
  @override
  // TODO: implement props
  List<Object> get props => [amount];
}
