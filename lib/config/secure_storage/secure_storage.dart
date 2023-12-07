import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = FlutterSecureStorage();

  Future<void> setToken(String token) async {
    await this.storage.write(key: 'token', value: token);
  }

  Future<String?> getToken() async {
    return await this.storage.read(key: 'token');
  }

  Future<void> deleteToken() async {
    await this.storage.delete(key: 'token');
  }

  Future<void> setName(String email) async {
    await this.storage.write(key: 'email', value: email);
  }

  Future<void> setRole(String role) async {
    await this.storage.write(key: 'role', value: role);
  }

  Future<String?> getRole() async {
    return await this.storage.read(key: 'role');
  }

  Future<void> setEmailForgotPassword(String email) async {
    await this.storage.write(key: 'email', value: email);
  }

  Future<String?> getEmailForgotPassword() async {
    return await this.storage.read(key: 'email');
  }

  Future<void> setQuestionForgotPassword(String question) async {
    await this.storage.write(key: 'question', value: question);
  }

  Future<String?> getQuestionForgotPassword() async {
    return await this.storage.read(key: 'question');
  }

  Future<void> removeAllSecureStorage() async {
    this.storage.deleteAll();
  }
}
