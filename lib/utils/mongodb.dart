import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sample/utils/models/chapter.dart';
import 'package:sample/utils/models/course.dart';
import 'package:sample/utils/models/unit.dart';
import 'package:sample/utils/models/user.dart';
import 'package:sample/utils/models/question.dart';

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
        : User(email: email, username: '', completed: false, stage: 'new_user');
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

  static Future<List<Unit>> getUnits(String courseId) async {
    var val = await _db
        ?.collection('courses')
        .findOne(where.eq('_id', ObjectId.fromHexString(courseId)).fields([
          'units',
        ]));

    final List unitIds = val['units'] as List;
    final List<Unit> units = [];

    for (var unit in unitIds) {
      var response = await _db?.collection('units').findOne(where
          .eq('_id', ObjectId.fromHexString(unit))
          .fields(['chapters', 'title']));

      var chapterIds =
          (response['chapters'] as List).map((item) => item as String).toList();

      final List<Chapter> chapters = [];

      for (var chapter in chapterIds) {
        var response = await _db?.collection('chapters').findOne(where
            .eq('_id', ObjectId.fromHexString(chapter))
            .fields(['title', 'summary', 'video', 'quiz']));

        var chap = Chapter(
          id: (response['_id'] as ObjectId).oid,
          title: response['title'],
          summary: response['summary'],
          video: response['video'],
          questionIds:
              (response['quiz'] as List).map((item) => item as String).toList(),
        );
        print(chap.video);
        chapters.add(Chapter(
          id: (response['_id'] as ObjectId).oid,
          title: response['title'],
          summary: response['summary'],
          video: response['video'],
          questionIds:
              (response['quiz'] as List).map((item) => item as String).toList(),
        ));
      }

      units.add(Unit(
          id: (response['_id'] as ObjectId).oid,
          title: response['title'],
          chapters: chapters));
    }

    return units;
  }

  static Future<List<Question>> getQuestions(List<String>? questionIds) async {

    if (questionIds == null) {
      throw Exception('Questions ids are null');
    }
    final List<Question> questions = [];

    for (var question in questionIds) {
      var response = await _db?.collection('questions').findOne(where
          .eq('_id', ObjectId.fromHexString(question))
          .fields([ 'text', 'answer', 'explanation', 'choices']));

      questions.add(Question(
          id: (response['_id'] as ObjectId).oid,
          text: response['text'],
          answer: response['answer'],
          explanation: response['explanation'],
          choices: (response['choices'] as List)
              .map((item) => item as String)
              .toList()));
    }

    return questions;
  }

  static Future<Course> getFeatured(String username) async {
    try {
      var val = await _db
          ?.collection('courses')
          .findOne(where.eq('featured', true).fields([
            'title',
            'author',
            'units',
            'image',
            '${username}_library',
            '${username}_progress'
          ]));

      return val != null
          ? Course(
              id: (val['_id'] as ObjectId).oid,
              title: val['title'],
              author: val['author'],
              unitIds:
                  (val['units'] as List).map((item) => item as String).toList(),
              image: val['image'],
              added: val['${username}_library'],
              progress: val['${username}_progress'])
          : Course(
              id: '',
              title: '',
              author: '',
              units: [],
              image: '',
              added: false,
              progress: 0);
    } catch (e) {
      print(e);
      return Course(
          id: '',
          title: '',
          author: '',
          units: [],
          image: '',
          added: false,
          progress: 0);
    }
  }

  static Future<void> addCourse(Course course) async {
    List<String> unitIds = [];
    course.units?.forEach((unit) {
      unitIds.add(unit.id);
    });
    await _db?.collection('courses').insert({
      '_id': M.ObjectId.fromHexString(course.id),
      'title': course.title,
      'author': course.author,
      'completed': false,
      'image': course.image,
      '${course.author}_library': true,
      '${course.author}_progress': 0,
      'units': unitIds,
    });

    for (var unit in course.units!) {
      List<String> chapterIds = [];
      unit.chapters?.forEach((chapter) {
        chapterIds.add(chapter.id);
      });
      await _db?.collection('units').insert({
        '_id': M.ObjectId.fromHexString(unit.id),
        'title': unit.title,
        'chapters': chapterIds,
      });

      for (var chapter in unit.chapters!) {
        List<String> questionIds = [];
        chapter.questions?.forEach((question) {
          questionIds.add(question.id);
        });

        await _db?.collection('chapters').insert({
          '_id': M.ObjectId.fromHexString(chapter.id),
          'title': chapter.title,
          'summary': chapter.summary,
          'video': chapter.video,
          'quiz': questionIds,
        });

        for (var question in chapter.questions!) {
          await _db?.collection('questions').insert({
            '_id': M.ObjectId.fromHexString(question.id),
            'text': question.text,
            'answer': question.answer,
            'explanation': question.explanation,
            'choices': question.choices,
          });
        }
      }
    }
  }

  static Future<List<Course>> getStarred(String username) async {
    print("entered");
    var values = await _db?.collection('courses').find(
        where.eq('${username}_library', true).fields(['title', 'author', 'units','image','${username}_library','${username}_progress']));
    List<Course> courses = [];
    values = await values.toList();
    print(values[0]);

    if(values == null) {
      courses = [Course(id: "", title: '', author: '', units: [], image: '', added: false, progress: 0)];
    } else {
      print("searching for courses in library");
      for (var val in values) {
        print("found course");
        courses.add(Course(
            id: (val['_id'] as ObjectId).oid,
            title: val['title'],
            author: val['author'],
            unitIds:
            (val['units'] as List).map((item) => item as String).toList(),
            image: val['image'],
            added: val['${username}_library'],
            progress: val['${username}_progress'])
        );
        print(courses);
      };
    }

    return courses;
  }
}
