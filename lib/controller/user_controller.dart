import 'package:local_storage/database/user_database.dart';
import 'package:local_storage/model/user_model.dart';

class UserController {
  final databse = Connection();
  Future<void> insertData(UserModel userModel) async {
    final db = await databse.initializeData();
    await db.insert(databse.table, userModel.fromJson());
  }

  Future<List<UserModel>> getData() async {
    final db = await databse.initializeData();
    List<Map<String, dynamic>> result = await db.query(databse.table);
    return result.map((e) => UserModel.toJson(e)).toList();
  }
}
