import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
// import 'package:imogoat/components/NavigationBarCliente.dart';
import 'package:imogoat/components/appBarCliente.dart';
import 'package:imogoat/components/buttonHomeCliente.dart';
import 'package:imogoat/components/buttonHomeSearch.dart';
import 'package:imogoat/components/drawerCliente.dart';
import 'package:imogoat/controllers/immobile_controller.dart';
import 'package:imogoat/models/rest_client.dart';
import 'package:imogoat/repositories/immobile_repository.dart'; // Importe o componente de navegação

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final name = TextEditingController();
  final controller = ControllerImmobile(immobileRepository: ImmobileRepository(restClient: GetIt.I.get<RestClient>()));
  // int _page = 0; // Controla a página atual

  @override
  void initState() {
    controller.buscarImmobile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBarCliente(),
      drawer: DrawerCliente(),
      
      // Adiciona o CustomCurvedNavigationBar
      // bottomNavigationBar: CustomCurvedNavigationBar(
      //   currentIndex: _page, // Define a página atual
      //   onTap: (index) {
      //     setState(() {
      //       _page = index; // Atualiza a página ao clicar no ícone da navegação
      //     });
      //   },
      // ),

      body: SingleChildScrollView(
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
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(Icons.search),
                                          labelText: 'Bairro de interesse',
                                          labelStyle: TextStyle(color: Colors.black),
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
                                    onPressed: () {},
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

            Stack(
              children: [
                SizedBox(
                  height: 400,
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3 / 2,
                    ),
                    itemCount: controller.immobile.length,
                    itemBuilder: (context, index) {
                      final immobile = controller.immobile[index];
                      return GestureDetector(
                        onTap: () {},
                        child: Card(
                          elevation: 5.0,
                          margin: const EdgeInsets.all(6.0),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                immobile.images.isNotEmpty
                                  ? Image.network(
                                      immobile.images.first.url,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : const Text('Imagem indisponível'),
                                const SizedBox(height: 5),
                                Text(
                                  immobile.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 29, 118, 233),
                                  ),
                                  textAlign: TextAlign.center,
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
      ),
    );
  }
}
