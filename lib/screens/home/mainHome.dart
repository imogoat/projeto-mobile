import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:imogoat/components/buttonHomeCliente.dart';
import 'package:imogoat/components/buttonHomeSearch.dart';
import 'package:imogoat/controllers/favorite_controller.dart';
import 'package:imogoat/controllers/immobile_controller.dart';
import 'package:imogoat/models/rest_client.dart';
import 'package:imogoat/repositories/favorite_repository.dart';
import 'package:imogoat/repositories/immobile_repository.dart';
import 'package:imogoat/screens/user/immobileDetailPage.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  final controller = ControllerImmobile(immobileRepository: ImmobileRepository(restClient: GetIt.I.get<RestClient>()));
  final controllerFavorite = ControllerFavorite(favoriteRepository: FavoriteRepository(restClient: GetIt.I.get<RestClient>()));

  bool _isLoading = true;
  List<bool> isFavorited = [];

  @override
  void initState() {
    super.initState();
    _loadImmobiles();
  }

  Future<void> _loadImmobiles() async {
    await controller.buscarImmobile();
    isFavorited = List.generate(controller.immobile.length, (index) => false);
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _searchImmobiles() async {
    setState(() {
      _isLoading = true;
    });
    await controller.buscarImmobile(); // Recarrega os imóveis ao clicar no botão de pesquisar
    setState(() {
      _isLoading = false;
    });
  }

  Future favorite(int userId, int immobileId) async {
    try {
      await controllerFavorite.favoritarImmobile('/create-favorites', userId, immobileId);
    } catch(error) {
      print(error);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Color(0xFF265C5F),
              ), // Mostra o indicador de carregamento
            ) : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Conteúdo da página
                  Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          child: Image.asset(
                            "assets/images/header.jpeg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Encontre facilmente onde ficar!',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: Container(
                                width: 350,
                                height: 110,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SubmitButtonHome(texto: 'Apartamento', onPressed: () {}),
                                        const SizedBox(width: 3.5),
                                        SubmitButtonHome(texto: 'Casa', onPressed: () {}),
                                        const SizedBox(width: 3.5),
                                        SubmitButtonHome(texto: 'Quitinete', onPressed: () {}),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(15),
                                            child: TextFormField(
                                              cursorColor: Colors.black,
                                              onChanged: (value) {
                                                setState(() {
                                                  controller.changeSearch(value);
                                                });
                                              },
                                              decoration: const InputDecoration(
                                                prefixIcon: Icon(Icons.search),
                                                labelText: 'Bairro de interesse',
                                                labelStyle: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontSize: 14),
                                                contentPadding: EdgeInsets.zero,
                                                filled: true,
                                                fillColor: Color(0xFFD4D4D4),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        CustomButtonSearch(
                                          text: 'Pesquisar',
                                          onPressed: () {
                                            _searchImmobiles();
                                          },
                                        ),
                                        const SizedBox(width: 10),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  controller.immobile.isEmpty 
                  ? const Center(
                          child: Text(
                            "Nenhum imóvel encontrado",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        )
                  : Stack(
                    children: [
                      SizedBox(
                        height: (controller.immobile.length / 2).ceil() * 200,
                        width: MediaQuery.of(context).size.width,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1 / 1,
                          ),
                          itemCount: controller.immobile.length,
                          itemBuilder: (context, index) {
                            final immobile = controller.immobile[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => ImmobileDetailPage(immobile: immobile),
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
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      immobile.images.isNotEmpty
                                          ? Image.network(
                                              immobile.images.first.url,
                                              height: 100,
                                              width: MediaQuery.of(context).size.width,
                                              fit: BoxFit.cover,
                                            )
                                          : const Text('Imagem indisponível'),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text(
                                            immobile.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                              color: Color(0xFF265C5F),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isFavorited[index] = !isFavorited[index];
                                              });
                                              final immobileId = controller.immobile[index].id;
                                              final userId = 3; // Pegue o ID do usuário logado (você pode obter isso de uma sessão ou contexto)
                                              
                                              if (isFavorited[index]) {
                                                favorite(userId, immobileId);
                                              }
                                            },
                                            icon: Icon(
                                              isFavorited[index] ? Icons.favorite : Icons.favorite_border,
                                              color: isFavorited[index] ? Colors.red : Colors.grey,
                                            ),
                                          )
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
                                            immobile.type,
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
                  ),
                ],
              ),
            );
  }
}