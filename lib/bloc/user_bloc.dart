import 'package:flutter_crud_with_bloc_library/model/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_crud_with_bloc_library/repository/user_repository.dart';
import 'package:flutter/foundation.dart';

enum UserBlocEvent { LIST, CREATE, READ, UPDATE, DELETE }

class UserEvent {
  UserBlocEvent event;
  User user;
  
  UserEvent({@required this.event, this.user});
}

class UserState {
  List<User> users;
  User user;

  UserState({this.users, this.user});
}

class UninitializedUserState extends UserState {}

class UserBloc extends Bloc<UserEvent, UserState> {
  final _userRepository = UserRepository();
  UserState _userState = UserState();

  @override
  UserState get initialState => UninitializedUserState();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    UserState userState;
    switch (event.event) {
      case UserBlocEvent.LIST:
        userState = UserState(users: await _userRepository.getUsers());
        break;
      case UserBlocEvent.CREATE:
        await _userRepository.createUser(event.user);
        userState = UserState(users: await _userRepository.getUsers());
        break;
      case UserBlocEvent.READ:
        userState = UserState(users: _userState.users, user: await _userRepository.getUser(event.user.id));
        break;
      case UserBlocEvent.UPDATE:
        await _userRepository.updateUser(event.user);
        User user = await _userRepository.getUser(event.user.id);
        _userState.users[getIndex(_userState.users, user)] = user;
        userState = UserState(users: _userState.users, user: user);
        break;
      case UserBlocEvent.DELETE:
        await _userRepository.deleteUser(event.user.id);
        userState = UserState(users: await _userRepository.getUsers());
        break;
      default:
        userState = UserState(users: await _userRepository.getUsers());
        break;
    }
    this._userState = userState;
    yield(userState);
  }

  int getIndex(List<User> users, User user) {
    int index = 0;
    for(int i = 0; i< users.length; i++) {
      if (users[i].id == user.id) {
        index = i;
        break;
      }
    }
    return index;
  }
}