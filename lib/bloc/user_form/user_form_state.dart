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
  Error({@required String errorMessage}) : super(message: errorMessage);
}

class Loaded extends UserFormState {
  Loaded({@required User user}) : super(user: user);
}

class Success extends UserFormState {
  Success({@required String successMessage}) : super(message: successMessage);
}
