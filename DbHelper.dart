import 'package:sqflite/sqflite.dart';
import 'Student.dart';

class Dbhelper {

  Future<Database> getDatabase() async{
    return await openDatabase(
        "${getDatabasesPath()}/app.db",
        version: 1,
        onCreate: (db,version){
          db.execute('''
              CREATE TABLE students (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              fname TEXT ,
              lname TEXT ,
              email TEXT ,
              department TEXT ,
              age INTEGER 
              )
          ''');
        }
    );
  }

  Future<int> addStudent(Student st) async {
    return await (await getDatabase()).insert("students", st.toMap());
  }

  Future<int> updateStudent(Student st) async {
    return await (await getDatabase()).update(
        "students",
        st.toMap(),
        where: "id=?" ,
        whereArgs: [st.id]
    );
  }

  Future<List<Student>> getAllStudent() async{

    final studentMap = await (await getDatabase()).query("students");

    return studentMap.map((map){
      return Student.fromMap(map);
    }).toList();
  }

  Future<int> deleteStudent(Student st) async {
    return await (await getDatabase()).delete(
      "students",
      where: "id=?",
      whereArgs: [st.id]
    );
  }
}