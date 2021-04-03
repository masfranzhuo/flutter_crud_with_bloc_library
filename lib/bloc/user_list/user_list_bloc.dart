import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_crud_with_bloc_library/model/user_model.dart';
import 'package:flutter_crud_with_bloc_library/repository/user_repository.dart';
import './bloc.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final _userRepository = UserRepository();

  UserListBloc() : super(InitialUserListState());

  @override
  Stream<UserListState> mapEventToState(UserListEvent event) async* {
    yield Loading();
    if (event is GetUsers) {
      try {
        List<User> users = await _userRepository.getUsers(query: event.query);
        yield Loaded(users: users);
      } catch (e) {
        yield Error(errorMessage: e.toString());
      }
    } else if (event is DeleteUser) {
      try {
        await _userRepository.deleteUser(event.user.id);
        yield Loaded(users: await _userRepository.getUsers(query: event.query));
      } catch (e) {
        yield Error(errorMessage: e.toString());
      }
    }
  }
}
