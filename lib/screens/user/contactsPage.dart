import 'package:flutter/material.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contato',
          style: TextStyle(color: Color(0xFF2E3C4E)),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(  // Adicione o Padding aqui
            padding: const EdgeInsets.symmetric(horizontal: 20.0), // Ajuste o valor conforme necessário
            child: Column(
              children: [
                SizedBox(height: 20),
                Positioned.fill(
                  child: ClipRRect(
                    child: Image.asset(
                      width: 350,
                      "assets/images/logo-teste.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'versão 1.0.0',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  'O nosso aplicativo de aluguel de imóveis é uma plataforma completa e eficiente para facilitar o processo de busca e locação de imóveis para inquilinos. Nosso site torna o processo de aluguel mais fácil e eficiente para os inquilinos, proporcionando uma experiência fluida e direta.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: Divider(),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'imogoat23@gmail.com',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 60),
                SizedBox(
                  width: 365,
                  child: ElevatedButton(
                    onPressed: () {},
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
                            return Color.fromARGB(255, 46, 60, 78);
                          }
                          return null;
                        },
                      ),
                      elevation: MaterialStateProperty.all(0),
                      minimumSize: MaterialStateProperty.all(const Size(200, 50)),
                    ),
                    child: Text(
                      'Entrar em contato',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color.fromARGB(255, 24, 157, 130),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
