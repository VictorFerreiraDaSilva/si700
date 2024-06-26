import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../repo/exercicio_repository.dart';
import '../model/exercicio.dart';

// Eventos
abstract class ExercicioEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchExercicios extends ExercicioEvent {}

// Estados
abstract class ExercicioState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ExercicioInitial extends ExercicioState {}

class ExercicioLoading extends ExercicioState {}

class ExercicioLoaded extends ExercicioState {
  final List<Exercicio> exercicios;

  ExercicioLoaded({required this.exercicios});

  @override
  List<Object?> get props => [exercicios];
}

class ExercicioError extends ExercicioState {
  final String message;

  ExercicioError({required this.message});

  @override
  List<Object?> get props => [message];
}

// BLoC
class ExercicioBloc extends Bloc<ExercicioEvent, ExercicioState> {
  final ExercicioRepository exercicioRepository;

  ExercicioBloc({required this.exercicioRepository}) : super(ExercicioInitial()) {
    on<FetchExercicios>((event, emit) async {
      emit(ExercicioLoading());
      try {
        final exercicios = await exercicioRepository.getExercicios();
        emit(ExercicioLoaded(exercicios: exercicios));
      } catch (e) {
        emit(ExercicioError(message: e.toString()));
      }
    });
  }
}
