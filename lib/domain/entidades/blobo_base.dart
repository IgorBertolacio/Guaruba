import 'package:equatable/equatable.dart';

abstract class BlocoBase extends Equatable {
  final String id;

  BlocoBase({required this.id});

  @override
  List<Object?> get props => [id];
}
