// import 'package:flutter/material.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// class CustomCurvedNavigationBar extends StatefulWidget {
//   final int currentIndex; // Índice atual da página
//   final Function(int) onTap; // Função de callback ao clicar nos ícones

//   const CustomCurvedNavigationBar({
//     Key? key,
//     required this.currentIndex,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   _CustomCurvedNavigationBarState createState() => _CustomCurvedNavigationBarState();
// }

// class _CustomCurvedNavigationBarState extends State<CustomCurvedNavigationBar> {
//   GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return CurvedNavigationBar(
//       key: _bottomNavigationKey,
//       index: widget.currentIndex,
//       items: const <Widget>[
//         Icon(Icons.home, size: 30),
//         Icon(Icons.favorite, size: 30),
//         Icon(Icons.contacts, size: 30),
//         Icon(Icons.campaign, size: 30),
//       ],
//       onTap: widget.onTap, // Chama a função onTap passada como argumento
//     );
//   }

//   void setPage(int index) {
//     final CurvedNavigationBarState? navBarState = _bottomNavigationKey.currentState;
//     navBarState?.setPage(index); // Muda a página programaticamente
//   }
// }
