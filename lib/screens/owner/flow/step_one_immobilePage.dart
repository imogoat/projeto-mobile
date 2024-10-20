import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:imogoat/components/appBarCliente.dart';
import 'package:imogoat/components/textInput.dart';
import 'package:imogoat/controllers/immobile_controller.dart';
import 'package:imogoat/models/immobile_post.dart';
import 'package:imogoat/models/rest_client.dart';
import 'package:imogoat/repositories/immobile_repository.dart';
import 'package:imogoat/screens/owner/flow/step_two_immobile.dart';

class StapeOneCreateImmobilePage extends StatefulWidget {
  const StapeOneCreateImmobilePage({super.key});

  @override
  State<StapeOneCreateImmobilePage> createState() => _CreateImmobilePageState();
}

class _CreateImmobilePageState extends State<StapeOneCreateImmobilePage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _number = TextEditingController();
  final _type = TextEditingController();

  ImmobilePost immobile_post = ImmobilePost();
  
  // bool _hasGarage = false; // Variável para controlar o estado do Switch

  final controller = ControllerImmobile(
      immobileRepository: ImmobileRepository(restClient: GetIt.I.get<RestClient>()));

  @override
  void dispose() {
    _name.dispose();
    _number.dispose();
    _type.dispose();
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
                  TextInput(controller: _name, labelText: 'Nome do imóvel', hintText: 'Ex: Apartamento 01'),
                  const SizedBox(height: 10),
                  TextInput(controller: _number, labelText: 'Número do imóvel', hintText: 'Ex: 123'),
                  const SizedBox(height: 10),
                  TextInput(controller: _type, labelText: 'Tipo do imóvel', hintText: 'Ex: apartamento/casa/quitinete'),
                  const SizedBox(height: 10),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 365,
                    child: ElevatedButton(
                      onPressed: () {
                        immobile_post = ImmobilePost(name: _name.text, number: int.parse(_number.text), type: _type.text);
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushNamed(context, '/step_two', arguments: {
                          "immobile_data": immobile_post
                        });
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
