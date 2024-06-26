import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method

class AuthDataProvider {
  final Dio dio;

  AuthDataProvider({required this.dio});

  Future<void> registerUser(String userId, Map<String, dynamic> userData) async {
    try {
      await dio.put(
        'https://si700-177950-default-rtdb.firebaseio.com/users/$userId.json',
        data: userData,
      );
    } catch (e) {
      print('Erro ao registrar usuário: $e');
      throw e;
    }
  }

  Future<Map<String, dynamic>?> getUser(String userId) async {
    try {
      final response = await dio.get(
        'https://si700-177950-default-rtdb.firebaseio.com/users/$userId.json',
      );
      return response.data;
    } catch (e) {
      print('Erro ao obter usuário: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      final userId = email.hashCode.toString();
      final response = await getUser(userId);
      if (response != null) {
        final storedPassword = response['senha'];
        final inputPasswordHash = md5.convert(utf8.encode(password)).toString();
        if (storedPassword == inputPasswordHash) {
          return response;
        }
      }
      return null;
    } catch (e) {
      print('Erro ao fazer login: $e');
      return null;
    }
  }
}
