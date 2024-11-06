import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:imogoat/components/appBarCliente.dart';
import 'package:imogoat/models/immobile.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImmobileDetailPage extends StatefulWidget {
  final Immobile immobile;

  const ImmobileDetailPage({Key? key, required this.immobile}) : super(key: key);

  @override
  _ImmobileDetailPageState createState() => _ImmobileDetailPageState();
}

class _ImmobileDetailPageState extends State<ImmobileDetailPage> {
  String role = '';

  @override
  void initState() {
    super.initState();
    getRole();
  }

  Future<void> getRole() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? storedRole = sharedPreferences.getString('role');
    print('O tipo de usuário é: $storedRole');
    setState(() {
      role = storedRole ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCliente(),
      floatingActionButton: role == 'owner' 
          ? FloatingActionButton(
              backgroundColor: Color(0xFFFFC107),
              foregroundColor: Colors.white,
              child: const Icon(Icons.edit),
              onPressed: () {},
            )
          : null,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.immobile.images.isNotEmpty
                  ? CarouselSlider(
                      options: CarouselOptions(
                        height: 250,
                        viewportFraction: 1.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                      ),
                      items: widget.immobile.images.map((image) {
                        return Builder(
                          builder: (BuildContext context) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                image.url,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                errorBuilder: (context, error, stackTrace) => const Icon(
                                  Icons.broken_image,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    )
                  : const Text('Imagem indisponível'),
              const SizedBox(height: 16),
              SizedBox(
                width: 400,
                child: Divider(),
              ),
              const SizedBox(height: 8),
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.immobile.name},',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'N° ${widget.immobile.number}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'R\$ ${widget.immobile.value.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F7C70),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Detalhes da propriedade:',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.house,
                    size: 26,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.immobile.type,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.bed,
                    size: 26,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${widget.immobile.numberOfBedrooms} quartos',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.bathtub,
                    size: 26,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${widget.immobile.numberOfBathrooms} banheiros',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.garage,
                    size: 26,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.immobile.garagem == true ? "Com garagem" : "Sem garagem",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Localização:',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 26,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${widget.immobile.location}, ${widget.immobile.bairro}, ${widget.immobile.city}, ${widget.immobile.reference}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Descrição:',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.immobile.description,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
