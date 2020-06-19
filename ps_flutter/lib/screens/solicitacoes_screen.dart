import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ps_flutter/model/chat_model.dart';
import 'package:ps_flutter/repository/chat_repository.dart';

class SolicitacoesScreen extends StatefulWidget {
  @override
  _SolicitacoesScreen createState() => _SolicitacoesScreen();
}

class _SolicitacoesScreen extends State<SolicitacoesScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ChatRepository chatRepository = ChatRepository();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff171719),
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.dark ,
        backgroundColor: Color(0xff171719),
        title: Text("Solicitações"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal:23),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight:Radius.circular(30),
          ),
           color: Colors.white,
        ),
        child: FutureBuilder<List>(
          future: chatRepository.findAll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data.length > 0) {
                return buildListView(snapshot.data);
              } else {
                return Center(
                  child: Text("Nenhuma solicitação encontrada!"),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor:  Color(0xff171719),
        child: Icon(Icons.chat),
        onPressed: () async {
          var retorno = await Navigator.pushNamed(context, "/chat_screen");
          if (retorno != null) {
            setState(() {});
            scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text(retorno),
            ));
          }
        },
      ),
    );
  }

  ListView buildListView(List<ChatModel> chat) {
    return ListView.builder(
      itemCount: chat == null ? 0 : chat.length,
      itemBuilder: (BuildContext ctx, int index) {
        return Dismissible(
          key: Key(chat[index].id.toString()),
          child: cardSolicitacao(chat[index]),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            ChatRepository().delete(chat[index]);
            setState(() {});
          },
          background: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: AlignmentDirectional.centerEnd,
              color: Colors.redAccent,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Card cardSolicitacao(ChatModel chat) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 15.0,
      margin: new EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 9.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color:  Color.fromRGBO(0, 108, 250, 0.98),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
              border: new Border(
                right: new BorderSide(
                  width: 2.0,
                  color: Colors.white54,
                ),
              ),
            ),
            child: Icon(
              Icons.sync,
              color: Colors.white,
            ),
          ),
          title: Text(
            "Solicitação " + chat.id.toString(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  child: Text(
                    chat.status,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Text(
                    "tipo: " + chat.tipo,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
