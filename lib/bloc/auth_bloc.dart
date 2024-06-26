import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../repo/auth_repository.dart';

// Eventos
abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthRegister extends AuthEvent {
  final String userId;
  final String email;
  final String nome;
  final String usuario;
  final String senha;

  AuthRegister({required this.userId, required this.email, required this.nome, required this.usuario, required this.senha});

  @override
  List<Object?> get props => [userId, email, nome, usuario, senha];
}

class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class AuthLogout extends AuthEvent {}

class UpdateUserField extends AuthEvent {
  final String userId;
  final String field;
  final String newValue;

  UpdateUserField(this.userId, this.field, this.newValue);

  @override
  List<Object?> get props => [userId, field, newValue];
}

class AddNote extends AuthEvent {
  final String userId;
  final String note;

  AddNote(this.userId, this.note);

  @override
  List<Object?> get props => [userId, note];
}

class RemoveNote extends AuthEvent {
  final String userId;
  final String note;

  RemoveNote(this.userId, this.note);

  @override
  List<Object?> get props => [userId, note];
}

class GetNotes extends AuthEvent {
  final String userId;

  GetNotes(this.userId);

  @override
  List<Object?> get props => [userId];
}

class AuthUserUpdated extends AuthEvent {
  final String userId;

  AuthUserUpdated({required this.userId});

  @override
  List<Object?> get props => [userId];
}

// Estados
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final Map<String, dynamic> user;

  AuthAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthNotesLoaded extends AuthState {
  final List<String> notes;

  AuthNotesLoaded({required this.notes});

  @override
  List<Object?> get props => [notes];
}

class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthRegister>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.register(event.userId, event.email, event.nome, event.usuario, event.senha);
        final user = await authRepository.getUser(event.userId);
        if (user != null) {
          user['userId'] = event.userId; // Adicionar userId ao mapa de usuário
          emit(AuthAuthenticated(user: user));
        } else {
          emit(AuthError(message: 'Erro ao registrar'));
        }
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    on<AuthLogin>((event, emit) async {
      emit(AuthLoading());
      try {
        final emailHash = event.email.hashCode.toString();
        final user = await authRepository.login(event.email, event.password);
        if (user != null) {
          user['userId'] = emailHash; // Adicionar userId ao mapa de usuário
          emit(AuthAuthenticated(user: user));
        } else {
          emit(AuthError(message: 'Email ou senha incorretos'));
        }
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    on<UpdateUserField>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.updateUserField(event.userId, event.field, event.newValue);
        final user = await authRepository.getUser(event.userId);
        if (user != null) {
          user['userId'] = event.userId; // Adicionar userId ao mapa de usuário
          emit(AuthAuthenticated(user: user));
        } else {
          emit(AuthError(message: 'Erro ao atualizar dados'));
        }
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    on<AddNote>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.addNote(event.userId, event.note);
        final notes = await authRepository.getNotes(event.userId);
        emit(AuthNotesLoaded(notes: notes));
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    on<RemoveNote>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.removeNote(event.userId, event.note);
        final notes = await authRepository.getNotes(event.userId);
        emit(AuthNotesLoaded(notes: notes));
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    on<GetNotes>((event, emit) async {
      emit(AuthLoading());
      try {
        final notes = await authRepository.getNotes(event.userId);
        emit(AuthNotesLoaded(notes: notes));
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    on<AuthLogout>((event, emit) async {
      emit(AuthInitial());
    });

    on<AuthUserUpdated>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepository.getUser(event.userId);
        if (user != null) {
          user['userId'] = event.userId; // Adicionar userId ao mapa de usuário
          emit(AuthAuthenticated(user: user));
        } else {
          emit(AuthError(message: 'Erro ao atualizar dados'));
        }
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });
  }
}
