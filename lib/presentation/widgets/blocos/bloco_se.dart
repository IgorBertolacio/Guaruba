import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/domain/entidades/blobo_base.dart';
import 'package:myapp/domain/entidades/bloco_mostre.dart';
import 'package:myapp/domain/entidades/bloco_se.dart';
import 'package:myapp/presentation/widgets/blocos/bloco_mostre.dart';
import 'package:myapp/presentation/widgets/code_page/widget_blocos_pilha.dart';
import '../../blocs/gerenciamento_bloc.dart';
import '../../blocs/gerenciamento_evento.dart';
import '../../blocs/gerenciamento_estado.dart';

class WidgetBlocoSe extends StatefulWidget {
  final BlocoSe blocoSe;
  final OrigemBloco origem;
  final int nestingLevel; // Add this parameter

  const WidgetBlocoSe({
    Key? key,
    required this.blocoSe,
    required this.origem,
    this.nestingLevel = 0, // Default to 0
  }) : super(key: key);

  @override
  _WidgetBlocoSeState createState() => _WidgetBlocoSeState();
}

Color _getBackgroundColor(int nestingLevel) {
  // Base color for the BlocoSe
  Color baseColor = Color.fromARGB(255, 238, 203, 1); // Original yellow color

  // Darken the color based on the nesting level
  int factor = nestingLevel * 20; // Adjust the multiplier as needed

  int red = (baseColor.red - factor).clamp(0, 255);
  int green = (baseColor.green - factor).clamp(0, 255);
  int blue = (baseColor.blue - factor).clamp(0, 255);

  return Color.fromARGB(baseColor.alpha, red, green, blue);
}

class _WidgetBlocoSeState extends State<WidgetBlocoSe> {
  final TextEditingController esquerdaController = TextEditingController();
  final TextEditingController direitaController = TextEditingController();
  String operadorSelecionado = '==';

  @override
  void initState() {
    super.initState();
    esquerdaController.text = widget.blocoSe.expressaoEsquerda;
    direitaController.text = widget.blocoSe.expressaoDireita;
    operadorSelecionado = widget.blocoSe.operador;
  }

  @override
  void dispose() {
    esquerdaController.dispose();
    direitaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Verificar se este bloco está selecionado
    final estado = context.watch<BlocoBloc>().state;
    BlocoBase? blocoSelecionado;
    String? areaSelecionada;

    if (estado is EstadoBlocosAtualizados) {
      areaSelecionada = estado.areaSelecionada;
      blocoSelecionado = estado.blocoSelecionado;
    }

    bool isSelecionado = blocoSelecionado == widget.blocoSe;
    bool isEntaoSelecionado =
        blocoSelecionado == widget.blocoSe && areaSelecionada == 'ENTAO';
    bool isSenaoSelecionado =
        blocoSelecionado == widget.blocoSe && areaSelecionada == 'SENAO';

    return GestureDetector(
      onTap: () {
        context.read<BlocoBloc>().add(SelecionarBloco(widget.blocoSe));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: _getBackgroundColor(widget.nestingLevel),
          borderRadius: BorderRadius.circular(8.0),
          border: isSelecionado
              ? Border.all(color: Colors.yellowAccent, width: 2.0)
              : null,
        ),
        child: Column(
          children: [
            // Seção Condição
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Row(
                    children: [
                      Icon(Icons.help_outline, color: Colors.black),
                      Text('Se',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                      SizedBox(width: 8.0),
                    ],
                  ),
                  Expanded(
                    child: TextField(
                      controller: esquerdaController,
                      decoration: const InputDecoration(
                        hintText: 'Expressão 1',
                        hintStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(color: Colors.black),
                      onChanged: (value) {
                        final blocoAtualizado = widget.blocoSe.copyWith(
                          expressaoEsquerda: value,
                        );
                        context
                            .read<BlocoBloc>()
                            .add(AtualizarBlocoSe(blocoAtualizado));
                      },
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  DropdownButton<String>(
                    value: operadorSelecionado,
                    dropdownColor: const Color.fromARGB(255, 238, 203, 1),
                    items:
                        ['==', '!=', '>', '<', '>=', '<='].map((String valor) {
                      return DropdownMenuItem<String>(
                        value: valor,
                        child: Text(
                          valor,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (novoValor) {
                      setState(() {
                        operadorSelecionado = novoValor!;
                      });
                      final blocoAtualizado = widget.blocoSe.copyWith(
                        operador: novoValor,
                      );
                      context
                          .read<BlocoBloc>()
                          .add(AtualizarBlocoSe(blocoAtualizado));
                    },
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      controller: direitaController,
                      decoration: const InputDecoration(
                        hintText: 'Expressão 2',
                        hintStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(color: Colors.black),
                      onChanged: (value) {
                        final blocoAtualizado = widget.blocoSe.copyWith(
                          expressaoDireita: value,
                        );
                        context
                            .read<BlocoBloc>()
                            .add(AtualizarBlocoSe(blocoAtualizado));
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Seção Então
            GestureDetector(
              onTap: () {
                context
                    .read<BlocoBloc>()
                    .add(SelecionarArea(bloco: widget.blocoSe, area: 'ENTAO'));
              },
              child: Container(
                color: isEntaoSelecionado
                    ? const Color.fromARGB(255, 175, 150, 0)
                    : const Color.fromARGB(255, 238, 203, 1),
                child: Column(
                  children: [
                    const Text('Então', style: TextStyle(color: Colors.black)),
                    Container(
                      constraints: const BoxConstraints(minHeight: 100),
                      child: _buildBlocos(
                          widget.blocoSe.blocosEntao, OrigemBloco.entao),
                    ),
                  ],
                ),
              ),
            ),
            // Seção Senão
            GestureDetector(
              onTap: () {
                context
                    .read<BlocoBloc>()
                    .add(SelecionarArea(bloco: widget.blocoSe, area: 'SENAO'));
              },
              child: Container(
                color: isSenaoSelecionado
                    ? const Color.fromARGB(255, 175, 150, 0)
                    : const Color.fromARGB(255, 238, 203, 1),
                child: Column(
                  children: [
                    const Text('Senão', style: TextStyle(color: Colors.black)),
                    Container(
                      constraints: const BoxConstraints(minHeight: 100),
                      child: _buildBlocos(
                          widget.blocoSe.blocosSenao, OrigemBloco.senao),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlocos(List<BlocoBase> blocos, OrigemBloco origem) {
    if (blocos.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 31, 31, 31),
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8.0),
        ),
        height: 100, // Adjust the height as needed
        child: const Center(
          child: Text(
            'Clique para adicionar blocos',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(8.0), // Add padding around the blocks
        decoration: BoxDecoration(
          color: const Color.fromARGB(
              255, 31, 31, 31), // Background color for the area
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: blocos.map((bloco) {
            Widget widgetBloco;
            if (bloco is BlocoMostre) {
              widgetBloco = WidgetBlocoMostre(
                blocoMostre: bloco,
                origem: origem,
              );
            } else if (bloco is BlocoSe) {
              widgetBloco = WidgetBlocoSe(
                blocoSe: bloco,
                origem: origem,
                nestingLevel:
                    widget.nestingLevel + 1, // Increase the nesting level
              );
            } else {
              return const SizedBox.shrink();
            }

            return Container(
              margin: const EdgeInsets.symmetric(
                  vertical: 4.0), // Adjust the margin as needed
              child: widgetBloco,
            );
          }).toList(),
        ),
      );
    }
  }
}
