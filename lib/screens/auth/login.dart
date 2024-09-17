import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:imogoat/components/loading.dart';
import 'package:imogoat/components/textInput.dart';
import 'package:imogoat/components/passwordInput.dart';
import 'package:imogoat/components/rememberMeRow.dart';
import 'package:imogoat/components/signUpPrompt.dart';
import 'package:imogoat/components/submitButton.dart';
import 'package:imogoat/controllers/user_controller.dart';
import 'package:imogoat/models/rest_client.dart';
import 'package:imogoat/repositories/user_repository.dart';

class LoginPage extends StatefulWidget { 
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool result = false;
  final controller = ControllerUser(userRepository: UserRepository(restClient: GetIt.I.get<RestClient>()));

  Future login(String email, String password) async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          context = context;
          return const Loading();
        }, 
      );
    result = await controller.login('/login', email, password);
    if (result) {
      Navigator.pushNamed(context, '/home');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(

            title: const Text('Login Invalido'),
            content:  Text('Seu E-mail e/ou senha inválidos'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
    } catch(error) {
      print(error);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F2F5),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                ),
                Text('Bem vindo de volta', 
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 46,60,78),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text('Faça login em sua conta',
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 46,60,78),
                  fontFamily: 'Poppins',
                ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 300,
                  child: Divider(),
                ),
                SizedBox(
                  height: 60,
                ),
                Form(
                  child: Column(
                  children: [
                    TextInput(controller: _email, labelText: 'Email', hintText: 'exemplo@gmail.com'),
                    SizedBox(
                      height: 20,
                    ),
                    PasswordInput(controller: _password, labelText: 'Senha', hintText: 'Digite sua senha'),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 365,
                      child: RememberMeRow(
                        onForgotPasswordTap: () {
                          Navigator.pushNamed(context, '/signup');
                        }
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(width: 365,
                      child: ElevatedButton(
                      onPressed: () {
                        login(_email.text, _password.text);
                      }, 
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        side: MaterialStateProperty.all(
                          const BorderSide(
                              color:  Color.fromARGB(255, 24, 157, 130),
                              width: 1.5, // Aumentar a espessura da borda
                            )
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                          )
                        ),
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Color.fromARGB(255, 46,60,78); // Cor ao pressionar
                            }
                            return null; // Defer to the widget's default.
                          }
                        ),
                        elevation: MaterialStateProperty.all(0),
                        minimumSize: MaterialStateProperty.all(const Size(200, 50)),
                      ),
                      child: Text(
                        'Entrar',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color.fromARGB(255, 24, 157, 130),
                          fontSize: 18,
                        ),
                      ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SignUpPrompt(
                      promptText: 'Não tem uma conta? ',
                      actionText: 'Cadastre-se',
                      onSignUpTap: () {
                        Navigator.pushNamed(context, '/signup');  // Rota para a tela de cadastro
                      },
                    )
                  ],
                ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  } 
}