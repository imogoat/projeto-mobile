import 'package:imogoat/models/favorite.dart';
import 'package:imogoat/models/rest_client.dart';

class FavoriteRepository {
  final RestClient _rest;
  FavoriteRepository({required RestClient restClient}) : _rest = restClient;

  Future<List<Favorite>> buscarFavoritos(int userId) async {
    final response = await _rest.get('/favorites/$userId');
    return (response as List)
        .map<Favorite>((item) => Favorite.fromMap(item as Map<String, dynamic>))
        .toList();
  }

  Future<bool> favoritarImmobile(String path, int userId, int immobileId) async {

    try {
      await _rest.post(path, {
            'userId': userId,
            'immobileId': immobileId
            },);
      return true;
    } catch(error) {
      return false;
    }
  }
}