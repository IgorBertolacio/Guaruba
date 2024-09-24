// lib/presentation/widgets/code_page/tela_depuracao.dart

import 'package:flutter/material.dart';

class TelaDepuracao extends StatelessWidget {
  final List<String> mensagens;

  const TelaDepuracao({Key? key, required this.mensagens}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fundo preto para contraste
      appBar: AppBar(
        title: const Text('Depuração'),
        backgroundColor: Colors.grey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: mensagens.isNotEmpty
            ? ListView.builder(
                itemCount: mensagens.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      mensagens[index],
                      style: const TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 16.0,
                      ),
                    ),
                  );
                },
              )
            : const Center(
                child: Text(
                  'Nenhuma mensagem para exibir.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
      ),
    );
  }
}
