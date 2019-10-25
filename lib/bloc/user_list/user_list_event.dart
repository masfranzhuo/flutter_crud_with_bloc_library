import 'package:flutter_crud_with_bloc_library/model/user_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserListEvent {
  final User user;
  final String query;

  UserListEvent({this.user, this.query});
}

class GetUsers extends UserListEvent {
  GetUsers({String query}) : super(query: query);
}

class DeleteUser extends UserListEvent {
  DeleteUser({@required User user}) : super(user: user);
}
