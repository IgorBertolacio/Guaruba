import 'package:equatable/equatable.dart';
import 'package:myapp/domain/entidades/blobo_base.dart';
import 'package:myapp/domain/entidades/bloco_mostre.dart';
import 'package:myapp/domain/entidades/bloco_se.dart';

abstract class GerenciamentoEvento extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdicionarBloco extends GerenciamentoEvento {
  final BlocoBase bloco;

  AdicionarBloco(this.bloco);

  @override
  List<Object?> get props => [bloco];
}

class SelecionarBloco extends GerenciamentoEvento {
  final BlocoBase bloco;

  SelecionarBloco(this.bloco);

  @override
  List<Object?> get props => [bloco];
}

class SelecionarArea extends GerenciamentoEvento {
  final BlocoSe bloco;
  final String area; // 'ENTAO' ou 'SENAO'

  SelecionarArea({required this.bloco, required this.area});

  @override
  List<Object?> get props => [bloco, area];
}

class AtualizarBlocoSe extends GerenciamentoEvento {
  final BlocoSe blocoSeAtualizado;

  AtualizarBlocoSe(this.blocoSeAtualizado);

  @override
  List<Object?> get props => [blocoSeAtualizado];
}

class AtualizarBlocoMostre extends GerenciamentoEvento {
  final BlocoMostre blocoMostreAtualizado;

  AtualizarBlocoMostre(this.blocoMostreAtualizado);

  @override
  List<Object?> get props => [blocoMostreAtualizado];
}

class ExcluirBloco extends GerenciamentoEvento {
  final BlocoBase bloco;

  ExcluirBloco(this.bloco);

  @override
  List<Object?> get props => [bloco];
}

class ExcluirTodosBlocos extends GerenciamentoEvento {
  @override
  List<Object?> get props => [];
}
