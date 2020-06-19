// To parse this JSON data, do
//
//     final chatModel = chatModelFromMap(jsonString);

import 'dart:convert';

class ChatModel {
    ChatModel({
        this.id,
        this.nome,
        this.tipo,
        this.status,
        this.conteudo,
    });

    int id;
    String nome;
    String tipo;
    String status;
    String conteudo;
 



    factory ChatModel.fromJson(String str) => ChatModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ChatModel.fromMap(Map<String, dynamic> json) => ChatModel(
        id: json["id"],
        nome: json["nome"],
        tipo: json["tipo"],
        status: json["status"],
        conteudo: json["Conteudo"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "nome": nome,
        "tipo": tipo,
        "status": status,
        "Conteudo": conteudo,
    };

 
}
