import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:imogoat/components/loading.dart';
import 'package:imogoat/components/passwordInput.dart';
import 'package:imogoat/components/signUpPrompt.dart';
import 'package:imogoat/components/textInput.dart';
import 'package:imogoat/controllers/user_controller.dart';
import 'package:imogoat/models/rest_client.dart';
import 'package:imogoat/repositories/user_repository.dart';
import 'package:imogoat/styles/color_constants.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmaSenha = TextEditingController();
  final _number = TextEditingController();
  final role = 'user';
  final controller = ControllerUser(userRepository: UserRepository(restClient: GetIt.I.get<RestClient>()));
  bool result = false;

  var maskFormatter = MaskTextInputFormatter(
    mask: '(##)# ####-####', 
    filter: { "#": RegExp(r'[0-9]') }, 
  );

  Future signUp(String username, String email, String number, String password) async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const Loading();
        },
      );
      result = await controller.signUpUser('/create-user', username, email, password, number, role);
      Navigator.pop(context);
      if (result) {
        Navigator.pushNamed(context, '/login');
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Alerta',
              style: TextStyle(
                color: verde_black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Poppins',
              )),
              content: const Text('Não foi possível cadastrar seu Usuário!',
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
                    color: verde_medio,
                    fontWeight: FontWeight.bold,
                    // fontSize: 22,
                    fontFamily: 'Poppins',
                  ),),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      Navigator.pop(context);
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  const Text(
                    'Cadastre-se',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 46, 60, 78),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Começar é fácil',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 46, 60, 78),
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(
                    width: 300,
                    child: Divider(),
                  ),
                  const SizedBox(height: 30),
                  TextInput(
                    controller: _username,
                    labelText: 'Nome de usuário',
                    hintText: 'Nome',
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 20),
                  TextInput(
                    controller: _email,
                    labelText: 'Email',
                    hintText: 'exemplo@gmail.com',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  TextInput(
                    controller: _number,
                    labelText: 'Telefone',
                    hintText: '(89)9 9999-9999',
                    keyboardType: TextInputType.phone,
                    inputFormatters: [maskFormatter],
                  ),
                  const SizedBox(height: 20),
                  PasswordInput(
                    controller: _password,
                    labelText: 'Senha',
                    hintText: 'Digite sua senha',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'A senha não pode ser vazia';
                      } else if (value.length < 6) {
                        return 'A senha deve ter pelo menos 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  PasswordInput(
                    controller: _confirmaSenha,
                    labelText: 'Confirmação de Senha',
                    hintText: 'Confirme sua senha',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'A confirmação de senha não pode ser vazia';
                      } else if (value != _password.text) {
                        return 'As senhas não são iguais';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 365,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signUp(_username.text.trim(), _email.text.trim(), _number.text.trim(), _password.text.trim());
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        side: MaterialStateProperty.all(
                          const BorderSide(
                            color: Color.fromARGB(255, 24, 157, 130),
                            width: 1.5,
                          ),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return const Color.fromARGB(255, 46, 60, 78);
                            }
                            return null;
                          },
                        ),
                        elevation: MaterialStateProperty.all(0),
                        minimumSize: MaterialStateProperty.all(const Size(200, 50)),
                      ),
                      child: const Text(
                        'Criar Conta',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color.fromARGB(255, 24, 157, 130),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SignUpPrompt(
                    promptText: 'Já possui uma conta? ',
                    actionText: 'Login',
                    onSignUpTap: () {
                      Navigator.pushNamed(context, '/');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}