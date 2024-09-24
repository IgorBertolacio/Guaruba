import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/domain/entidades/blobo_base.dart';
import 'package:myapp/domain/entidades/bloco_mostre.dart';
import 'package:myapp/domain/entidades/bloco_se.dart';
import 'gerenciamento_evento.dart';
import 'gerenciamento_estado.dart';

class BlocoBloc extends Bloc<GerenciamentoEvento, GerenciamentoEstado> {
  List<BlocoBase> blocosAdicionados = [];
  BlocoBase? blocoSelecionado;
  String? areaSelecionada;

  BlocoBloc() : super(EstadoInicial()) {
    on<AdicionarBloco>(_onAdicionarBloco);
    on<SelecionarBloco>(_onSelecionarBloco);
    on<SelecionarArea>(_onSelecionarArea);
    on<AtualizarBlocoSe>(_onAtualizarBlocoSe);
    on<AtualizarBlocoMostre>(_onAtualizarBlocoMostre);
    on<ExcluirBloco>(_onExcluirBloco);
    
  }

  void _onAdicionarBloco(
      AdicionarBloco event, Emitter<GerenciamentoEstado> emit) {
    blocosAdicionados.add(event.bloco);
    emit(EstadoBlocosAtualizados(
      List.from(blocosAdicionados),
      blocoSelecionado: blocoSelecionado,
      areaSelecionada: areaSelecionada,
    ));
  }

  void _onSelecionarBloco(
      SelecionarBloco event, Emitter<GerenciamentoEstado> emit) {
    blocoSelecionado = event.bloco;
    emit(EstadoBlocosAtualizados(
      List.from(blocosAdicionados),
      blocoSelecionado: blocoSelecionado,
      areaSelecionada: areaSelecionada,
    ));
  }

  void _onSelecionarArea(
      SelecionarArea event, Emitter<GerenciamentoEstado> emit) {
    areaSelecionada = event.area;
    blocoSelecionado = event.bloco;
    emit(EstadoBlocosAtualizados(
      List.from(blocosAdicionados),
      blocoSelecionado: blocoSelecionado,
      areaSelecionada: areaSelecionada,
    ));
  }

  void _onAtualizarBlocoSe(
      AtualizarBlocoSe event, Emitter<GerenciamentoEstado> emit) {
    blocoSelecionado = event.blocoSeAtualizado;
    blocosAdicionados =
        _atualizarBlocoNaLista(blocosAdicionados, event.blocoSeAtualizado);
    emit(EstadoBlocosAtualizados(
      List.from(blocosAdicionados),
      blocoSelecionado: blocoSelecionado,
      areaSelecionada: areaSelecionada,
    ));
  }

  void _onAtualizarBlocoMostre(
      AtualizarBlocoMostre event, Emitter<GerenciamentoEstado> emit) {
    blocosAdicionados =
        _atualizarBlocoNaLista(blocosAdicionados, event.blocoMostreAtualizado);
    if (blocoSelecionado is BlocoMostre &&
        blocoSelecionado?.id == event.blocoMostreAtualizado.id) {
      blocoSelecionado = event.blocoMostreAtualizado;
    }
    emit(EstadoBlocosAtualizados(
      List.from(blocosAdicionados),
      blocoSelecionado: blocoSelecionado,
      areaSelecionada: areaSelecionada,
    ));
  }

  void _onExcluirBloco(ExcluirBloco event, Emitter<GerenciamentoEstado> emit) {
    // Remove the block from anywhere in the list
    blocosAdicionados = _removerBlocoDaLista(blocosAdicionados, event.bloco);

    // Deselect the block if it was the one deleted
    if (blocoSelecionado == event.bloco) {
      blocoSelecionado = null;
      areaSelecionada = null;
    }

    emit(EstadoBlocosAtualizados(
      List.from(blocosAdicionados),
      blocoSelecionado: blocoSelecionado,
      areaSelecionada: areaSelecionada,
    ));
  }

  List<BlocoBase> _removerBlocoDaLista(
      List<BlocoBase> lista, BlocoBase blocoParaRemover) {
    List<BlocoBase> novaLista = [];

    for (var bloco in lista) {
      if (bloco.id == blocoParaRemover.id) {
        continue;
      } else if (bloco is BlocoSe) {
        final novosBlocosEntao =
            _removerBlocoDaLista(bloco.blocosEntao, blocoParaRemover);
        final novosBlocosSenao =
            _removerBlocoDaLista(bloco.blocosSenao, blocoParaRemover);

        BlocoSe blocoAtualizado = bloco.copyWith(
          blocosEntao: novosBlocosEntao,
          blocosSenao: novosBlocosSenao,
        );

        novaLista.add(blocoAtualizado);
      } else {
        novaLista.add(bloco);
      }
    }

    return novaLista;
  }

  List<BlocoBase> _atualizarBlocoNaLista(
      List<BlocoBase> lista, BlocoBase blocoAtualizado) {
    return lista.map((bloco) {
      if (bloco.id == blocoAtualizado.id) {
        // Substitui o bloco pelo bloco atualizado
        return blocoAtualizado;
      } else if (bloco is BlocoSe) {
        // Continua a busca nos blocos aninhados
        final blocosEntaoAtualizados =
            _atualizarBlocoNaLista(bloco.blocosEntao, blocoAtualizado);
        final blocosSenaoAtualizados =
            _atualizarBlocoNaLista(bloco.blocosSenao, blocoAtualizado);
        // Sempre retorna um novo BlocoSe com os blocos atualizados
        return bloco.copyWith(
          blocosEntao: blocosEntaoAtualizados,
          blocosSenao: blocosSenaoAtualizados,
        );
      }
      return bloco;
    }).toList();
  }
  
}

