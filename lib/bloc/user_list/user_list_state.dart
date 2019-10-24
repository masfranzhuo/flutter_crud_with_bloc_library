import 'package:flutter_crud_with_bloc_library/model/user_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserListState {
  final List<User> users;

  UserListState({this.users});
}
  
class InitialUserListState extends UserListState {}

class Loading extends UserListState {}

class Loaded extends UserListState {
  Loaded({List<User> users}) : super(users: users);
}