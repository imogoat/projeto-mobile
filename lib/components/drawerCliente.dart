import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerCliente extends StatelessWidget {

  Future<void> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF1F7C70),
            ),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: 'IMOGOAT',
                  style: TextStyle(
                    fontSize: 24,
                    // color: Colors.red,
                    // decoration: TextDecoration.underline, 
                  ),
                ),
            ),
          )
        ),
        ListTile(
          title: Text(
            'Home'.toUpperCase(),
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F7C70)
            ),
          ),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pushNamed(context, '');
          },
        ),
        ListTile(
          title: Text('Favoritos'.toUpperCase(),
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F7C70)
            ),
          ),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pushNamed(context, '');
          },
        ),
       ListTile(
          title: Text('Contato'.toUpperCase(),
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F7C70)
            ),
          ),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pushNamed(context, '');
          },
        ),
        ListTile(
          title: Text('Anuncie aqui'.toUpperCase(),
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F7C70)
            ),
          ),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pushNamed(context, '');
          },
        ),
        const SizedBox(height: 15),
        IconButton(
            onPressed: () => {
              logout(),
              Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false)
              },
            icon: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  Icon(Icons.logout, size: 35),
                  SizedBox(width: 5), 
                  Text('Logout', 
                    style: TextStyle(
                      fontSize: 25,
                      // fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'
                    )), 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}