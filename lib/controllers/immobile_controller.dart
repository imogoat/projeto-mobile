import 'package:flutter/material.dart';
import 'package:imogoat/models/immobile.dart';
import 'package:imogoat/repositories/immobile_repository.dart';

class ControllerImmobile extends ChangeNotifier {
  final ImmobileRepository _repository;
  bool result = true;
  String search = "";

  var _immobiles = <Immobile>[];
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

  ControllerImmobile({required ImmobileRepository immobileRepository}) : _repository = immobileRepository;

  List<Immobile> get immobile {
    return _immobiles
        .where((e) => e.name.toLowerCase().contains(search.toLowerCase())).toList();
  }

  Future<void> buscarImmobile() async {
    try {
      loading = true;
      _immobiles = await _repository.buscarImovel();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}