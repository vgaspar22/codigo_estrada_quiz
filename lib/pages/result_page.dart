import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final int pontuacao;
  const ResultPage(this.pontuacao);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Resultados')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Pontuação final: \$pontuacao', style: TextStyle(fontSize: 24)),
            ElevatedButton(
              onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
              child: Text('Voltar ao início'),
            ),
          ],
        ),
      ),
    );
  }
}