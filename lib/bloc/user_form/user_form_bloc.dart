import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_crud_with_bloc_library/model/user_model.dart';
import 'package:flutter_crud_with_bloc_library/repository/user_repository.dart';
import './bloc.dart';

class UserFormBloc extends Bloc<UserFormEvent, UserFormState> {
  final _userRepository = UserRepository();
  
  @override
  UserFormState get initialState => InitialUserFormState();

  @override
  Stream<UserFormState> mapEventToState(UserFormEvent event) async* {
    yield Loading();
    if (event is GetUser) {
      yield Loaded(user: event.user == null ? User() : await _userRepository.getUser(event.user.id));
    } else if (event is BackEvent) {
      yield InitialUserFormState();
    } else if (event is CreateUser) {
      await _userRepository.createUser(event.user);
      yield InitialUserFormState();
    } else if (event is UpdateUser) {
      await _userRepository.updateUser(event.user);
      yield InitialUserFormState();
    }
  }
}
