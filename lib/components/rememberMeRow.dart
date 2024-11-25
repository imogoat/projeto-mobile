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
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
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
