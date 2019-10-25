import 'package:flutter_crud_with_bloc_library/model/user_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserListState {
  final List<User> users;
  final String error;

  UserListState({this.users, this.error});
}
  
class InitialUserListState extends UserListState {}

class Loading extends UserListState {}

class Error extends UserListState {
  Error({String error}) : super(error: error);
}

class Loaded extends UserListState {
  Loaded({List<User> users}) : super(users: users);
}