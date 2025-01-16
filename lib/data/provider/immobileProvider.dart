// import 'package:flutter/material.dart';
// import 'package:imogoat/models/immobile.dart';
// import 'package:imogoat/repositories/immobile_repository.dart';
// import 'package:imogoat/styles/color_constants.dart';

// class ImmobileProvider extends ChangeNotifier {
//   final ImmobileRepository immobileRepository;
//   List<Immobile> _filteredImmobiles = [];
//   bool _isLoading = true;

//   List<Immobile> get immobile => _filteredImmobiles;
//   bool get isLoading => _isLoading;

//   String search = "";
//   bool searching = false;

//   ImmobileProvider({required this.immobileRepository});

//   // Confirmar exclusão do imóvel
//   Future<void> confirmDelete(BuildContext context, String immobileId) async {
//     final confirmed = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             'Confirmar exclusão',
//             style: TextStyle(
//                 color: verde_medio,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//                 fontFamily: 'Poppins'),
//           ),
//           content: Text(
//             'Tem certeza de que deseja excluir este imóvel?',
//             style: TextStyle(
//                 color: verde_black,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//                 fontFamily: 'Poppins'),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context, false);
//               },
//               child: Text(
//                 'Cancelar',
//                 style: TextStyle(
//                     color: Colors.grey,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Poppins'),
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context, true);
//               },
//               child: Text(
//                 'Excluir',
//                 style: TextStyle(
//                     color: Colors.red,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Poppins'),
//               ),
//             ),
//           ],
//         );
//       },
//     );

//     if (confirmed == true) {
//       await deleteImmobile(immobileId, context);
//     }
//   }

//   // Função para excluir o imóvel
//   Future<void> deleteImmobile(String immobileId, BuildContext context) async {
//     _isLoading = true;
//     notifyListeners(); // Notifica que está carregando

//     try {
//       await immobileRepository.deleteImmobile(immobileId);
//       // Remove o imóvel da lista local
//       _filteredImmobiles.removeWhere((immobile) => immobile.id == immobileId);
//       notifyListeners(); // Notifica que a lista foi atualizada
//       await loadImmobiles();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Imóvel deletado com sucesso')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Erro ao deletar imóvel: $e')),
//       );
//     } finally {
//       _isLoading = false;
//       notifyListeners(); // Notifica que a operação foi concluída
//     }
//   }

//   // Função para pesquisar imóveis
//   void changeSearch(String key) {
//     search = key;
//     notifyListeners();
//   }

//   // Alterna o estado de busca
//   void changeSearching() {
//     searching = !searching;
//     if (!searching) search = "";
//     notifyListeners();
//   }

//   // Função centralizada para alterar o estado de carregamento
//   void _setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }

//   // Função para carregar imóveis
//   Future<void> loadImmobiles() async {
//     if (_filteredImmobiles.isNotEmpty && !_isLoading) {
//       return;
//     }

//     _setLoading(true);
//     try {
//       final fetchedImmobiles = await immobileRepository.buscarImmobiles();
//       _filteredImmobiles = fetchedImmobiles;
//     } catch (e) {
//       print('Erro ao carregar imóveis: $e');
//     } finally {
//       _setLoading(false);
//     }
//   }

//   Future<void> searchImmobiles() async {
//     try {
//       // Se a busca já está aplicada, não faz sentido fazer nova requisição
//       if (search.isEmpty) {
//         return;
//       }

//       final fetchedImmobiles = await immobileRepository.buscarImmobiles();

//       // Filtra os imóveis com base na pesquisa
//       _filteredImmobiles = fetchedImmobiles.where((immobile) {
//         return immobile.name.toLowerCase().contains(search.toLowerCase());
//       }).toList();

//       notifyListeners(); // Notifica a UI sobre a alteração nos dados
//     } catch (error) {
//       print('Erro ao buscar imóveis: $error');
//     }
//   }
// }
