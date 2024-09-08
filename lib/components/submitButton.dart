import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String texto;
  final String rota;

  const SubmitButton({
    Key? key,
    required this.texto,
    required this.rota
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, rota);
      }, 
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        side: MaterialStateProperty.all(
          const BorderSide(
              color:  Color.fromARGB(255, 24, 157, 130),
              width: 1.5, // Aumentar a espessura da borda
            )
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          )
        ),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Color.fromARGB(255, 46,60,78); // Cor ao pressionar
            }
            return null; // Defer to the widget's default.
          }
        ),
        elevation: MaterialStateProperty.all(0),
        minimumSize: MaterialStateProperty.all(const Size(200, 50)),
      ),
      child: Text(
        texto,
        style: TextStyle(
          fontFamily: 'Poppins',
          color: Color.fromARGB(255, 24, 157, 130),
          fontSize: 18,
        ),
      ),
      );
  }
}