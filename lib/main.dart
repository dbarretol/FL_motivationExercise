import 'package:flutter/material.dart';
import 'package:myapp/pages/frase_home_page.dart'; // Asegúrate de que la ruta sea correcta

void main() {
  runApp(const FraseApp());
}

class FraseApp extends StatelessWidget {
  const FraseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frase Aleatoria',
      theme: ThemeData(primarySwatch: Colors.blue), // Puedes personalizar el tema
      home: const FraseHomePage(), // La página principal será FraseHomePage
    );
  }
}