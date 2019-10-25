import 'package:flutter_crud_with_bloc_library/model/user_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserFormState {
  final User user;
  final String message;

  UserFormState({this.user, this.message});
}
  
class InitialUserFormState extends UserFormState {}

class Loading extends UserFormState {}

class Error extends UserFormState {
  Error({String errorMessage}) : super(message: errorMessage);
}

class Loaded extends UserFormState {
  Loaded({User user}) : super(user: user);
}

class Success extends UserFormState {
  Success({String successMessage}) : super(message: successMessage);
}
