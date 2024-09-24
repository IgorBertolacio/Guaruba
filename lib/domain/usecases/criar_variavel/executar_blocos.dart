// lib/domain/usecases/executar_blocos.dart

import '../../../domain/entidades/bloco_mostre.dart';
import '../../../domain/entidades/bloco_se.dart';
import '../../entidades/blobo_base.dart';

class ExecutorDeBlocos {
  final Map<String, Map<String, dynamic>> variaveis;
  final List<String> mensagensDepuracao;

  ExecutorDeBlocos({
    required this.variaveis,
    required this.mensagensDepuracao,
  });

  void executarBlocos(List<BlocoBase> blocos) {
    for (var bloco in blocos) {
      if (bloco is BlocoMostre) {
        executarBlocoMostre(bloco);
      } else if (bloco is BlocoSe) {
        executarBlocoSe(bloco);
      }
      // Adicione outros tipos de blocos aqui
    }
  }

  void executarBlocoMostre(BlocoMostre bloco) {
    final nomeVariavel = bloco.nomeVariavel;
    if (variaveis.containsKey(nomeVariavel)) {
      final valor = variaveis[nomeVariavel]!['valor'];
      mensagensDepuracao.add('Mostre (${nomeVariavel}): $valor');
    } else {
      mensagensDepuracao.add('Erro: Variável "$nomeVariavel" não encontrada.');
    }
  }

  void executarBlocoSe(BlocoSe bloco) {
    final valorEsquerda = _avaliarExpressao(bloco.expressaoEsquerda);
    final valorDireita = _avaliarExpressao(bloco.expressaoDireita);
    bool resultado = false;

    switch (bloco.operador) {
      case '==':
        resultado = valorEsquerda == valorDireita;
        break;
      case '!=':
        resultado = valorEsquerda != valorDireita;
        break;
      case '>':
        resultado = valorEsquerda > valorDireita;
        break;
      case '<':
        resultado = valorEsquerda < valorDireita;
        break;
      case '>=':
        resultado = valorEsquerda >= valorDireita;
        break;
      case '<=':
        resultado = valorEsquerda <= valorDireita;
        break;
      default:
        mensagensDepuracao.add('Operador inválido: ${bloco.operador}');
        return;
    }

    if (resultado) {
      executarBlocos(bloco.blocosEntao);
    } else {
      executarBlocos(bloco.blocosSenao);
    }
  }

  dynamic _avaliarExpressao(String expressao) {
    if (expressao.startsWith('@')) {
      final nomeVariavel = expressao.substring(1);
      if (variaveis.containsKey(nomeVariavel)) {
        return variaveis[nomeVariavel]!['valor'];
      } else {
        mensagensDepuracao.add('Erro: Variável "$nomeVariavel" não encontrada.');
        return null;
      }
    } else {
      final num? valorNumerico = num.tryParse(expressao);
      if (valorNumerico != null) {
        return valorNumerico;
      } else {
        return expressao;
      }
    }
  }
}
