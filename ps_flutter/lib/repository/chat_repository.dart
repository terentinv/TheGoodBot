import 'package:ps_flutter/model/chat_model.dart';
import 'package:ps_flutter/repository/database_helper.dart';

class ChatRepository {
  DatabaseHelper _databaseHelper;

  ChatRepository() {
    _databaseHelper = new DatabaseHelper();
  }

  Future<List<ChatModel>> findAll() async {
    var connection = await _databaseHelper.connection;
    var result = await connection.query(
      "ChatModel",
      columns: ["id", "nome", "tipo", "status", "conteudo"],
      
    );

    List<ChatModel> listaChat = new List<ChatModel>();
    for (Map i in result) {
      listaChat.add(ChatModel.fromMap(i));
    }
    return listaChat;
  }

  Future<int> create(ChatModel chatModel) async {
    var connection = await _databaseHelper.connection;
    var result = await connection.insert(
      "ChatModel",
      chatModel.toMap(),
    );
    return result;
  }

  Future<ChatModel> get(int id) async {
    var connection = await _databaseHelper.connection;
    List<Map> results = await connection.query(
      "ChatModel",
      columns: ["id", "nome", "tipo", "status", "conteudo"],
      where: 'id = ?',
      whereArgs: [id],
    );
    if (results.length > 0) {
      return ChatModel.fromMap(results.first);
    } else {
      return null;
    }
  }

  Future<int> delete(ChatModel chatModel) async {
    var connection = await _databaseHelper.connection;
    return await connection.delete(
      "ChatModel",
      where: "id = ?",
      whereArgs: [chatModel.id],
    );
  }
  
}
