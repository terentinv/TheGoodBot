import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ps_flutter/model/chat_message_model.dart';
import 'package:ps_flutter/model/chat_model.dart';
import 'package:ps_flutter/repository/chat_message_repository.dart';
import 'package:ps_flutter/repository/chat_repository.dart';

import 'chat_message_list_item.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageList = <ChatMessage>[];

  final _controllerText = new TextEditingController();
  ChatMessage chatMessage = new ChatMessage();
  ChatModel chatModel = new ChatModel();
  ChatRepository chatRepository = new ChatRepository();
  ChatMessageRepository chatMessageRepository = new ChatMessageRepository();

  @override
  void dispose() {
    super.dispose();
    _controllerText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff171719),
      appBar: new AppBar(
        brightness: Brightness.dark,
        backgroundColor: Color(0xff171719),
        title: Text('Chatbot'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 23),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Colors.white,
        ),
        child: FutureBuilder<List>(
          future: chatMessageRepository.findAll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data.length > 0) {
                return Column(
                  children: <Widget>[
                    Flexible(
                      child: _buildListView(snapshot.data),
                    ),
                    Divider(height: 1.0),
                    _buildUserInput(),
                  ],
                );
              } else {
                return Column(
                  children: <Widget>[
                    Flexible(
                      child: _buildListView(snapshot.data),
                    ),
                    Divider(height: 1.0),
                    _buildUserInput(),
                  ],
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  // Cria a lista de mensagens (de baixo para cima)
  ListView _buildListView(chat) {
    return ListView.builder(
      padding: EdgeInsets.all(8.0),
      reverse: true,
      itemBuilder: (_, int index) {
        return ChatMessageListItem(chatMessage: chat[index]);
      },
      itemCount: chat == null ? 0 : chat.length,
    );
  }

  // Envia uma mensagem com o padrão a direita
  Future _sendMessage({String text}) async {
    _controllerText.clear();

    chatMessage.name = "Cliente";
    chatMessage.type = 0;
    chatMessage.texto = text;

    _addMessage(
        name: chatMessage.name,
        text: chatMessage.texto,
        type: chatMessage.type);
  }

  // Adiciona uma mensagem na lista de mensagens
  Future _addMessage({String name, String text, int type}) async {
    var message = ChatMessage(texto: text, name: name, type: type);

    setState(() {
      _messageList.insert(_messageList.length, message);
    });

    if (type == 0) {
      // Envia a mensagem para o chatbot e aguarda sua resposta
      _dialogoChatBot(query: chatMessage.texto);
    }
  }

  // Método dialogo do chatbot
  Future _dialogoChatBot({String query}) async {
    if (query.toLowerCase() == "oi" ||
        query.toLowerCase() == "olá" ||
        query.toLowerCase() == "ola") {
      _addMessage(
          name: "ChatBot",
          text: "Olá satisfação, meu nome é ChatBot, em que posso ajudar?",
          type: 1);
    } else if (query.toLowerCase().contains("depressão") ||
        query.toLowerCase().contains("depressao") ||
        query.toLowerCase().contains("solidão") ||
        query.toLowerCase().contains("solidao") ||
        query.toLowerCase().contains("só") ||
        query.toLowerCase().contains("so") ||
        query.toLowerCase().contains("solitario") ||
        query.toLowerCase().contains("solitário") ||
        query.toLowerCase().contains("1")) {
      if (query.toLowerCase().contains("oi") ||
          query.toLowerCase().contains("ola") ||
          query.toLowerCase().contains("olá")) {
        _addMessage(
            name: "ChatBot",
            text: "Olá!! Satisfação, eu sou o ChatBot!! \n\n Você sabia que o CVV – Centro de Valorização da Vida realiza apoio emocional e prevenção do suicídio, atendendo voluntária e gratuitamente todas as pessoas que querem e precisam conversar, sob total sigilo por telefone, email e chat 24 horas todos os dias?\n\n" +
                "Caso queira conversar, digite Confirmar Solicitação e em breve um voluntário entrará em contato com você!\n" +
                "Caso você não queira solicitar uma conversa, por favor, digite menu",
            type: 1);
      } else {
        _addMessage(
            name: "ChatBot",
            text: "Você sabia que o CVV – Centro de Valorização da Vida realiza apoio emocional e prevenção do suicídio, atendendo voluntária e gratuitamente todas as pessoas que querem e precisam conversar, sob total sigilo por telefone, email e chat 24 horas todos os dias?\n\n" +
                "Caso queira conversar, digite Confirmar Solicitação e em breve um voluntário entrará em contato com você!\n" +
                "Caso você não queira solicitar uma conversa, por favor, digite menu",
            type: 1);
      }

      chatModel.nome = chatMessage.name;
      chatModel.status = "Em andamento";
      chatModel.conteudo = chatMessage.texto;
      chatModel.tipo = "depressao";
    } else if (query.toLowerCase().contains("abuso") ||
        query.toLowerCase().contains("abusada") ||
        query.toLowerCase().contains("abusado") ||
        query.toLowerCase().contains("agressão") ||
        query.toLowerCase().contains("agressao") ||
        query.toLowerCase().contains("agredido") ||
        query.toLowerCase().contains("agredida") ||
        query.toLowerCase().contains("2")) {
      if (query.toLowerCase().contains("oi") ||
          query.toLowerCase().contains("ola") ||
          query.toLowerCase().contains("olá")) {
        _addMessage(
            name: "ChatBot",
            text:
                "Olá sua solicitação de ajuda será encaminhada para as autoridades competentes\n se você deseja prosseguir com a denúncia digite confirmar solicitação, caso contrário digite menu!",
            type: 1);
      } else {
        _addMessage(
            name: "ChatBot",
            text:
                "Sua solicitação de ajuda será encaminhada para as autoridades competentes\n se você deseja prosseguir com a denúncia digite confirmar solicitação, caso contrário digite menu!",
            type: 1);
      }
      chatModel.nome = chatMessage.name;
      chatModel.status = "Em andamento";
      chatModel.conteudo = chatMessage.texto;
      chatModel.tipo = "abuso";
    } else if (query.toLowerCase().contains("menu")) {
      _addMessage(
          name: "ChatBot",
          text: "Menu - \n\n" +
              "1- Depressão e solidão \n" +
              "2- Denunciar um abuso \n",
          type: 1);
    } else if (query.toLowerCase() == "confirmar solicitacao" ||
        query.toLowerCase() == "confirmar solicitação" ||
        query.toLowerCase() == "confirmar solicitaçao" ||
        query.toLowerCase() == "confirmar solicitacão") {
      if (chatModel.tipo == null ||
          chatModel.status == null ||
          chatModel.tipo == "null" ||
          chatModel.conteudo == "null") {
        chatModel.status = "Concluido";
        chatModel.conteudo = query;
        chatModel.tipo = "Não selecionado";
      }

      chatRepository.create(chatModel);
      Navigator.pop(context, true);
    } else {
      _addMessage(
          name: "ChatBot",
          text:
              "Infelizmente não consigo te ajudar com isso ainda :(\n Porém eu posso te ajuda com um dos tópicos abaixo!!\n\n" +
                  "1- Depressão e solidão \n" +
                  "2- Denunciar um abuso \n",
          type: 1);
    }
  }

  // Campo para escrever a mensagem
  Widget _buildTextField() {
    return new Flexible(
      child: new TextFormField(
        controller: _controllerText,
        autofocus: false,
        onSaved: (value) {
          chatMessage.texto = value;
        },
        decoration: new InputDecoration.collapsed(
          hintText: "Enviar mensagem",
        ),
      ),
    );
  }

  // Botão para enviar a mensagem
  Widget _buildSendButton() {
    return new Container(
      margin: new EdgeInsets.only(left: 8.0),
      child: new IconButton(
          icon: new Icon(Icons.send, color: Theme.of(context).accentColor),
          onPressed: () {
            if (_controllerText.text.isNotEmpty) {
              _sendMessage(text: _controllerText.text);
              for (int i = 0; i < _messageList.length; i++) {
                chatMessage = _messageList[i];

                chatMessageRepository.create(chatMessage);
              }
              _messageList.clear();
            }
          }),
    );
  }

  // Monta uma linha com o campo de text e o botão de enviao
  Widget _buildUserInput() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: new Row(
        children: <Widget>[
          _buildTextField(),
          _buildSendButton(),
        ],
      ),
    );
  }
}
