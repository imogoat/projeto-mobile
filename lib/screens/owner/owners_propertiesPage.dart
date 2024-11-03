import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:imogoat/controllers/immobile_controller.dart';
import 'package:imogoat/models/immobile.dart';
import 'package:imogoat/models/immobile_post.dart';
import 'package:imogoat/models/rest_client.dart';
import 'package:imogoat/repositories/immobile_repository.dart';
import 'package:imogoat/screens/user/immobileDetailPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnersPropertiesPage extends StatefulWidget {
  const OwnersPropertiesPage({super.key});

  @override
  State<OwnersPropertiesPage> createState() => _OwnersPropertiesPageState();
}

class _OwnersPropertiesPageState extends State<OwnersPropertiesPage> {
  final controller = ControllerImmobile(
      immobileRepository: ImmobileRepository(restClient: GetIt.I.get<RestClient>()));
  
  bool isLoading = true;
  List<Immobile> filteredImmobiles = [];

  @override
  void initState() {
    super.initState();
    _loadImmobiles();
  }

  Future<void> _loadImmobiles() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String proprietaryId = sharedPreferences.getString('id').toString();
    print('Id do proprietário: $proprietaryId');
    
    await controller.buscarImmobile();
    filteredImmobiles = controller.immobile.where((immobile) {
      return immobile.proprietaryId.toString() == proprietaryId;
    }).toList();

    setState(() {
      isLoading = false;
    });
  }
      
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0F2F5),
        title: const Text(
          'Imóveis do proprietário',
          style: TextStyle(
            color: Color(0xFF2E3C4E),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF0F2F5),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF265C5F),
              ),
            )
          : filteredImmobiles.isEmpty
              ? const Center(
                  child: Text(
                    'Nenhum imóvel encontrado.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          'Sua lista de imóveis...',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const Text(
                          'Seus imóveis ficam aqui,',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            color: Color(0xFF2E3C4E),
                          ),
                        ),
                        const Text(
                          'para você ver sempre que quiser.',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            color: Color(0xFF2E3C4E),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(
                          width: 350,
                          child: Divider(),
                        ),
                        const SizedBox(height: 50),
                        SizedBox(
                          height: (filteredImmobiles.length / 2).ceil() * 200,
                          width: MediaQuery.of(context).size.width,
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1 / 1,
                            ),
                            itemCount: filteredImmobiles.length,
                            itemBuilder: (context, index) {
                              final immobile = filteredImmobiles[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
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
                                        const SizedBox(height: 15),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              immobile.name,
                                              style: const TextStyle(
                                               fontWeight: FontWeight.bold,
                                               fontSize: 10,
                                               color: Color(0xFF265C5F),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.apartment,
                                              size: 12,
                                              color: Color(0xFF265C5F),
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
                  ),
                ),
    );
  }
}
