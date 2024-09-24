import 'package:myapp/domain/entidades/blobo_base.dart';

class BlocoSe extends BlocoBase {
  final String expressaoEsquerda;
  final String operador;
  final String expressaoDireita;
  final List<BlocoBase> blocosEntao;
  final List<BlocoBase> blocosSenao;

  BlocoSe({
    required String id, // Passa 'id' para a classe base
    required this.expressaoEsquerda,
    required this.operador,
    required this.expressaoDireita,
    this.blocosEntao = const [],
    this.blocosSenao = const [],
  }) : super(id: id);

  BlocoSe copyWith({
    String? expressaoEsquerda,
    String? operador,
    String? expressaoDireita,
    List<BlocoBase>? blocosEntao,
    List<BlocoBase>? blocosSenao,
  }) {
    return BlocoSe(
      id: this.id,
      expressaoEsquerda: expressaoEsquerda ?? this.expressaoEsquerda,
      operador: operador ?? this.operador,
      expressaoDireita: expressaoDireita ?? this.expressaoDireita,
      blocosEntao: blocosEntao ?? this.blocosEntao,
      blocosSenao: blocosSenao ?? this.blocosSenao,
    );
  }

  @override
  List<Object?> get props => [
        id,
        expressaoEsquerda,
        operador,
        expressaoDireita,
        blocosEntao,
        blocosSenao,
      ];
}
