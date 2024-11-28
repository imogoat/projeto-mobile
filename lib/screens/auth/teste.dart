import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:imogoat/controllers/user_controller.dart';
import 'package:imogoat/models/rest_client.dart';
import 'package:imogoat/repositories/user_repository.dart';
import 'package:imogoat/styles/color_constants.dart';

class RecoveryPage extends StatefulWidget {
  const RecoveryPage({super.key});

  @override
  State<StatefulWidget> createState() => _RecoveryPageState();
}

class _RecoveryPageState extends State<RecoveryPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final controller = ControllerUser(
      userRepository: UserRepository(restClient: GetIt.I.get<RestClient>()));

  Future<void> sendEmail(String email) async {
    print('Email: ${email}');

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: verde_escuro,
        ),
      ),
    );

    try {
      print('Entrou 1');
      final result = await controller.sendEmail('/esqueci', email);
      Navigator.pop(context);
      print('Saiu 1');

      if (result) {
        _showAlertDialog(
          'E-mail Enviado',
          'O e-mail foi enviado com sucesso. Verifique sua caixa de entrada para instruções.',
        );
      } else {
        _showAlertDialog(
          'Erro',
          'Não foi possível enviar o e-mail. Verifique os dados e tente novamente.',
        );
      }
    } catch (error) {
      Navigator.pop(context);
      _showAlertDialog(
        'Erro',
        'Ocorreu um erro ao enviar o e-mail. Tente novamente mais tarde.',
      );
    }
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: TextStyle(
          color: verde_black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: 'Poppins',
        ),),
        content: Text(message, style: TextStyle(
          color: verde_medio,
          fontWeight: FontWeight.normal,
          fontSize: 16,
          fontFamily: 'Poppins',
        ),),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/reset_password');
            },
            child: const Text('OK',
            style: TextStyle(
                color: verde_medio,
                fontWeight: FontWeight.bold,
                // fontSize: 22,
                fontFamily: 'Poppins',
            ),),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 150),
              Text(
                textAlign: TextAlign.center,
                'Redefinir Minha Senha',
                style: TextStyle(
                  color: verde_medio,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                textAlign: TextAlign.justify,
                'Para sua segurança, enviaremos um código para o e-mail cadastrado em nosso sistema, permitindo a redefinição da senha. (Certifique-se de usar o e-mail correto, cadastrado no sistema.)',
                style: TextStyle(
                  color: Color(0xFF2E3C4E),
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    hintText: 'Digite seu e-mail',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey), // Cor da borda padrão
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey), // Borda padrão
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: verde_black), // Borda verde ao focar
                    ),
                    floatingLabelStyle: TextStyle(
                      color: verde_medio, // Cor do label ao focar
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite um e-mail.';
                    } else if (!RegExp(
                            r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
                        .hasMatch(value)) {
                      return 'E-mail inválido';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      sendEmail(_emailController.text.trim());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF265C5F),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Enviar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
