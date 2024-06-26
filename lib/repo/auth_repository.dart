import '../data/auth_data_provider.dart';

class AuthRepository {
  final AuthDataProvider authDataProvider;

  AuthRepository({required this.authDataProvider});

  Future<void> register(String userId, String email, String nome, String usuario, String senha) async {
    await authDataProvider.registerUser(userId, {
      'email': email,
      'nome': nome,
      'usuario': usuario,
      'senha': senha, // Salvar a senha criptografada
    });
  }

  Future<Map<String, dynamic>?> getUser(String userId) async {
    return await authDataProvider.getUser(userId);
  }

  Future<Map<String, dynamic>?> login(String email, String password) async {
    return await authDataProvider.login(email, password);
  }

  Future<void> updateUserField(String userId, String field, String newValue) async {
    await authDataProvider.updateUserField(userId, field, newValue);
  }

  Future<void> addNote(String userId, String note) async {
    await authDataProvider.addNote(userId, note);
  }

  Future<List<String>> getNotes(String userId) async {
    return await authDataProvider.getNotes(userId);
  }
}
