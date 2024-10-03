import 'package:imogoat/models/favorite.dart';
import 'package:imogoat/repositories/favorite_repository.dart';

class ControllerFavorite {
  final FavoriteRepository favoriteRepository;
  var _favoriteImmobiles = <Favorite>[];

  ControllerFavorite({required this.favoriteRepository});

  // Método para favoritar o imóvel
  Future<void> favoritarImmobile(String path, int userId, int immobileId) async {
    try {
      await favoriteRepository.favoritarImmobile(path, userId, immobileId);
    } catch (e) {
      print("Erro ao favoritar o imóvel: $e");
    }
  }

  // Getter para buscar os favoritos
  List<Favorite> get favorites {
    return _favoriteImmobiles;
  }

  // Método para buscar imóveis favoritos do usuário
  Future<void> buscarFavoritos(String userId) async {
    try {
      _favoriteImmobiles = await favoriteRepository.buscarFavoritos(userId);
      print('Quantidade de favoritos: ${_favoriteImmobiles.length}');
      _favoriteImmobiles.forEach((fav) {
        print('Imagens para favorito ${fav.id}: ${fav.images}');
      });
    } catch (e) {
      print('Erro ao buscar favoritos: $e');
    }
  }

  Future<void> deleteFavorite(String id) async {
    try {
      await favoriteRepository.deleteFavorite(id);
    } catch (e) {
      print('Erro ao remover o favorito: $e');
    }
  }

}
