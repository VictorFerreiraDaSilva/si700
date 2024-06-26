import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../model/treino.dart';
import '../repo/treino_repository.dart';

// Eventos
abstract class TreinoEvent extends Equatable {
  const TreinoEvent();

  @override
  List<Object> get props => [];
}

class AdicionarTreino extends TreinoEvent {
  final Treino treino;

  const AdicionarTreino(this.treino);

  @override
  List<Object> get props => [treino];
}

class RemoverTreino extends TreinoEvent {
  final String id;

  const RemoverTreino(this.id);

  @override
  List<Object> get props => [id];
}

class ListarTreinos extends TreinoEvent {}

// Estados
abstract class TreinoState extends Equatable {
  const TreinoState();

  @override
  List<Object> get props => [];
}

class TreinoInitial extends TreinoState {}

class TreinoCarregando extends TreinoState {}

class TreinoCarregado extends TreinoState {
  final List<Treino> treinos;

  const TreinoCarregado(this.treinos);

  @override
  List<Object> get props => [treinos];
}

class TreinoErro extends TreinoState {
  final String mensagem;

  const TreinoErro(this.mensagem);

  @override
  List<Object> get props => [mensagem];
}

// BLoC
class TreinoBloc extends Bloc<TreinoEvent, TreinoState> {
  final TreinoRepository treinoRepository;

  TreinoBloc({required this.treinoRepository}) : super(TreinoInitial()) {
    on<AdicionarTreino>((event, emit) async {
      try {
        emit(TreinoCarregando());
        await treinoRepository.adicionarTreino(event.treino);
        add(ListarTreinos());
      } catch (e) {
        emit(TreinoErro('Erro ao adicionar treino: $e'));
      }
    });

    on<RemoverTreino>((event, emit) async {
      try {
        emit(TreinoCarregando());
        await treinoRepository.removerTreino(event.id);
        add(ListarTreinos());
      } catch (e) {
        emit(TreinoErro('Erro ao remover treino: $e'));
      }
    });

    on<ListarTreinos>((event, emit) async {
      try {
        emit(TreinoCarregando());
        final treinos = await treinoRepository.listarTreinos();
        emit(TreinoCarregado(treinos));
      } catch (e) {
        emit(TreinoErro('Erro ao listar treinos: $e'));
      }
    });
  }
}
