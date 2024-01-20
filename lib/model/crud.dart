import 'conexao_db.dart';
import 'package:sqflite/sqflite.dart';

class FunctionCrud {
  late ConexaoDb _databaseConnection;
  FunctionCrud() {
    _databaseConnection = ConexaoDb();
  }
  static Database? _database;
  Future get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  insertData(table, data) async {
    var conexao = await database;
    return await conexao?.insert(table, data);
  }

  readData(table) async {
    var conexao = await database;
    return await conexao?.query(table);
  }

  readDataById(table, itemId) async {
    var conexao = await database;
    return await conexao?.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  updateData(table, data) async {
    var conexao = await database;
    return await conexao
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  deleteDataById(table, itemId) async {
    var conexao = await database;
    return await conexao?.rawDelete("delete from usuarios where id = '$itemId'");
  }
}