import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'result_page.dart';

class QuizPage extends StatefulWidget {
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final perguntas = [
    {
      'pergunta': 'Qual é a velocidade máxima numa autoestrada?',
      'respostas': ['90 km/h', '100 km/h', '120 km/h', '140 km/h'],
      'correta': 2
    },
    {
      'pergunta': 'É permitido ultrapassar pela direita?',
      'respostas': ['Sim', 'Não', 'Depende da estrada', 'Só em autoestrada'],
      'correta': 1
    },
  ];

  int perguntaAtual = 0;
  int pontuacao = 0;

  void responder(int selecionada) {
    if (selecionada == perguntas[perguntaAtual]['correta']) {
      pontuacao++;
    }

    if (perguntaAtual < perguntas.length - 1) {
      setState(() => perguntaAtual++);
    } else {
      salvarResultado();
      Navigator.push(context, MaterialPageRoute(builder: (_) => ResultPage(pontuacao)));
    }
  }

  void salvarResultado() async {
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('resultados').add({
      'uid': user?.uid,
      'pontuacao': pontuacao,
      'data': Timestamp.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final pergunta = perguntas[perguntaAtual];

    return Scaffold(
      appBar: AppBar(title: Text('Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(pergunta['pergunta'] as String, style: TextStyle(fontSize: 22)),
            ...List.generate(4, (i) => ElevatedButton(
              onPressed: () => responder(i),
              child: Text(pergunta['respostas'][i]),
            )),
          ],
        ),
      ),
    );
  }
}