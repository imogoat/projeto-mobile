// import 'package:flutter/material.dart';
// import 'package:imogoat/models/immobile.dart';

// class ImmobileProvider with ChangeNotifier {
//   List<Immobile> _immobiles = [];
//   bool _isLoading = true;

//   ImmobileProvider();

//   List<Immobile> get immobiles => _immobiles;
//   bool get isLoading => _isLoading;

//   Future<void> loadImmobiles() async {
//     if (_immobiles.isNotEmpty) {
//       // Não faz nova requisição se já houver dados
//       _isLoading = false;
//       notifyListeners();
//       return;
//     }

//     try {
//       _isLoading = true;
//       notifyListeners();
//       final fetchedImmobiles = await repository.buscarImmobiles();
//       _immobiles = fetchedImmobiles;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<void> deleteImmobile(String immobileId) async {
//     try {
//       await repository.deleteImmobile(immobileId);
//       _immobiles.removeWhere((immobile) => immobile.id == immobileId);
//       notifyListeners();
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
