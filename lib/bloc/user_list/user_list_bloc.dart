import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_crud_with_bloc_library/repository/user_repository.dart';
import './bloc.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final _userRepository = UserRepository();
  
  @override
  UserListState get initialState => InitialUserListState();

  @override
  Stream<UserListState> mapEventToState(UserListEvent event) async* {
    yield Loading();
    if (event is GetUsers) {
      yield Loaded(users: await _userRepository.getUsers(query: event.query));
    } else if (event is DeleteUser) {
      await _userRepository.deleteUser(event.user.id);
      yield Loaded(users: await _userRepository.getUsers(query: event.query));
    }
  }
}
