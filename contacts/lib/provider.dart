import 'package:contacts/contacts.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String columnId = 'id';
final String columnName = 'name';
final String columnNumber = 'number';
final String columnImage = 'image';
final String contactTable = 'contact_table';

class ContactsProvider {
  late Database db;

  static final ContactsProvider instance = ContactsProvider._internal();

  factory ContactsProvider() {
    return instance;
  }

  ContactsProvider._internal();

  Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'contacts.db'),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
            CREATE TABLE $contactTable (
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnName TEXT NOT NULL,$columnNumber TEXT NOT NULL,
          $columnImage TEXT NOT NULL
          )
          ''');
    });
  }

  Future<Contacts> insertContact(Contacts contact) async {
    contact.id = await db.insert(contactTable, contact.toMap());
    return contact;
  }

  Future<int> deleteContact(int id) async {
    return await db
        .delete(contactTable, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> contactUpdate(Contacts contact) async {
    return await db.update(contactTable, contact.toMap(),
        where: '$columnId = ?', whereArgs: [contact.id]);
  }

  Future<List<Contacts>> getAllContacts() async {
    List<Map<String, dynamic>> contactMaps = await db.query(contactTable);
    if (contactMaps.isEmpty) {
      return [];
    } else {
      List<Contacts> contacts = [];
      for (var element in contactMaps) {
        contacts.add(Contacts.fromMap(element));
      }
      return contacts;
    }
  }

  Future close() async => db.close();
}
