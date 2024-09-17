import 'package:flutter/material.dart';
import 'package:imogoat/models/user.dart';
import 'package:imogoat/repositories/user_repository.dart';

class ControllerUser extends ChangeNotifier {
  final UserRepository _repository;
  bool result = false;
  String search = "";

  var _users = <User>[];
  bool loading = false;
  bool searching = false;

  void changeSearch(String key) {
    search = key;
    notifyListeners();
  }

  void changeSearching() {
    searching = !searching;
    if (!searching) search = "";
    notifyListeners();
  }

  ControllerUser({required UserRepository userRepository}) : _repository = userRepository;

  List<User> get user {
    return _users
        .where((e) => e.username.toLowerCase().contains(search.toLowerCase())).toList();
  }

  Future<bool> login(String path, String email, String password) async {
    try {
      loading = true;
      result = await _repository.loginUser(path, email, password);
    } finally {
      loading = false;
      return result;
    }
  }

}