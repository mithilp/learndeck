import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MongoDB {
  static var _db;

  static Future<Db> get db async {
    if (_db == null) {
      await connect();
    }
    return _db!;
  }

  static Future connect() async {
    _db = await Db.create(dotenv.env['MONGODB_URI']!);
    await _db?.open();
  }

  static Future<String> userStage(String email) async {
    var val = await _db
        ?.collection('users')
        .findOne(where.eq("email", email).fields(['email']));
    return val != null
        ? val['username'] != null
            ? val['completed']
                ? "complete"
                : "first_time"
            : "no_username"
        : "new_user";
  }

  static Future<void> addUser(String email) async {
    try {
      await _db?.collection('users').insert({
        "_id": M.ObjectId(),
        'email': email,
        'username': null,
        'completed': false,
      });
    } catch (e) {
      print(e);
    }
  }
}
