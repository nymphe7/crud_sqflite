import 'dart:io';

import 'package:crudy/model/contact.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(documentsDirectory.path, 'data.db');
    return await openDatabase(dbPath, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE information(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  mobile TEXT
)
''');
  }

  Future<List<Contact>> getContacts() async {
    Database db = await instance.database;
    var contacts = await db.query('information', orderBy: 'name');
    List<Contact> contactList = contacts.isNotEmpty
        ? contacts.map((e) => Contact.fromMap(e)).toList()
        : [];
    return contactList;
  }

// `conflictAlgorithm` to use in case the same breed is inserted twice.
// In this case, replace any previous data.
  Future<int> addContact(Contact contact) async {
    Database db = await instance.database;
    return await db.insert('information', contact.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> removeContact(int id) async {
    Database db = await instance.database;
    return await db.delete('information', where: 'id=?', whereArgs: [id]);
  }

  Future<int> updateContact(Contact contact) async {
    Database db = await instance.database;
    return await db.update('information', contact.toMap(),
    where: 'id = ?',whereArgs: [contact.id]);
  }
}
