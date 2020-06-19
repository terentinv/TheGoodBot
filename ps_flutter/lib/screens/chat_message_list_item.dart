import 'package:flutter/material.dart';
import 'package:ps_flutter/model/chat_message_model.dart';

class ChatMessageListItem extends StatelessWidget {
  final ChatMessage chatMessage;

  ChatMessageListItem({this.chatMessage});

  @override
  Widget build(BuildContext context) {
    return chatMessage.type == 0 ? _showSentMessage() : _showReceivedMessage();
  }

  Widget _showSentMessage({EdgeInsets padding, TextAlign textAlign}) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(64.0, 0.0, 8.0, 0.0),
      trailing: CircleAvatar(
        child: Text(chatMessage.name.toUpperCase()[0]),
        backgroundColor: Color.fromRGBO(0, 108, 250, 0.98),
      ),
      title: Text(chatMessage.name, textAlign: TextAlign.right),
      subtitle: Text(chatMessage.texto, textAlign: TextAlign.right),
    );
  }

  Widget _showReceivedMessage() {
    if (chatMessage.type == null) {
      chatMessage.name = "ChatBot";
      chatMessage.texto = "teste";
      chatMessage.type = 1;
    }
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 64.0, 0.0),
      leading: CircleAvatar(
        child: Text(chatMessage.name.toUpperCase()[0]),
        backgroundColor: Color.fromRGBO(0, 108, 250, 0.98),
      ),
      title: Text(chatMessage.name, textAlign: TextAlign.left),
      subtitle: Text(chatMessage.texto, textAlign: TextAlign.left),
    );
  }
}
