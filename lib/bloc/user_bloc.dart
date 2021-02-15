import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutix/models/models.dart';
import 'package:flutix/services/services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoadUser) {
      Users users = await UserServices.getUser(event.id);
      yield UserLoaded(users);
    } else if (event is SignOut) {
      yield UserInitial();
    } else if (event is UpdateData) {
      Users updatedUser = (state as UserLoaded)
          .users
          .copyWith(name: event.name, profilePicture: event.profileImage);
      await UserServices.updatedUser(updatedUser);
      yield UserLoaded(updatedUser);
    } else if (event is TopUp) {
      if (state is UserLoaded) {
        try {
          Users updatedUser = (state as UserLoaded).users.copyWith(
              balance: (state as UserLoaded).users.balance + event.amount);
          await UserServices.updatedUser(updatedUser);
          yield UserLoaded(updatedUser);
        } catch (e) {
          print(e);
        }
      }
    } else if (event is Purchase) {
      if (state is UserLoaded) {
        try {
          Users updatedUser = (state as UserLoaded).users.copyWith(
              balance: (state as UserLoaded).users.balance - event.amount);
          await UserServices.updatedUser(
              updatedUser); //proses update data ke firestore
          yield UserLoaded(updatedUser);
        } catch (e) {
          print(e);
        }
      }
    }
  }
}
