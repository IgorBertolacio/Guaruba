import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/domain/entidades/blobo_base.dart';
import 'package:myapp/presentation/blocs/gerenciamento_bloc.dart';
import 'package:myapp/presentation/blocs/gerenciamento_estado.dart';
import 'package:myapp/domain/entidades/bloco_mostre.dart';
import 'package:myapp/domain/entidades/bloco_se.dart';
import 'package:myapp/presentation/widgets/blocos/bloco_mostre.dart';
import 'package:myapp/presentation/widgets/blocos/bloco_se.dart';

// Enum e classe para dados de arrastar
enum OrigemBloco { principal, entao, senao }

class BlocoDragData {
  final BlocoBase bloco;
  final OrigemBloco origem;

  BlocoDragData({required this.bloco, required this.origem});
}

class WidgetBlocosPilha extends StatelessWidget {
  const WidgetBlocosPilha({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: const Color.fromARGB(255, 31, 31, 31),
        child: BlocBuilder<BlocoBloc, GerenciamentoEstado>(
          builder: (context, state) {
            if (state is EstadoBlocosAtualizados) {
              final blocos = state.blocos;
              return ListView.builder(
                itemCount: blocos.length,
                itemBuilder: (context, index) {
                  final bloco = blocos[index];
                  return _construirWidgetBloco(bloco, OrigemBloco.principal);
                },
              );
            } else {
              return const Center(
                child: Text(
                  'Nenhum bloco adicionado',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  // Função para construir o widget apropriado com base no tipo de bloco
  Widget _construirWidgetBloco(BlocoBase bloco, OrigemBloco origem) {
    if (bloco is BlocoMostre) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: WidgetBlocoMostre(
          blocoMostre: bloco,
          origem: origem, // Use o valor recebido
        ),
      );
    } else if (bloco is BlocoSe) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: WidgetBlocoSe(
          blocoSe: bloco,
          origem: origem, // Use o valor recebido
        ),
      );
    }
    return const SizedBox();
  }
}
