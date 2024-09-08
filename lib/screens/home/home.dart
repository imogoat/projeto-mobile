import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:imogoat/components/appBarCliente.dart';
import 'package:imogoat/components/buttonHomeCliente.dart';
import 'package:imogoat/components/buttonHomeSearch.dart';
import 'package:imogoat/components/drawerCliente.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCliente(),
      drawer: DrawerCliente(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                child: Image.asset(
                  "assets/images/header.jpeg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.black54,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Encontre facilmente onde ficar!',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Container(
                      width: 350,
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:  BorderRadius.circular(8)
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SubmitButtonHome(texto: 'Apartamento', onPressed: () {},),
                              SizedBox(width: 3.5,),
                              SubmitButtonHome(texto: 'Casa', onPressed: () {},),
                              SizedBox(width: 3.5,),
                              SubmitButtonHome(texto: 'Quitinete', onPressed: () {},),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: TextFormField(
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.search),
                                      labelText: 'Bairro de interesse',
                                      labelStyle: TextStyle(
                                        color: Colors.black
                                      ),
                                      contentPadding: EdgeInsets.zero,
                                      filled: true,
                                      fillColor: Color(0xFFD4D4D4),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              CustomButtonSearch(
                                text: 'Pesquisar',
                                onPressed: () {},
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],

              ),
            ),
          ],
        ),
        Stack(
          children: [
            Expanded(
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 1,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[100],
                    child: const Text("He'd have you all unravel at the"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[200],
                    child: const Text('Heed not the rabble'),
                  ),
                ],
              ),
            )
          ],
        )
          ],
        ),
      ),
    );
  }
}
