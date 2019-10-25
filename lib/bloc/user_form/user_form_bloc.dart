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
      try {
        User user = await _userRepository.getUser(event.user?.id);
        yield Loaded(user: event.user == null ? User() : user);
      } catch(e) {
        yield Error(error: e.toString());
      }
    } else if (event is BackEvent) {
      yield InitialUserFormState();
    } else if (event is CreateUser) {
      try {
        await _userRepository.createUser(event.user);
        yield InitialUserFormState();
      } catch(e) {
        yield Error(error: e.toString());
      }
    } else if (event is UpdateUser) {
      try {
        await _userRepository.updateUser(event.user);
        yield InitialUserFormState();
      } catch(e) {
        yield Error(error: e.toString());
      }
    }
  }
}
