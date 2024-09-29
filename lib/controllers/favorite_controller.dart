import 'package:imogoat/models/favorite.dart';
import 'package:imogoat/repositories/favorite_repository.dart';

class ControllerFavorite {
  final FavoriteRepository favoriteRepository;

  ControllerFavorite({required this.favoriteRepository});

  Future<void> favoritarImmobile(String path, int userId, int immobileId) async {
    try {
      await favoriteRepository.favoritarImmobile(path, userId, immobileId);
    } catch (e) {
      print("Erro ao favoritar o imóvel: $e");
    }
  }

  List<Favorite> favoriteImmobiles = [];

  Future<void> buscarFavoritos(int userId) async {
    try {
      favoriteImmobiles = await favoriteRepository.buscarFavoritos(userId);
    } catch (e) {
      print('Erro ao buscar favoritos: $e');
    }
  }

}
