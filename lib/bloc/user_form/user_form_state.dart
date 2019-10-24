import 'package:flutter_crud_with_bloc_library/model/user_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserFormState {
  final User user;

  UserFormState({this.user});
}
  
class InitialUserFormState extends UserFormState {}

class Loading extends UserFormState {}

class Loaded extends UserFormState {
  Loaded({User user}) : super(user: user);
}
