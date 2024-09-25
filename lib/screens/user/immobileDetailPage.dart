import 'package:flutter/material.dart';
import 'package:imogoat/components/appBarCliente.dart';
import 'package:imogoat/models/immobile.dart';

class ImmobileDetailPage extends StatelessWidget {
  final Immobile immobile;

  const ImmobileDetailPage({Key? key, required this.immobile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCliente(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            immobile.images.isNotEmpty
                ? Image.network(
                    immobile.images.first.url,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : const Text('Imagem indisponível'),
            const SizedBox(height: 16),
            Text(
              immobile.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              immobile.type,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Detalhes:',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Sem descrição disponível'),
            // Você pode adicionar mais detalhes aqui
          ],
        ),
      ),
    );
  }
}
