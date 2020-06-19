import 'package:flutter/material.dart';
import 'package:ps_flutter/Screens/solicitacoes_screen.dart';
import 'package:ps_flutter/screens/chat_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SolicitacoesScreen(),
         '/chat_screen': (context) => ChatScreen(),
          //'/chat_screen_lista_mensagem' : (context) => ChatScreenListaMensagem(),
      },
      title: 'Chatbot app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

