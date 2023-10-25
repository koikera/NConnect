import 'package:flutter/material.dart';
import 'package:nconnect/constants/constants.dart';
import 'package:nconnect/models/FeedbackModel.dart';

class FeedbackWidget extends StatefulWidget {
  final FeedbackModel feedbackModel;

  const FeedbackWidget({required this.feedbackModel});

  @override
  State<FeedbackWidget> createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes do Feedback"), // Acesso correto à propriedade feedbackModel
        backgroundColor: primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Enviado por:',
                style: TextStyle(fontSize: 18),
              ),
              subtitle: Text(
                widget.feedbackModel.EnviadoPor,
                style: TextStyle(fontSize: 16),
              ),
            ),
            ListTile(
              title: Text(
                'Feedback:',
                style: TextStyle(fontSize: 18),
              ),
              subtitle: Text(
                widget.feedbackModel.Feedback,
                style: TextStyle(fontSize: 16),
              ),
            ),
            ListTile(
              title: Text(
                'Nota:',
                style: TextStyle(fontSize: 18),
              ),
              subtitle: Row(
                children: List.generate(5, (index) {
                  return Icon(
                      index < widget.feedbackModel.Nota ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    );
                }),
              ), // Chama a função para construir as estrelas
            ),
            ListTile(
              title: Text(
                'Para:',
                style: TextStyle(fontSize: 18),
              ),
              subtitle: Text(
                widget.feedbackModel.Para,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
