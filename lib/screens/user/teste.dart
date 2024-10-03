import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:imogoat/controllers/favorite_controller.dart';
import 'package:imogoat/controllers/immobile_controller.dart';
import 'package:imogoat/models/favorite.dart';
import 'package:imogoat/models/rest_client.dart';
import 'package:imogoat/repositories/favorite_repository.dart';
import 'package:imogoat/repositories/immobile_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final controller = ControllerImmobile(
      immobileRepository: ImmobileRepository(restClient: GetIt.I.get<RestClient>()));
  final controllerFavorite = ControllerFavorite(
      favoriteRepository: FavoriteRepository(restClient: GetIt.I.get<RestClient>()));

  bool isLoading = true; // Para controlar o carregamento
  List<Favorite> favoriteImmobiles = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  // Método para carregar os favoritos
  Future<void> _loadFavorites() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Substitua o userId por um valor real (pode vir do SharedPreferences, por exemplo)
      String userId = "3"; 
      await controllerFavorite.buscarFavoritos(userId);
      
      setState(() {
        favoriteImmobiles = controllerFavorite.favorites;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Erro ao carregar favoritos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Favoritos'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : favoriteImmobiles.isEmpty
              ? Center(child: Text('Nenhum imóvel favoritado.'))
              : ListView.builder(
                  itemCount: favoriteImmobiles.length,
                  itemBuilder: (context, index) {
                    final favorite = favoriteImmobiles[index];
                    return ListTile(
                      leading: Icon(Icons.home),
                      title: Text(favorite.immobile.name),
                      subtitle: Text('Type: ${favorite.immobile.type}'),
                      trailing: IconButton(
                        icon: Icon(Icons.favorite, color: Colors.red),
                        onPressed: () async {
                          await removeFavorite(favorite.immobile.id.toString());
                          _loadFavorites(); // Atualiza a lista após remoção
                        },
                      ),
                    );
                  },
                ),
    );
  }

  // Função para remover favorito (mesmo código anterior)
  Future<void> removeFavorite(String immobileId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString('id').toString();
    
    try {
      await controllerFavorite.buscarFavoritos(userId);

      int? favoriteId; 

      for (var fav in controllerFavorite.favorites) {
        if (fav.immobileId.toString() == immobileId) {
          favoriteId = fav.id;
          break;
        }
      }

      if (favoriteId != null) {
        await controllerFavorite.deleteFavorite(favoriteId.toString());
        print('Favorito removido com sucesso!');
      } else {
        print('Nenhum favorito encontrado para este imóvel.');
      }
    } catch (e) {
      print('Erro ao remover o favorito: $e');
    }
  }
}
