import 'package:myapp/domain/entidades/blobo_base.dart';
import 'origem_bloco.dart'; 

class BlocoDragData {
  final BlocoBase bloco;
  final OrigemBloco origem;

  BlocoDragData({required this.bloco, required this.origem});
}
