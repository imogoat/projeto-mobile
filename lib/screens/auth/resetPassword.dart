import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:imogoat/components/loading.dart';
import 'package:imogoat/components/passwordInput.dart';
import 'package:imogoat/components/textInput.dart';
import 'package:imogoat/controllers/user_controller.dart';
import 'package:imogoat/models/rest_client.dart';
import 'package:imogoat/repositories/user_repository.dart';
import 'package:imogoat/styles/color_constants.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _tokenController = TextEditingController();
  final _passwordController = TextEditingController();
  final controller = ControllerUser(userRepository: UserRepository(restClient: GetIt.I.get<RestClient>()));

  Future<void> resetPassword(String token, String password) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => const Loading(),
      );

      print('Entrou');
      final result = await controller.resetPassword('/trocarSenha', token, password);
      Navigator.pop(context);
      print('Saiu');

      if (result) {
        // Exibe mensagem de sucesso e redireciona para login
        _showAlertDialog('Sucesso', 'Senha redefinida com sucesso!');
      } else {
        _showAlertDialog('Alerta', 'Não foi possível redefinir a senha. Verifique os dados e tente novamente.');
      }
    } catch (error) {
      Navigator.pop(context); // Fecha o diálogo de carregamento em caso de erro
      _showAlertDialog('Erro', 'Ocorreu um erro ao redefinir a senha. Tente novamente mais tarde.');
      print(error);
    }
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, 
          style: TextStyle(
            color: verde_black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Poppins',
          ),),
          content: Text(message,
          style: TextStyle(
            color: verde_medio,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'Poppins',
          ),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/');
              },
              child: const Text('OK',
              style: TextStyle(
                color: Color(0xFF1F7C70),
                fontWeight: FontWeight.bold,
                // fontSize: 22,
                fontFamily: 'Poppins',
              ),),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _tokenController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              Center(
                child: Text(
                  'Redefinir Senha',
                  style: TextStyle(
                    color: verde_medio,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Insira o código de segurança que foi enviado para o seu e-mail cadastrado e escolha uma nova senha. Certifique-se de copiar o código corretamente.',
                textAlign: TextAlign.justify,
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
                child: Column(
                  children: [
                    TextInput(
                      controller: _tokenController,
                      labelText: 'Token',
                      hintText: 'Insira o código de segurança',
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o token.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    PasswordInput(
                      controller: _passwordController,
                      labelText: 'Nova Senha',
                      hintText: 'Digite sua nova senha',
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'A senha deve ter pelo menos 6 caracteres.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print('Token: ${_tokenController.text.trim()}');
                          print('Nova Senha: ${_passwordController.text.trim()}');
                          resetPassword(_tokenController.text.trim(), _passwordController.text.trim());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF265C5F),
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Redefinir',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
