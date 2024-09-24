import 'package:equatable/equatable.dart';
import '../../domain/entidades/blobo_base.dart';

abstract class GerenciamentoEstado extends Equatable {
  @override
  List<Object?> get props => [];
}

class EstadoInicial extends GerenciamentoEstado {}

class EstadoBlocosAtualizados extends GerenciamentoEstado {
  final List<BlocoBase> blocos;
  final BlocoBase? blocoSelecionado;
  final String? areaSelecionada;

  EstadoBlocosAtualizados(
    this.blocos, {
    this.blocoSelecionado,
    this.areaSelecionada,
  });

  @override
  List<Object?> get props => [
        blocos,
        blocoSelecionado ?? '',
        areaSelecionada ?? '',
      ];
}
