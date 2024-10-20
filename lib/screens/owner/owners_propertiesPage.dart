import 'package:flutter/material.dart';

class OwnersPropertiesPage extends StatefulWidget {
  const OwnersPropertiesPage({super.key});

  @override
  State<OwnersPropertiesPage> createState() => _OwnersPropertiesPageState();
}

class _OwnersPropertiesPageState extends State<OwnersPropertiesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Imóveis do proprietário')),
    );
  }
}