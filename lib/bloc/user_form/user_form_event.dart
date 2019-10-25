import 'package:flutter_crud_with_bloc_library/model/user_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserFormEvent {
  final User user;

  UserFormEvent({this.user});
}

class BackEvent extends UserFormEvent {}

class GetUser extends UserFormEvent {
  GetUser({User user}) : super(user: user);
}

class CreateUser extends UserFormEvent {
  CreateUser({@required User user}) : super(user: user);
}

class UpdateUser extends UserFormEvent {
  UpdateUser({@required User user}) : super(user: user);
}
