import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_book/models/Note.dart';

class DBHelper{

  static Database _db;

  Future<Database> get db async {
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  //Creating a database with name test.dn in your directory
  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "opennote.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  // Creating a table name Employee with fields
  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE Note(id INTEGER PRIMARY KEY, title TEXT, content TEXT )");
    print("Created tables");
  }

  // Retrieving employees from Employee Tables
  Future<List<Note>> getNotes() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Note');
    List<Note> notes = new List();
    for (int i = 0; i < list.length; i++) {
      notes.add(new Note(list[i]["title"], list[i]["content"]));
    }
    print(notes.length);
    return notes;
  }

  /// Inserts or replaces the note.
  void saveNote(Note note) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO Note(title, content) VALUES(' +
              '\'' +
              note.title +
              '\'' +
              ',' +
              '\'' +
              note.content +
              '\'' +
              ')');
    });
  }


}