import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:imogoat/controllers/favorite_controller.dart';
import 'package:imogoat/controllers/immobile_controller.dart';
import 'package:imogoat/models/favorite.dart';
import 'package:imogoat/models/rest_client.dart';
import 'package:imogoat/repositories/favorite_repository.dart';
import 'package:imogoat/repositories/immobile_repository.dart';
import 'package:imogoat/screens/user/immobileDetailPage.dart';
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

  bool isLoading = true;
  List<Favorite> favoriteImmobiles = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    setState(() {
      isLoading = true;
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString('id').toString();

    try {
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
        backgroundColor: Color(0xFFF0F2F5),
        title: Text('Meus Favoritos',
          style: TextStyle(
            color: Color(0xFF2E3C4E)
          ),
        ),
      ),
      backgroundColor: Color(0xFFF0F2F5),
      body: isLoading
          ? Center(child: CircularProgressIndicator(
            color: const Color(0xFF265C5F),
          ))
          : favoriteImmobiles.isEmpty
              ? Center(child: Text('Nenhum imóvel favoritado.', 
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
                ),
              ))
              : SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text('Sua lista de favoritos...',
                          style: TextStyle(
                          fontFamily: 'Poppind',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                         ),
                        ),
                        Text('Seus imóveis favoritos ficam aqui,',
                          style: TextStyle(
                          fontFamily: 'Poppind',
                          fontSize: 20,
                          color: Color.fromARGB(255, 46,60,78),
                         ),
                        ),
                        Text('para você ver sempre que quiser.',
                          style: TextStyle(
                          fontFamily: 'Poppind',
                          fontSize: 20,
                          color: Color.fromARGB(255, 46,60,78),
                         ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 350,
                          child: Divider(),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Stack(
                          children: [
                            SizedBox(
                              height: (favoriteImmobiles.length / 2).ceil() * 200,
                              width: MediaQuery.of(context).size.width,
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 1 / 1,
                                ),
                                itemCount: favoriteImmobiles.length,
                                itemBuilder: (context, index) {
                                  final favorite = favoriteImmobiles[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                      MaterialPageRoute(
                                        builder: (context) => 
                                          ImmobileDetailPage(immobile: favorite.immobile)
                                        ),
                                      );
                                    },
                                    child: Card(
                                      color: Colors.white,
                                    elevation: 5.0,
                                    margin: const EdgeInsets.all(7.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          favorite.images.isNotEmpty
                                              ? Image.network(
                                                  favorite.images.first.url,
                                                  height: 100,
                                                  width:
                                                      MediaQuery.of(context).size.width,
                                                  fit: BoxFit.cover,
                                                )
                                              : const Text('Imagem indisponível'),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Text(
                                                favorite.immobile.name,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                  color: Color(0xFF265C5F),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              const Spacer(),
                                              IconButton(
                                                icon: Icon(Icons.favorite, color: Colors.red),
                                                onPressed: () async {
                                                  await removeFavorite(favorite.immobile.id.toString());
                                                  await _loadFavorites();
                                                },
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.apartment,
                                                size: 12,
                                                color: const Color(0xFF265C5F),
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                favorite.immobile.type,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 10,
                                                  color: Color(0xFF265C5F),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
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