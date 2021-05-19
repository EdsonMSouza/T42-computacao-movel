import 'package:flutter/material.dart';

class Dados extends StatelessWidget {
  final List conteudo;

  // recebe os dados da tela anterior (origem)
  Dados({Key key, @required this.conteudo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dados do Usuário')),
      body: Center(
        child: Column(
          children: [
            Text(conteudo[0]),
            Text(conteudo[1]),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Tela Anterior'),
            )
          ],
        ),
      ),
    );
  }
}
