import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:imogoat/components/appBarCliente.dart';
import 'package:imogoat/components/loading.dart';
import 'package:imogoat/components/textInput.dart';
import 'package:imogoat/controllers/immobile_controller.dart';
import 'package:imogoat/models/immobile_post.dart';
import 'package:imogoat/models/rest_client.dart';
import 'package:imogoat/repositories/immobile_repository.dart';
import 'package:imogoat/screens/home/home.dart';
import 'package:imogoat/screens/owner/flow/step_four_immobile.dart';
import 'package:imogoat/styles/color_constants.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepThreeCreateImmobilePage extends StatefulWidget {
  const StepThreeCreateImmobilePage({super.key});

  @override
  State<StepThreeCreateImmobilePage> createState() => _CreateImmobilePageState();
}

class _CreateImmobilePageState extends State<StepThreeCreateImmobilePage> {
  final _formKey = GlobalKey<FormState>();
  final _valueImmobile= TextEditingController();
  final _numberOfBedrooms = TextEditingController();
  final _numberOfBathrooms = TextEditingController();
  final _description = TextEditingController();
  ImmobilePost immobile_post = ImmobilePost();
  
  bool _hasGarage = false; // Variável para controlar o estado do Switch

  final controller = ControllerImmobile(
      immobileRepository: ImmobileRepository(restClient: GetIt.I.get<RestClient>()));

  @override
  void dispose() {
    _valueImmobile.dispose();
    _numberOfBedrooms.dispose();
    _numberOfBathrooms.dispose();
    _description.dispose();
    super.dispose();
  }

Future<void> _showDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Dados Inválidos', 
          style: TextStyle(
            color: verde_black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Poppins',
          )),
          content: const Text('Preencha todos os campos corretamente!',
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

  Future<void> createImmobile(ImmobilePost data) async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          context = context;
          return const Loading();
        }, 
      );
      await controller.createImmobile('/create-immobile', data);
      // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      Navigator.push(context, MaterialPageRoute(builder: (context) => StapeFourCreateImmobilePage()));
    } catch (error) {
      print('Erro ao criar o imóvel: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    ImmobilePost immobile_post_aux = arguments?['immobile_data'];

    // final maskFormatter = MaskTextInputFormatter(
    //   mask: '###.###.###,##',
    //   filter: { "#": RegExp(r'[0-9]') }, 
    // );
  
    // print('Teste: ' + immobile_post_aux.toMap().toString());
    
    return Scaffold(
      appBar: AppBarCliente(),
      backgroundColor: const Color(0xFFF0F2F5),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Cadastre o seu imóvel',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF1F7C70),
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextInput(controller: _valueImmobile, labelText: 'Valor do imóvel', hintText: 'Ex: 1.000,00',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O campo não pode ser vazio';
                    }
                    return null;
                  }),
                  const SizedBox(height: 10),
                  TextInput(controller: _numberOfBedrooms, labelText: 'Número de Quartos', hintText: 'Ex: 3',
                  keyboardType: TextInputType.number, 
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O campo não pode ser vazio';
                    }
                    return null;
                  }),
                  const SizedBox(height: 10),
                  TextInput(controller: _numberOfBathrooms, labelText: 'Número de Banheiros', hintText: 'Ex: 2',
                  keyboardType: TextInputType.number, 
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O campo não pode ser vazio';
                    }
                    return null;
                  }),
                  const SizedBox(height: 10),
                  const SizedBox(height: 10),
                  TextInput(controller: _description, labelText: 'Descrição', hintText: 'Ex: Um belo AP da cidade.',
                  keyboardType: TextInputType.name, 
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O campo não pode ser vazio';
                    }
                    return null;
                  }),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0), // Ajuste o valor conforme necessário
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Possui Garagem?',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1F7C70)),
                        ),
                        Switch(
                          value: _hasGarage,
                          activeColor: const Color(0xFF1F7C70),
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.grey.shade300,
                          onChanged: (value) {
                            setState(() {
                              _hasGarage = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 365,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                          String userId = sharedPreferences.getString('id').toString();
                          immobile_post = ImmobilePost(name: immobile_post_aux.name, number: immobile_post_aux.number, type: immobile_post_aux.type, location: immobile_post_aux.location, bairro: immobile_post_aux.bairro, city: immobile_post_aux.city, reference: immobile_post_aux.reference, value: double.parse(_valueImmobile.text), numberOfBedrooms: int.parse(_numberOfBedrooms.text), numberOfBathrooms: int.parse(_numberOfBathrooms.text), garagem: _hasGarage, description: _description.text, proprietaryId: int.parse(userId));
                          print('Immobile: ' + immobile_post.toMap().toString());
                          createImmobile(immobile_post);
                        } else {
                          _showDialog(context);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color(0xFF265C5F)),
                        side: MaterialStateProperty.all(const BorderSide(color: Color(0xFF265C5F), width: 1.5)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                        overlayColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.white;
                          }
                          return null;
                        }),
                        elevation: MaterialStateProperty.all(0),
                        minimumSize: MaterialStateProperty.all(const Size(200, 50)),
                      ),
                      child: const Text(
                        'Próximo',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
