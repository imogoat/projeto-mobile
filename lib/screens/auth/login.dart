import 'package:flutter/material.dart';
import 'package:imogoat/components/textInput.dart';
import 'package:imogoat/components/passwordInput.dart';
import 'package:imogoat/components/rememberMeRow.dart';
import 'package:imogoat/components/signUpPrompt.dart';
import 'package:imogoat/components/submitButton.dart';

class LoginPage extends StatefulWidget { 
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _senha = TextEditingController();
  
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
                    PasswordInput(controller: _senha, labelText: 'Senha', hintText: 'Digite sua senha'),
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
                      child: SubmitButton(
                        rota: '/home',
                        texto: 'ENTRAR',
                      )
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