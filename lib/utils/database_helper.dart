import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper() {
    openMyDatabase();
  }

  late Database database;

  Future<Database> openMyDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'password_manager.db');
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        db.execute('''CREATE TABLE password_manager (
	id	INTEGER NOT NULL UNIQUE,
	company	TEXT,
	password	TEXT,
	PRIMARY KEY(id AUTOINCREMENT)
)''');
      },
    );
    return database;
  }

  Future<int> insertData(String company, String password) async {
    int value = await database.insert(
      "password_manager",
      {
        "company": company,
        "password": password,
      },
    );
    return value;
  }

  Future<int> editData(String company, String password, int id) async {
    int value = await database.update(
      "password_manager",
      {
        "company": company,
        "password": password,
      },
      where: "id = ?",
      whereArgs: [id],
    );
    return value;
  }

  void deleteData(int id) {
    database.delete(
      "password_manager",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<List<PasswordsClass>> getAllData() async {
    List<PasswordsClass> passwordData = [];

    List<Map<String, dynamic>> data = await database.query("password_manager");
    for (Map<String, dynamic> element in data) {
      passwordData.add(
        PasswordsClass(
          id: element["id"],
          company: "${element["company"]}",
          password: "${element["password"]}",
        ),
      );
    }
    return passwordData;
  }
}

class PasswordsClass {
  final int id;
  final String company;
  final String password;

  PasswordsClass({
    required this.id,
    required this.company,
    required this.password,
  });
}
