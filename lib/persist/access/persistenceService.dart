import 'dart:async';

import 'package:learn4kids/persist/model/category.dart';
import 'package:learn4kids/persist/model/learningObject.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PersistenceService {
  PersistenceService._();

  static final PersistenceService db = PersistenceService._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    String path = join(await getDatabasesPath(), "LearningObject.db");
    return await openDatabase(path, version: 2,
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
      if (newVersion == 2) {
        await db.execute("CREATE TABLE Category ("
            "id integer primary key AUTOINCREMENT,"
            "categoryName TEXT"
            ")");
      }
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE LearningObject ("
          "id integer primary key AUTOINCREMENT,"
          "questionAudio TEXT,"
          "explanationAudio TEXT"
          ")");
    });
  }

  addCategoryToDatabase(Category category) async {
    final db = await database;
    var raw = await db.insert(
      "Category",
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  Future<List<Category>> getAlCategories() async {
    final db = await database;
    var response = await db.query("Category");
    List<Category> list = response.map((c) => Category.fromMap(c)).toList();
    return list;
  }

  addLearningObjectToDatabase(LearningObject learningObject) async {
    final db = await database;
    var raw = await db.insert(
      "LearningObject",
      learningObject.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  updateLearningObject(LearningObject learningObject) async {
    final db = await database;
    var response = await db.update("LearningObject", learningObject.toMap(),
        where: "id = ?", whereArgs: [learningObject.id]);
    return response;
  }

  Future<LearningObject> getLearningObjectWithId(int id) async {
    final db = await database;
    var response =
        await db.query("LearningObject", where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? LearningObject.fromMap(response.first) : null;
  }

  Future<List<LearningObject>> getAllLearningObjects() async {
    final db = await database;
    var response = await db.query("LearningObject");
    List<LearningObject> list =
        response.map((c) => LearningObject.fromMap(c)).toList();
    return list;
  }

  deleteLearningObjectWithId(int id) async {
    final db = await database;
    return db.delete("LearningObject", where: "id = ?", whereArgs: [id]);
  }

  deleteAllLearningObjects() async {
    final db = await database;
    db.delete("LearningObject");
  }
}
