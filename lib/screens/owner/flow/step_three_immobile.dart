import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:imogoat/components/appBarCliente.dart';
import 'package:imogoat/components/textInput.dart';
import 'package:imogoat/controllers/immobile_controller.dart';
import 'package:imogoat/models/immobile_post.dart';
import 'package:imogoat/models/rest_client.dart';
import 'package:imogoat/repositories/immobile_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepThreeCreateImmobilePage extends StatefulWidget {
  const StepThreeCreateImmobilePage({super.key});

  @override
  State<StepThreeCreateImmobilePage> createState() => _CreateImmobilePageState();
}

class _CreateImmobilePageState extends State<StepThreeCreateImmobilePage> {
  final _formKey = GlobalKey<FormState>();
  final _value = TextEditingController();
  final _numberOfBedrooms = TextEditingController();
  final _numberOfBathrooms = TextEditingController();
  final _description = TextEditingController();
  final _proprietaryId = TextEditingController();
  ImmobilePost immobile_post = ImmobilePost();
  
  bool _hasGarage = false; // Variável para controlar o estado do Switch

  final controller = ControllerImmobile(
      immobileRepository: ImmobileRepository(restClient: GetIt.I.get<RestClient>()));

  @override
  void dispose() {
    _value.dispose();
    _numberOfBedrooms.dispose();
    _numberOfBathrooms.dispose();
    _description.dispose();
    _proprietaryId.dispose();
    super.dispose();
  }

  // void _cadastrarImovel() {
  //   final name = _name.text;
  //   final number = int.tryParse(_number.text);
  //   final type = _type.text;
  //   final location = _location.text;
  //   final bairro = _bairro.text;
  //   final city = _city.text;
  //   final reference = _reference.text;
  //   final value = double.tryParse(_value.text);
  //   final numberOfBedrooms = int.tryParse(_numberOfBedrooms.text);
  //   final numberOfBathrooms = int.tryParse(_numberOfBathrooms.text);
  //   final description = _description.text;
  //   final proprietaryId = int.tryParse(_proprietaryId.text);

  //   if (name.isEmpty || number == null || type.isEmpty || location.isEmpty ||
  //       bairro.isEmpty || city.isEmpty || reference.isEmpty || value == null ||
  //       numberOfBedrooms == null || numberOfBathrooms == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Por favor, preencha todos os campos corretamente.')),
  //     );
  //     return;
  //   }

  //   final immobileData = {
  //     "name": name,
  //     "number": number,
  //     "type": type,
  //     "location": location,
  //     "bairro": bairro,
  //     "city": city,
  //     "reference": reference,
  //     "value": value,
  //     "numberOfBedrooms": numberOfBedrooms,
  //     "numberOfBathrooms": numberOfBathrooms,
  //     "garagem": _hasGarage, // Usando a variável boolean
  //     "description": description,
  //     "proprietaryId": proprietaryId,
  //   };

  //   controller.createImmobile(immobileData).then((response) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Imóvel cadastrado com sucesso!')),
  //     );
  //     Navigator.pop(context);
  //   }).catchError((error) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Erro ao cadastrar imóvel: $error')),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    ImmobilePost immobile_post_aux = arguments?['immobile_data'];
  
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
                  TextInput(controller: _value, labelText: 'Valor do imóvel', hintText: 'Ex: 800000'),
                  const SizedBox(height: 10),
                  TextInput(controller: _numberOfBedrooms, labelText: 'Número de Quartos', hintText: 'Ex: 3'),
                  const SizedBox(height: 10),
                  TextInput(controller: _numberOfBathrooms, labelText: 'Número de Banheiros', hintText: 'Ex: 2'),
                  const SizedBox(height: 10),
                  const SizedBox(height: 10),
                  TextInput(controller: _description, labelText: 'Descrição', hintText: 'Ex: Um belo AP da cidade.'),
                  const SizedBox(height: 10),
                  TextInput(controller: _proprietaryId, labelText: 'ID do Proprietário', hintText: 'Ex: 2'),
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
                          immobile_post = ImmobilePost(name: immobile_post_aux.name, number: immobile_post_aux.number, type: immobile_post_aux.type, location: immobile_post_aux.location, bairro: immobile_post_aux.bairro, city: immobile_post_aux.city, reference: immobile_post_aux.reference, value: immobile_post_aux.value, numberOfBedrooms: int.parse(_numberOfBedrooms.text), numberOfBathrooms: int.parse(_numberOfBathrooms.text), garagem: _hasGarage, description: _description.text, proprietaryId: int.parse(userId));
                          print('Immobile: ' + immobile_post.toMap().toString());
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
                        'Cadastrar Imóvel',
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
