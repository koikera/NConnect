import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nconnect/constants/constants.dart';

class PerfilWidget extends StatelessWidget {
  bool isPsicologo;
  PerfilWidget({required this.isPsicologo});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    String? userEmail = firebaseAuth.currentUser?.email;
    String? userName = firebaseAuth.currentUser?.displayName;

    Future<void> resetPassword() async {
      try {
        await firebaseAuth.sendPasswordResetEmail(email: userEmail ?? "");
        // O documento foi adicionado com sucesso
        Fluttertoast.showToast(
          msg: 'Foi enviado um email de redefinição de senha para o endereço $userEmail. Por favor, verifique sua caixa de entrada e siga as instruções para redefinir sua senha.',
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } catch (e) {
          Fluttertoast.showToast(
          msg: 'Erro ao enviar o email de redefinição de senha: $e',
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }

    Future<String> calcularNota() async {
      final QuerySnapshot querySnapshot = await firestore.collection("feedbacks").where("Para", isEqualTo: userEmail).get();
      final List<QueryDocumentSnapshot> documentos = querySnapshot.docs;
      int nota = 0;

      for(final i in documentos)
      {
        final data = i.data() as Map<String, dynamic>;
        final Nota = i['Nota'] as int;

        nota += Nota;
      }

      return (nota/documentos.length).toString();

    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil', style: TextStyle(color: textColor, fontWeight: FontWeight.w700)), // Acesso correto à propriedade feedbackModel
        backgroundColor: primary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 60,
              child: Text(userEmail != null ? userEmail[0].toUpperCase() : "", style: TextStyle(fontSize: 20),),
            ),
            SizedBox(height: 20),
            Text(
              'Email:',
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            Text(
              userEmail ?? 'Email não disponível',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            if (isPsicologo)
              Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Nota:',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  FutureBuilder<String>(
                    future: calcularNota(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Erro ao calcular a nota');
                      } else {
                        return Text(
                          snapshot.data ?? 'N/A',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
                        );
                      }
                    },
                  ),
                ],
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                resetPassword();
              },
              child: Text(
                'Redefinir Senha',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
              ),
            ),
          ],
        ),
      ),

    );
  }
}