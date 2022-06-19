import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PasswordClass {
  String? company;
  String? password;

  PasswordClass({
    this.company,
    this.password,
  });
}

class DataBaseManager {
  DataBaseManager() {
    init();
  }

  Database? database;

  Future<int> init() async {
    String path = join(await getDatabasesPath(), "database.db");
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) {
        return db.execute(
          "CREATE TABLE SavePassword(id INTEGER PRIMARY KEY,company TEXT,password TEXT)",
        );
      },
    );
    print("Database initialized");
    return 1;
  }

  addPassword(String company, String password) {
    database!.insert(
      "SavePassword",
      {"company": company, "password": password},
    );
  }

  updatePassword(String company, String password) {
    database!.update(
      "SavePassword",
      {"password": password},  
      where: "company = ?",
      whereArgs: [company]
    );
  }

  Future<void> deletePassword(String company) async {
    print("company = $company==");
    try{
      await database!.delete(
      "SavePassword",
      where: "company = ?",
      whereArgs: [company],
    );
    }
    catch(e){
      print("ERROR ===============>$e<===========");
    }
    
  }

  Future<List<PasswordClass>> getData() async {
    List<PasswordClass> dataList = [];
    await database!.query("SavePassword").then((value) {
      for (int i = 0; i < value.length; i++) {
        dataList.add(
          PasswordClass(
            company: value[i]["company"].toString(),
            password: value[i]["password"].toString(),
          ),
        );
      }
    });
    return dataList;
  }
}
