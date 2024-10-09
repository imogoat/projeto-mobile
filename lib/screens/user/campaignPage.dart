import 'package:flutter/material.dart';

class CampaignPage extends StatefulWidget {
  const CampaignPage({super.key});

  @override
  State<CampaignPage> createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF0F2F5),
        title: Text(
          'Anúncio',
          style: TextStyle(color: Color(0xFF2E3C4E)),
        ),
      ),
      backgroundColor: Color(0xFFF0F2F5),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(height: 5),
                ClipRRect(
                  child: Image.asset(
                    width: 250,
                    height: 170,
                    "assets/images/image-anuncio-transparente.png",
                    fit: BoxFit.fill
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Anuncie seu imóvel no ImoGOAT e alcance inquilinos que valorizam seu espaço. A inscrição é simples, rápida e gratuita, e nós conectamos você a quem está procurando o lar ideal. Deixe que o ImoGOAT faça seu imóvel se destacar!',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Color(0xFF2E3C4E),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'O que você gostaria de anunciar hoje?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF1F7C70),
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Primeiro botão - Anunciar Imóvel
                    SizedBox(
                      width: 166,
                      height: 166,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // Cor de fundo do botão
                          side: BorderSide(
                            color: Color(0xFF1F7C70), // Cor da borda
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home,
                              size: 40,
                              color: Colors.black,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Imóvel',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Se você é proprietário',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    SizedBox(
                      width: 166,
                      height: 166,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(
                            color: Color(0xFF1F7C70),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.apartment,
                              size: 40,
                              color: Colors.black,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Vaga',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Se deseja dividir contas',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
