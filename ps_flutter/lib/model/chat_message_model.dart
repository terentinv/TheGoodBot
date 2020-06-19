
import 'dart:convert';


class ChatMessage {
    ChatMessage({
        this.id,
        this.name,
        this.texto,
        this.type,
       
           });

     int id;
     String name;
     String texto;
     int type;
     

    factory ChatMessage.fromJson(String str) => ChatMessage.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ChatMessage.fromMap(Map<String, dynamic> json) => ChatMessage(
        id: json["id"],
        name: json["name"],
        texto: json["texto"],
        type: json["type"],
        
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "texto": texto,
        "type": type,
        
    };
}
