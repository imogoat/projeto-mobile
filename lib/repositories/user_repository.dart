import 'package:imogoat/models/user.dart';
import 'package:imogoat/models/rest_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final RestClient _rest;
  UserRepository({required RestClient restClient}) : _rest = restClient;

  Future<List<User>> searchUser() async {
    final response = await _rest.get('user');
    return response["groups"].map<User>(User.fromMap).toList();
  }

  Future<bool> loginUser(String path, String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token;
    int id_user = 0;
    String role = '';

    try {
      final response = await _rest.post(path, {
            'email': email,
            'password': password
            },);
      token = response['token'];
      id_user = response['id'];
      role = response['role'];
      await sharedPreferences.setString('id', id_user.toString());
      await sharedPreferences.setString('role', role);
      await sharedPreferences.setString('token', token);
      return true;
    } catch(error) {
      return false;
    }
  }

  Future<bool> signUpUser(String path, String username, String email, String password, String number, String role) async {

    print('Nome: $username - Email $email - Password $password - Número $number - Role $role');
    print(path);

    try {
      await _rest.post(path, {
        "username": username,
        "email": email,
        "password": password,
        "number": number,
        "role": role,
      },);

      return true;
    } catch (error) {
      print("Erro ao criar usuário: $error");
      return false;
    }
  }

  Future<bool> updateUser(String path, String role) async {
    try {
      await _rest.put(path, {
        "role": role,
      },);
      print('FELICIDADE');
      return true;
    } catch (error) {
      print("Erro ao atualizar usuário: $error");
      return false;
    }
  }
}