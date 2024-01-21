import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sample/utils/models/course.dart';
import 'package:sample/utils/models/unit.dart';
import 'package:sample/utils/models/user.dart';

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

  static String userStage(Map user) {
    return user['username'] != ''
        ? user['completed']
            ? 'complete'
            : 'first_time'
        : 'no_username';
  }

  static Future<User> getUser(String email) async {
    var val = await _db?.collection('users').findOne(
        where.eq('email', email).fields(['email', 'username', 'completed']));
    return val != null
        ? User(
            email: email,
            username: val['username'],
            completed: val['completed'],
            stage: userStage(val))
        : User(
            email: email,
            username:  "",
            completed:  false,
            stage:  'new_user');
  }

  static Future<void> addUser(String email) async {
    try {
      await _db?.collection('users').insert({
        '_id': M.ObjectId(),
        'email': email,
        'username': '',
        'completed': false,
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<void> addUsername(String email, String username) async {
    try {
      await _db?.collection('users').update(
            where.eq('email', email),
            modify.set('username', username),
          );
    } catch (e) {
      print(e);
    }
  }

  static Future<void> addCompleted(String email) async {
    try {
      await _db?.collection('users').update(
            where.eq('email', email),
            modify.set('completed', true),
          );
    } catch (e) {
      print(e);
    }
  }

  static Future<Course> getFeatured(String username) async {
    var val = await _db?.collection('courses').findOne(
        where.eq('featured', true).fields(['title', 'author', 'units','image','${username}_library','${username}_progress']));

    return val != null
        ? Course(id: '${val["_id"]}', title: val["title"], author: val["author"], unitIds: (val['units'] as List).map((item) => item as String).toList(), image: val['image'], added: val['${username}_library'], progress: val['${username}_progress'])
        : Course(id: "", title: '', author: '', units: [], image: '', added: false, progress: 0);
  }
}
