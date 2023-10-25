import 'package:cloud_firestore/cloud_firestore.dart';

class Conversa {
  Map<String, dynamic> chat;
  String titulo;
  List<String> permissoes;

  Conversa({
    required this.chat,
    required this.titulo,
    required this.permissoes,
  });


  // Construtor para criar a partir de um mapa (para ler dados do Firestore)
  Conversa.fromMap(Map<String, dynamic> map, String id) : 
        chat = map['Chat'],
        titulo = map['Titulo'],
        permissoes = List<String>.from(map['Permissoes']);

  // Função para converter para um mapa (para escrever dados no Firestore)
  Map<String, dynamic> toMap() {
    return {
      'Conversas': {
        'Chat': chat,
        'Titulo': titulo,
      },
      'Permissoes': permissoes,
    };
  }

}