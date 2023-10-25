import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nconnect/Feedback.dart';
import 'package:nconnect/constants/constants.dart';
import 'package:nconnect/forms/NovoFeedback.dart';
import 'package:nconnect/models/FeedbackModel.dart';
import 'package:nconnect/perfil.dart';

class FeedbackListWidget extends StatefulWidget {
  const FeedbackListWidget({super.key});

  @override
  State<FeedbackListWidget> createState() => _FeedbackListWidgetState();
}

class _FeedbackListWidgetState extends State<FeedbackListWidget> {
  
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isPsicologo = false;


  Future<ListView> GetAllFeedbakcs() async {
    final List<Widget> listTiles = [];
    final QuerySnapshot querySnapshot = await firestore.collection('feedbacks').where('Para', isEqualTo: user?.email).get();
    final List<QueryDocumentSnapshot> documentos = querySnapshot.docs;
    final QuerySnapshot listaPsicologos = await firestore.collection('psicologos').where('ListaPsicologos', arrayContains: user?.email).get();
    final QuerySnapshot listaEnviadoPor = await firestore.collection('feedbacks').where('EnviadoPor', isEqualTo: user?.email).get();

    if(listaPsicologos.docs.isNotEmpty){
      isPsicologo = true;
      if(documentos.isNotEmpty){
        final List<QueryDocumentSnapshot> documentos = querySnapshot.docs;

        // Lista para armazenar os ListTiles

        for (final documento in documentos) {
          final data = documento.data() as Map<String, dynamic>;// Substitua 'Conversas' pelo nome do campo que contém o mapa de conversas.
          final EnviadoPor = data['EnviadoPor'] as String; // Substitua 'Titulo' pelo nome do campo 'Titulo'.// Substitua 'Titulo' pelo nome do campo 'Titulo'.
          final Feedback = data['Feedback'] as String; // Substitua 'Titulo' pelo nome do campo 'Titulo'.// Substitua 'Titulo' pelo nome do campo 'Titulo'.
          final Para = data['Para'] as String; // Substitua 'Titulo' pelo nome do campo 'Titulo'.// Substitua 'Titulo' pelo nome do campo 'Titulo'.
          final Nota = data['Nota'] as int; // Substitua 'Titulo' pelo nome do campo 'Titulo'.// Substitua 'Titulo' pelo nome do campo 'Titulo'.
          final FeedbackModel feedbackModel = new FeedbackModel(EnviadoPor: EnviadoPor, Feedback: Feedback, Nota: Nota, Para: Para);
            
              listTiles.add(
                ListTile(
                  leading: CircleAvatar(child: Text(EnviadoPor[0].toUpperCase())),
                  title: Text(EnviadoPor),
                  subtitle: Row(
                    children: List.generate(5, (index) {
                      return Icon(
                          index < Nota ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                        );
                    }),
                  ),
                  trailing: const Icon(Icons.arrow_circle_right_outlined),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FeedbackWidget(feedbackModel: feedbackModel),
                      ),
                    );
                  },
                ),
              );
            }

          // Agora, você pode usar a lista de ListTiles em seu ListView
          return ListView(
            children: listTiles,
          );
        }
    } else {
      if(listaEnviadoPor.docs.isNotEmpty){
        for (final documento in documentos) {
          final data = documento.data() as Map<String, dynamic>;// Substitua 'Conversas' pelo nome do campo que contém o mapa de conversas.
          final EnviadoPor = data['EnviadoPor'] as String; // Substitua 'Titulo' pelo nome do campo 'Titulo'.// Substitua 'Titulo' pelo nome do campo 'Titulo'.
          final Feedback = data['Feedback'] as String; // Substitua 'Titulo' pelo nome do campo 'Titulo'.// Substitua 'Titulo' pelo nome do campo 'Titulo'.
          final Para = data['Para'] as String; // Substitua 'Titulo' pelo nome do campo 'Titulo'.// Substitua 'Titulo' pelo nome do campo 'Titulo'.
          final Nota = data['Nota'] as int; // Substitua 'Titulo' pelo nome do campo 'Titulo'.// Substitua 'Titulo' pelo nome do campo 'Titulo'.
          final FeedbackModel feedbackModel = new FeedbackModel(EnviadoPor: EnviadoPor, Feedback: Feedback, Nota: Nota, Para: Para);
            
              listTiles.add(
                ListTile(
                  leading: CircleAvatar(child: Text(Para[0].toUpperCase())),
                  title: Text(Para),
                  subtitle: Row(
                    children: List.generate(5, (index) {
                      return Icon(
                          index < Nota ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                        );
                    }),
                  ),
                  trailing: const Icon(Icons.arrow_circle_right_outlined),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FeedbackWidget(feedbackModel: feedbackModel),
                      ),
                    );
                  },
              ),
            );
          }
          return ListView(
            children: listTiles,
          );
      }
    }


    return ListView(
      children: [],
    );
  }


  Future<void> Logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamed(context, "/login");
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
        title: const Text("Feedbacks", style: TextStyle(color: textColor, fontWeight: FontWeight.w700),),
        backgroundColor: primary,
        actions: [
            PopupMenuButton<String>(
              onSelected: (String value) {
                setState(() {
                  _selectedValue = value;
                });
              },
              itemBuilder: (BuildContext context) {
                if (!isPsicologo) {
                  return [
                    PopupMenuItem(
                      value: '1',
                      child: const ListTile(
                        leading: Icon(Icons.add),
                        title: Text('Novo Feedback'),
                      ),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return NovoFeedbackWidget();
                          },
                        );
                      },
                    ),
                    PopupMenuItem(
                      value: '2',
                      child: const ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Perfil'),
                      ),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PerfilWidget(isPsicologo: isPsicologo),
                          ),
                        );
                      },
                    ),
                    PopupMenuItem(
                      value: '3',
                      child: const ListTile(
                        leading: Icon(Icons.logout),
                        title: Text('Logout'),
                      ),
                      onTap: () => {Logout()},
                    ),
                  ];
                } else {
                  return [
                    PopupMenuItem(
                      value: '2',
                      child: const ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Perfil'),
                      ),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PerfilWidget(isPsicologo: isPsicologo),
                          ),
                        );
                      },
                    ),
                    PopupMenuItem(
                      value: '3',
                      child: const ListTile(
                        leading: Icon(Icons.logout),
                        title: Text('Logout'),
                      ),
                      onTap: () => {Logout()},
                    ),
                  ];
                }
              },
            )
          ]
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Coloque aqui a lógica de atualização dos dados.
          await GetAllFeedbakcs(); // Substitua _refreshData() pela função que atualiza os dados.
        },
        child: FutureBuilder<ListView>(
          future: GetAllFeedbakcs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            } else {
              return snapshot.data ?? ListView(children: const [ ListTile(title: Text('Nenhum dado disponível'))]);
            }
          },
        ),
      )
      );
  }
}