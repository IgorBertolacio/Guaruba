import 'package:myapp/domain/entidades/blobo_base.dart';

class BlocoMostre extends BlocoBase {
  final String nomeVariavel;

  BlocoMostre({
    required String id,
    required this.nomeVariavel,
  }) : super(id: id);

  BlocoMostre copyWith({
    String? nomeVariavel,
  }) {
    return BlocoMostre(
      id: this.id,
      nomeVariavel: nomeVariavel ?? this.nomeVariavel,
    );
  }

  @override
  List<Object?> get props => [
        id,
        nomeVariavel,
      ];
}
