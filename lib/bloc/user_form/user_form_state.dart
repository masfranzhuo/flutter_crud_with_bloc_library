import 'package:flutter_crud_with_bloc_library/model/user_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserFormState {
  final User user;
  final String error;

  UserFormState({this.user, this.error});
}
  
class InitialUserFormState extends UserFormState {}

class Loading extends UserFormState {}

class Error extends UserFormState {
  Error({String error}) : super(error: error);
}

class Loaded extends UserFormState {
  Loaded({User user}) : super(user: user);
}
