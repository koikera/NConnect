import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nconnect/constants/constants.dart';
import 'package:nconnect/forms/novoGrupoForm.dart';
import 'package:nconnect/models/groupModel.dart';

class ChatListWidget extends StatefulWidget {
  const ChatListWidget({super.key});

  @override
  State<ChatListWidget> createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<ChatListWidget> {
  
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  Future<List<dynamic>> GetAllChats() async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('chats')
        .where('Permissoes', arrayContains: user?.email)
        .get();

    final List<dynamic> listaConversa = [];

    for (final documento in querySnapshot.docs) {
      final data = documento.data() as Map<String, dynamic>?;
      if (data != null) {
        final conversa = data['Conversa'] as Map<String, dynamic>?;

        if (conversa != null) {
          // Itera pelos valores do mapa e os adiciona à lista
          conversa.forEach((key, value) {
            listaConversa.add(value);
          });
        }
      }
    }

    return listaConversa;
  }

final List<Widget> listTiles = [];


  Future<ListView> ValidarUsuario() async {
    final List<Widget> listTiles = [];
    final QuerySnapshot querySnapshot = await firestore.collection('chats').where('Permissoes', arrayContains: user?.email).get();
    final List<QueryDocumentSnapshot> documentos = querySnapshot.docs;

    if(documentos.isNotEmpty){
      final List<QueryDocumentSnapshot> documentos = querySnapshot.docs;

    // Lista para armazenar os ListTiles

    for (final documento in documentos) {
      final data = documento.data() as Map<String, dynamic>;
      final conversas = data['Conversas'] as Map<String, dynamic>; // Substitua 'Conversas' pelo nome do campo que contém o mapa de conversas.
      final titulo = conversas['Titulo'] as String; // Substitua 'Titulo' pelo nome do campo 'Titulo'.

          listTiles.add(
            ListTile(
              leading: CircleAvatar(child: Text(titulo[0])),
              title: Text(titulo),
              subtitle: const Text("Mensagem"),
              trailing: const Icon(Icons.arrow_circle_right_outlined),
              onTap: () {
                Navigator.pushNamed(context, '/chat');
              },
            ),
          );
        }

      // Agora, você pode usar a lista de ListTiles em seu ListView
      return ListView(
        children: listTiles,
      );
    }

    return ListView(
      children: [],
    );
  }

  Future<void> Logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamed(context, "/dominio");
      print("Usuário deslogado com sucesso.");
    } catch (e) {
      print("Erro ao deslogar: $e");
    }
  }


  String _selectedValue = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("N-Connect", style: TextStyle(color: textColor, fontWeight: FontWeight.w700),),
        backgroundColor: primary,
        actions: [
            PopupMenuButton<String>(
              onSelected: (String value) {
                setState(() {
                  _selectedValue = value;
                });
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  value: '1',
                  child: const ListTile(
                    leading: Icon(Icons.add),
                    title: Text('Novo Grupo'),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return NovoGrupoFormWidget();
                      },
                    );
                  },
                ),
                PopupMenuItem(
                  value: '2',
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Configuracoes'),
                  ),
                ),
                PopupMenuItem(
                  value: '3',
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                  ),
                  onTap: () => {Logout()},
                ),
              ],
            )
          ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Coloque aqui a lógica de atualização dos dados.
          await ValidarUsuario(); // Substitua _refreshData() pela função que atualiza os dados.
        },
        child: FutureBuilder<ListView>(
          future: ValidarUsuario(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            } else {
              return snapshot.data ?? ListView(children: [ListTile(title: Text('Nenhum dado disponível'))]);
            }
          },
        ),
      )
      );
  }
}