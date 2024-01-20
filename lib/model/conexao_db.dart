import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ConexaoDb {
  
  Future setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_cadastro');
    var database = await openDatabase(path,version: 1,onCreate: _onCreateDatabase);
    return database;
  }
  Future _onCreateDatabase(Database database, int version)async{
    String sql = "CREATE TABLE usuarios ( id INTEGER PRIMARY KEY,name TEXT,description TEXT);";
    await database.execute(sql);
  }
}

