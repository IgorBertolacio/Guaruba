import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/domain/entidades/blobo_base.dart';
import 'package:myapp/domain/usecases/criar_variavel/criar_variavel.dart';
import 'package:myapp/presentation/widgets/code_page/widget_blocos_pilha.dart';
import '../../../domain/entidades/bloco_mostre.dart';
import '../../blocs/gerenciamento_bloc.dart';
import '../../blocs/gerenciamento_evento.dart';
import '../../blocs/gerenciamento_estado.dart';

class WidgetBlocoMostre extends StatefulWidget {
  final BlocoMostre blocoMostre;
  final OrigemBloco origem;

  const WidgetBlocoMostre({
    Key? key,
    required this.blocoMostre,
    required this.origem,
  }) : super(key: key);

  @override
  _WidgetBlocoMostreState createState() => _WidgetBlocoMostreState();
}

class _WidgetBlocoMostreState extends State<WidgetBlocoMostre> {
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final valor = variaveisGlobais[widget.blocoMostre.nomeVariavel]?['valor'] ?? '';
    messageController.text = valor;
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final estado = context.watch<BlocoBloc>().state;
    BlocoBase? blocoSelecionado;
    if (estado is EstadoBlocosAtualizados) {
      blocoSelecionado = estado.blocoSelecionado;
    }

    bool isSelecionado = blocoSelecionado == widget.blocoMostre;

    return GestureDetector(
      onTap: () {
        context.read<BlocoBloc>().add(SelecionarBloco(widget.blocoMostre));
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 29, 78, 10),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(0.0, 1.0),
              blurRadius: 2.0,
            ),
          ],
          border: isSelecionado
              ? Border.all(
                  color: Colors.yellowAccent,
                  width: 2.0,
                )
              : null,
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                _mostrarDialogoEditarVariavel(context);
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.chat_outlined,
                    color: Color.fromARGB(255, 225, 225, 225),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    'Mostre (${widget.blocoMostre.nomeVariavel})',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 225, 225, 225),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, -1.0),
                        blurRadius: 2.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Digite a mensagem',
                    ),
                    onChanged: (value) {
                      variaveisGlobais[widget.blocoMostre.nomeVariavel]!['valor'] =
                          value;
                      // Se 'valor' fizer parte de BlocoMostre, considere atualizar via Bloc também
                      // Exemplo:
                      // final blocoMostreAtualizado = widget.blocoMostre.copyWith(valor: value);
                      // context.read<BlocoBloc>().add(AtualizarBlocoMostre(blocoMostreAtualizado));
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoEditarVariavel(BuildContext context) {
    final controlador =
        TextEditingController(text: widget.blocoMostre.nomeVariavel);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Variável'),
          content: TextField(
            controller: controlador,
            decoration: const InputDecoration(labelText: 'Nome da Variável'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final novoNome = controlador.text.trim();

                if (novoNome.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text('O nome da variável não pode ser vazio.')),
                  );
                  return;
                }

                if (variaveisGlobais.containsKey(novoNome)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text('Uma variável com esse nome já existe.')),
                  );
                  return;
                }

                final detalhesVariavel =
                    variaveisGlobais.remove(widget.blocoMostre.nomeVariavel);
                variaveisGlobais[novoNome] = detalhesVariavel!;

                // Crie uma nova instância de BlocoMostre com o nome atualizado
                final blocoMostreAtualizado = widget.blocoMostre.copyWith(
                  nomeVariavel: novoNome,
                );

                // Despache o evento para atualizar o BlocoMostre no Bloc
                context
                    .read<BlocoBloc>()
                    .add(AtualizarBlocoMostre(blocoMostreAtualizado));

                Navigator.of(context).pop();
              },
              child: const Text('Salvar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}
