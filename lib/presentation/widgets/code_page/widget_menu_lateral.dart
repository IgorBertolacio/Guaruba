import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/domain/entidades/blobo_base.dart';
import 'package:myapp/domain/entidades/bloco_se.dart';
import 'package:myapp/domain/usecases/criar_variavel/executar_blocos.dart';
import 'package:myapp/presentation/blocs/gerenciamento_estado.dart';
import 'package:myapp/presentation/pages/debug_page/tela_depuracao.dart';
import '../../../domain/entidades/bloco_mostre.dart';
import '../../../domain/usecases/criar_variavel/criar_variavel.dart';
import '../../blocs/gerenciamento_bloc.dart';
import '../../blocs/gerenciamento_evento.dart';

class WidigetMenuLateral extends StatelessWidget {
  const WidigetMenuLateral({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 45, 45, 45),
          border: Border(
            right: BorderSide(
              color: Color.fromARGB(255, 160, 160, 160),
              width: 1.0,
            ),
          )),
      height: double.infinity,
      width: 130,
      child: Column(
        children: [
          const SizedBox(height: 50),
          Container(
              color: Colors.transparent,
              height: 80,
              child: Center(
                child: SvgPicture.asset('assets/svg/juba.svg'),
              )),
          const ListaBlocos(),
          const Expanded(
            child: PlayDelete(),
          ),
        ],
      ),
    );
  }
}

class ListaBlocos extends StatelessWidget {
  const ListaBlocos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GestureDetector(
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 120, 83, 2),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.refresh,
                            color: Color.fromARGB(255, 225, 225, 225),
                          ),
                          Text(
                            'Execute',
                            style: TextStyle(
                                color: Color.fromARGB(255, 225, 225, 225)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 224, 145, 1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.loop,
                            color: Color.fromARGB(255, 225, 225, 225),
                          ),
                          Text(
                            'Durante',
                            style: TextStyle(
                                color: Color.fromARGB(255, 225, 225, 225)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  final idBloco = UniqueKey().toString();
                  final novoBlocoSe = BlocoSe(
                    id: idBloco,
                    expressaoEsquerda: '',
                    operador: '==',
                    expressaoDireita: '',
                  );

                  _adicionarBloco(context, novoBlocoSe);
                },
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 238, 203, 1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.help_outline,
                            color: Colors.black,
                          ),
                          Text(
                            'Se',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 46, 178, 113),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.code,
                            color: Colors.black,
                          ),
                          Text(
                            'Variavel',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 102, 136, 9),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.calculate_outlined,
                            color: Color.fromARGB(255, 225, 225, 225),
                          ),
                          Text(
                            'Calculo',
                            style: TextStyle(
                                color: Color.fromARGB(255, 225, 225, 225)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  final idBloco = UniqueKey().toString();
                  final nomeVariavel = CriarVariavel(idBloco);

                  final novoBloco = BlocoMostre(
                    id: idBloco,
                    nomeVariavel: nomeVariavel,
                  );

                  _adicionarBloco(context, novoBloco);
                },
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 29, 78, 10),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.chat_outlined,
                            color: Color.fromARGB(255, 225, 225, 225),
                          ),
                          Text(
                            'Mostre',
                            style: TextStyle(
                                color: Color.fromARGB(255, 225, 225, 225)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 14, 46, 130),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.text_format_outlined,
                            color: Color.fromARGB(255, 225, 225, 225),
                          ),
                          Text(
                            'Leia',
                            style: TextStyle(
                                color: Color.fromARGB(255, 225, 225, 225)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayDelete extends StatelessWidget {
  const PlayDelete({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Botão Play
        GestureDetector(
          onTap: () {
            _executarPrograma(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(150, 0, 255, 0),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color.fromARGB(255, 225, 225, 225),
                width: 1.0,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 2.0,
                ),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(
                Icons.play_arrow,
                color: Color.fromARGB(255, 225, 225, 225),
                size: 30,
                shadows: [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 2.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Botão Delete (já implementado anteriormente)
        GestureDetector(
          onTap: () {
            _excluirBlocoSelecionado(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(150, 255, 0, 0),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color.fromARGB(255, 225, 225, 225),
                width: 1.0,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 2.0,
                ),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(
                Icons.delete,
                color: Color.fromARGB(255, 225, 225, 225),
                size: 30,
                shadows: [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 2.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  void _executarPrograma(BuildContext context) {
    final estado = context.read<BlocoBloc>().state;
    List<BlocoBase> blocos = [];
    if (estado is EstadoBlocosAtualizados) {
      blocos = estado.blocos;
    }

    final mensagensDepuracao = <String>[];
    final executor = ExecutorDeBlocos(
      variaveis: variaveisGlobais,
      mensagensDepuracao: mensagensDepuracao,
    );

    executor.executarBlocos(blocos);

    // Navegar para a tela de depuração com as mensagens
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TelaDepuracao(mensagens: mensagensDepuracao),
      ),
    );
  }

  void _excluirBlocoSelecionado(BuildContext context) {
    final estado = context.read<BlocoBloc>().state;
    BlocoBase? blocoSelecionado;
    if (estado is EstadoBlocosAtualizados) {
      blocoSelecionado = estado.blocoSelecionado;
    }

    if (blocoSelecionado == null) {
      // Exibir uma mensagem se nenhum bloco estiver selecionado
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nenhum bloco selecionado para excluir.')),
      );
      return;
    }

    // Despachar o evento para excluir o bloco selecionado
    context.read<BlocoBloc>().add(ExcluirBloco(blocoSelecionado));

    // Exibir uma confirmação de exclusão
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Bloco excluído com sucesso.')),
    );
  }
}

void _adicionarBloco(BuildContext context, BlocoBase novoBloco) {
  final estado = context.read<BlocoBloc>().state;
  if (estado is EstadoBlocosAtualizados &&
      estado.areaSelecionada != null &&
      estado.blocoSelecionado != null) {
    if (estado.blocoSelecionado is BlocoSe) {
      final blocoSeAtual = estado.blocoSelecionado as BlocoSe;
      BlocoSe blocoSeAtualizado;

      // Verifica se a área selecionada é 'ENTAO' ou 'SENAO'
      if (estado.areaSelecionada == 'ENTAO') {
        final novosBlocosEntao = List<BlocoBase>.from(blocoSeAtual.blocosEntao)
          ..add(novoBloco);
        blocoSeAtualizado =
            blocoSeAtual.copyWith(blocosEntao: novosBlocosEntao);
      } else if (estado.areaSelecionada == 'SENAO') {
        final novosBlocosSenao = List<BlocoBase>.from(blocoSeAtual.blocosSenao)
          ..add(novoBloco);
        blocoSeAtualizado =
            blocoSeAtual.copyWith(blocosSenao: novosBlocosSenao);
      } else {
        return;
      }

      // Atualiza o blocoSe no Bloc
      context.read<BlocoBloc>().add(AtualizarBlocoSe(blocoSeAtualizado));
    }
  } else {
    // Caso nenhuma área seja selecionada, adiciona à pilha principal
    context.read<BlocoBloc>().add(AdicionarBloco(novoBloco));
  }
}
