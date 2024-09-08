import 'package:flutter/material.dart';

class RememberMeRow extends StatefulWidget {
  final VoidCallback onForgotPasswordTap;

  const RememberMeRow({
    Key? key,
    required this.onForgotPasswordTap,
  }) : super(key: key);

  @override
  _RememberMeRowState createState() => _RememberMeRowState();
}

class _RememberMeRowState extends State<RememberMeRow> {
  bool isRemembered = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isRemembered = !isRemembered;
            });
          },
          child: Row(
            children: [
              Icon(
                isRemembered ? Icons.check_box : Icons.check_box_outline_blank,
                color: isRemembered ? Colors.blue : Colors.grey,
              ),
              const SizedBox(width: 8), // Espaço entre o ícone e o texto
              const Text(
                'Lembrar-me',
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: widget.onForgotPasswordTap,
          child: const Text(
            'Esqueci a senha',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.red, // Cor do texto clicável
            ),
          ),
        ),
      ],
    );
  }
}
