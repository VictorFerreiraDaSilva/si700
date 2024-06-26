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

      if (response.data != null) {
        final data = response.data as Map<String, dynamic>;
        data['userId'] = userId;
        return data;
      }
      return null;
    } catch (e) {
      print('Erro ao obter usuário: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      final emailHash = email.hashCode.toString();
      final response = await getUser(emailHash);
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

  Future<void> updateUserField(String userId, String field, String newValue) async {
    try {
      await dio.patch(
        'https://si700-177950-default-rtdb.firebaseio.com/users/$userId.json',
        data: {field.toLowerCase(): newValue},
      );
    } catch (e) {
      print('Erro ao atualizar campo do usuário: $e');
      throw e;
    }
  }
}
