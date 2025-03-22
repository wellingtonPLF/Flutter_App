import 'package:my_app/app/shared/enum/database/book.enum.dart';
import 'package:my_app/app/shared/utils/general.util.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'dart:developer' as developer;
import 'package:sqflite/sqflite.dart';

class PersistentStorage {
  static final PersistentStorage _instance = PersistentStorage.internal();
  factory PersistentStorage() => _instance;
  PersistentStorage.internal();
  Database? database;

  Future<Database> get db async {
    if (database != null) {
      return database!;
    } else {
      database = await initDb();
      return database!;
    }
  }

  Future<Database> initDb() async {
    developer.log('Local Database Config loading...', name: GeneralUtils().getCurrentFileName(StackTrace.current));

    String databaseName = 'local_database_myApp.db';
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, databaseName);

    var openDB = await openDatabase(path, version: 2, onCreate: (Database db, int newerVersion) async {
      await db.execute('''
        CREATE TABLE ${Book.fromString('table')}(
          ${Book.fromString('id')} INTEGER PRIMARY KEY AUTOINCREMENT, 
          ${Book.fromString('title')} TEXT, 
          ${Book.fromString('price')} NUMERIC,
          ${Book.fromString('pages')} INTEGER 
        ); 
      ''');

      developer.log('Local Database Creation Done!', name: GeneralUtils().getCurrentFileName(StackTrace.current));
    }, onUpgrade: (Database db, int oldVersion, int newerVersion) async {
      // await db.execute("ALTER TABLE ${Book.fromString('table')} ADD COLUMN ${Book.fromString('language')} TEXT");
    });
    return openDB;
  }

  Future<dynamic> createBook(dynamic ponto) async {
    Database database = await db;
    ponto.local_id = await database.insert(Book.fromString('table'), ponto.toMap());
    return ponto;
  }

  Future<int> updateBook(dynamic book) async {
    Database database = await db;
    return await database.update(Book.fromString('table'), book.toMap(), where: "${Book.fromString('id')} = ?", whereArgs: [book.id]);
  }

  Future<int> deleteBook(dynamic book) async {
    Database database = await db;
    return await database.delete(Book.fromString('table'), where: "${Book.fromString('id')} = ?", whereArgs: [book.id]);
  }

  Future<List<dynamic>> getAllBooks(int pages) async {
    Database database = await db;
    List result = await database
        .rawQuery("SELECT * FROM ${Book.fromString('table')} WHERE ${Book.fromString('pages')} = $pages ORDER BY ${Book.fromString('id')} DESC");
    return result;
  }
}
