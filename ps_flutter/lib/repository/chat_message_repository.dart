import 'package:ps_flutter/model/chat_message_model.dart';
import 'package:ps_flutter/repository/database_helper.dart';

class ChatMessageRepository {
  DatabaseHelper _databaseHelper;

  ChatMessageRepository() {
    _databaseHelper = new DatabaseHelper();
  }

  Future<List<ChatMessage>> findAll() async {
    var connection = await _databaseHelper.connection;
    var result = await connection.query("ChatMessage",
        columns: ["id", "name", "type", "texto"], orderBy: "id DESC");

    List<ChatMessage> listaChat = new List<ChatMessage>();
    for (Map i in result) {
      listaChat.add(ChatMessage.fromMap(i));
    }
    return listaChat;
  }

  Future<int> create(ChatMessage chatMessage) async {
    var connection = await _databaseHelper.connection;
    var result = await connection.insert(
      "ChatMessage",
      chatMessage.toMap(),
    );
    return result;
  }

  Future<ChatMessage> get(int id) async {
    var connection = await _databaseHelper.connection;
    List<Map> results = await connection.query(
      "ChatMessage",
      columns: ["id", "name", "type", "text"],
      where: 'id = ?',
      whereArgs: [id],
    );
    if (results.length > 0) {
      return ChatMessage.fromMap(
        results.first,
      );
    } else {
      return null;
    }
  }
}
