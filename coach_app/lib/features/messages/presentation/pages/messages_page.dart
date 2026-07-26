/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: messages_page.dart
|--------------------------------------------------------------------------
| Pantalla principal de mensajes.
| El contenido funcional se implementará en los siguientes CK.
|--------------------------------------------------------------------------
*/

import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Mensajes',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
