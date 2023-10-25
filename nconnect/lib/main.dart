import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nconnect/Feedback.dart';
import 'package:nconnect/FeedbackList.dart';
import 'package:nconnect/constants/constants.dart';
import 'package:nconnect/dominio.dart';
import 'package:nconnect/firebase_options.dart';
import 'package:nconnect/models/FeedbackModel.dart';
import 'package:nconnect/models/dominioModel.dart';
import 'package:nconnect/perfil.dart';
import 'firebase_options.dart';
import 'package:nconnect/login.dart';

bool shouldUseFirestoreEmulator = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final FirebaseAuth fireAuth = FirebaseAuth.instance;

    verificarLogin(){
      if (fireAuth.currentUser != null) {
        // O usuário já está autenticado e permaneceu conectado.
        // Você pode redirecioná-lo para a tela principal do aplicativo.
        return "/feedbackList";
      } else {
        // O usuário não está autenticado.
        // Navegue para a tela de login.
        return "/login";
      }
    }

    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        scaffoldBackgroundColor: secondary

      ),
      routes: {
        '/login': (context) => const LoginWidget(),
        '/feedbackList': (context) => const FeedbackListWidget(),
        '/feedback': (context) =>  FeedbackWidget(feedbackModel: new FeedbackModel(EnviadoPor: "", Feedback: "", Nota: 0, Para: "")),
        //'/dominio': (context) => const DominioWidget()
      },
      initialRoute: verificarLogin(),
      
    );
  }
}
