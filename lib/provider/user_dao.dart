import 'package:flutter_crud_with_bloc_library/database/database.dart';
import 'package:flutter_crud_with_bloc_library/model/user_model.dart';

class UserDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<List<User>> getUsers({List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null && query != '') {
      if (query.isNotEmpty) {
        result = await db.query(userTable,
            columns: columns, where: 'name LIKE ?', whereArgs: ['%$query%']);
      }
    } else {
      result = await db.query(userTable, columns: columns);
    }

    List<User> users = result.isNotEmpty
        ? result.map((user) => User.fromJson(user)).toList()
        : [];
    return users;
  }

  Future<User> getUser({List<String> columns, int id}) async {
    final db = await dbProvider.database;

    var result = await db.query(userTable, columns: columns, where: 'id = ?', whereArgs: [id]);

    List<User> users = result.isNotEmpty ? result.map((user) => User.fromJson(user)).toList() : [];
    User user = users.isNotEmpty ? users[0] : null;

    return user;
  }

  Future<int> createUser(User user) async {
    final db = await dbProvider.database;

    var result = await db.insert(userTable, user.toJson());

    return result;
  }

  Future<int> updateUser(User user) async {
    final db = await dbProvider.database;

    var result = await db.update(userTable, user.toJson(),
        where: 'id = ?', whereArgs: [user.id]);

    return result;
  }

  Future<int> deleteUser(int id) async {
    final db = await dbProvider.database;

    var result = await db.delete(userTable, where: 'id = ?', whereArgs: [id]);

    return result;
  }
}
