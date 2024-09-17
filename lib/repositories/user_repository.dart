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

    try {
      final response = await _rest.post(path, {
            'email': email,
            'password': password
            },);
      token = response['token'];
      await sharedPreferences.setString('token', token);
      return true;
    } catch(error) {
      return false;
    }
  }
}