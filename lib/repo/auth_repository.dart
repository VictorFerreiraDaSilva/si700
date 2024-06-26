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

  Future<Map<String, dynamic>?> getUser(String emailHash) async {
    return await authDataProvider.getUser(emailHash);
  }

  Future<Map<String, dynamic>?> login(String email, String password) async {
    return await authDataProvider.login(email, password);
  }

  Future<void> updateUserField(String userId, String field, String newValue) async {
    await authDataProvider.updateUserField(userId, field, newValue);
  }
}
