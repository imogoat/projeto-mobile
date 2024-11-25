import 'package:flutter/material.dart';

class AppBarCliente extends StatelessWidget implements PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    return AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Color(0xFF1F7C70),
        actions: [
          Image(image: AssetImage("assets/images/logo_nova.png"),
          height: 50,
          ),
        ],
      );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}