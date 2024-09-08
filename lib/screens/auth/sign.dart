import 'package:flutter/material.dart';
import 'package:imogoat/components/passwordInput.dart';
import 'package:imogoat/components/signUpPrompt.dart';
import 'package:imogoat/components/submitButton.dart';
import 'package:imogoat/components/textInput.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final name = TextEditingController();
  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _confirmaSenha = TextEditingController();

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
                  Text('Cadastre-se', 
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
                  Text('Começar é fácil',
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
                    height: 30,
                  ),
                  Form(
                    child: Column(
                      children: [
                        TextInput(controller: name, labelText: 'Nome completo', hintText: 'Nome'),
                        SizedBox(
                          height: 20,
                        ),
                        TextInput(controller: _email, labelText: 'Email', hintText: 'exemplo@gmail.com'),
                        SizedBox(
                          height: 20,
                        ),
                        PasswordInput(controller: _senha, labelText: 'Senha', hintText: 'Digite sua senha'),
                        SizedBox(
                          height: 20,
                        ),
                        PasswordInput(controller: _confirmaSenha, labelText: 'Senha', hintText: 'Confirme sua senha'),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(width: 365,
                          child: SubmitButton(
                            rota: '/home',
                            texto: 'Criar Conta',
                          )
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SignUpPrompt(
                          promptText: 'Já possui uma conta? ',
                          actionText: 'Login',
                          onSignUpTap: () {
                            Navigator.pushNamed(context, '/');  // Rota para a tela de cadastro
                          },
                        )
                      ],
                    )
                  )
                ],
              ),
            ),
          )),
      ),
    );
  }
}