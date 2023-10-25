import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nconnect/FeedbackList.dart';

class NovoFeedbackWidget extends StatefulWidget {
  @override
  _NovoFeedbackWidgetState createState() => _NovoFeedbackWidgetState();
}

class _NovoFeedbackWidgetState extends State<NovoFeedbackWidget> {
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _ParaController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final List<String> emails = [];
  int rating = 0;

  Future<void> adicionarFeedback() async {
    try {
      // Acesse a instância do Firestore

      // Crie um mapa com os dados que você deseja salvar
      final Map<String, dynamic> dadosDoFeedback = {
        'EnviadoPor': firebaseAuth.currentUser?.email,
        'Feedback': _textEditingController.text,
        'Nota': rating,
        'Para': _ParaController.text
      };

      // Adicione os dados à coleção "grupos"
      await firestore.collection('feedbacks').add(dadosDoFeedback);

      // O documento foi adicionado com sucesso
      Fluttertoast.showToast(
        msg: "Dados enviados com sucesso!",
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.of(context).pop();

    } catch (error) {
      // Lidar com erros, se houver algum
      print('Erro ao adicionar grupo: $error');
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Novo Feedback',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    firebaseAuth.currentUser?.email ?? 'Email não disponível',
                  ),
                  TextFormField(
                    maxLines: 100, // Define o número máximo de linhas
                    minLines: 1, // Define o número mínimo de linhas (opcional)
                    decoration: const InputDecoration(
                      labelText: 'Descrição',
                      hintText: 'Digite aqui...',
                    ),
                    controller: _textEditingController, // Use um TextEditingController para controlar o conteúdo do campo de texto
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Enviar Para',
                      hintText: 'emxemplo@exemplo.com',
                    ),
                    controller: _ParaController, 
                  )
                ],
              ),
            ),
            SizedBox(height: 50),
            const Text("Nota"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    setState(() {
                      rating = index + 1;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                adicionarFeedback();
              },
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}


