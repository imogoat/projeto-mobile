import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:imogoat/controllers/user_controller.dart';
import 'package:imogoat/models/rest_client.dart';
import 'package:imogoat/repositories/user_repository.dart';
import 'package:imogoat/screens/owner/flow/step_one_immobilePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:imogoat/styles/color_constants.dart';

class CampaignPage extends StatefulWidget {
  const CampaignPage({super.key});

  @override
  State<CampaignPage> createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
  final controller = ControllerUser(userRepository: UserRepository(restClient: GetIt.I.get<RestClient>()));

  Future<void> _updateUserType() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString('id').toString();
    try {
      await controller.updateUser('/alter-user/$userId', 'owner');
      Navigator.push(context, MaterialPageRoute(builder: (context) => StapeOneCreateImmobilePage()));
    } catch (error) {
      print('Erro ao buscar Id do usuário: $error');
    }
  }

  Future<void> _showDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Anúncio de Vaga', 
          style: TextStyle(
            color: verde_black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Poppins',
          )),
          content: const Text('Opção indisponível no momento',
          style: TextStyle(
            color: verde_medio,
            fontWeight: FontWeight.normal,
            fontSize: 16,
            fontFamily: 'Poppins',
          )),
          actions: [
            TextButton(
              child: const Text('OK', 
              style: TextStyle(
                color: Color(0xFF1F7C70),
                fontWeight: FontWeight.bold,
                // fontSize: 22,
                fontFamily: 'Poppins',
              ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.circle_outlined),
        backgroundColor: Color(0xFFF0F2F5),
        title: Text(
          'Anúncio',
          style: TextStyle(color: Color(0xFF2E3C4E)),
        ),
      ),
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(height: 5),
                ClipRRect(
                  child: Image.asset(
                    width: 250,
                    height: 170,
                    "assets/images/image-anuncio-transparente.png",
                    fit: BoxFit.fill
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Anuncie seu imóvel no ImoGOAT e alcance inquilinos que valorizam seu espaço. A inscrição é simples, rápida e gratuita, e nós conectamos você a quem está procurando o lar ideal. Deixe que o ImoGOAT faça seu imóvel se destacar!',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Color(0xFF2E3C4E),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'O que você gostaria de anunciar hoje?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF1F7C70),
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Primeiro botão - Anunciar Imóvel
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12), // Aplica o raio à borda e à sombra
                      ),
                      child: SizedBox(
                        width: 166,
                        height: 166,
                        child: ElevatedButton(
                          onPressed: () {
                            _updateUserType();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white, // Cor de fundo do botão
                            side: BorderSide(
                              color: Color(0xFF1F7C70), // Cor da borda
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0, // Elevação zerada, pois o Container aplica a sombra
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home,
                                size: 40,
                                color: Colors.black,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Imóvel',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Se você é proprietário',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SizedBox(
                        width: 166,
                        height: 166,
                        child: ElevatedButton(
                          onPressed: () {
                            _showDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(
                              color: Color(0xFF1F7C70),
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.apartment,
                                size: 40,
                                color: Colors.black,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Vaga',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Se deseja dividir contas',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
