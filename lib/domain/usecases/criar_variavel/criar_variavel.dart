// lib/core/utils/variaveis.dart

/// Mapa Global para armazenar as variáveis criadas
Map<String, Map<String, dynamic>> variaveisGlobais = {};

/// Contador para gerar a sequência de nomes de variáveis
int contadorSequencia = 0;

/// Sequência atual de nomes de variáveis
String sequenciaAtual = 'A';

/// Gera o próximo nome de variável
String GerarProximoNomeVariavel() {
  if (sequenciaAtual == 'Z') {
    contadorSequencia++;
    sequenciaAtual = 'A';
  } else {
    sequenciaAtual = String.fromCharCode(sequenciaAtual.codeUnitAt(0) + 1);
  }
  return '$sequenciaAtual${contadorSequencia > 0 ? contadorSequencia.toString() : ''}';
}

/// Cria uma nova variável e a associa a um bloco
String CriarVariavel(String idBloco) {
  String nomeVariavel = GerarProximoNomeVariavel();
  variaveisGlobais[nomeVariavel] = {'idBloco': idBloco, 'valor': null};
  return nomeVariavel;
}

/// Obtém os detalhes de uma variável
Map<String, dynamic> obterVariavel(String nomeVariavel) {
  return variaveisGlobais[nomeVariavel] ?? {};
}

/// Deleta todas as variáveis associadas a um bloco
void deletarVariavel(String idBloco) {
  variaveisGlobais
      .removeWhere((nomeVariavel, detalhes) => detalhes['idBloco'] == idBloco);
}
