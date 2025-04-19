import 'dart:math';
import 'package:flutter/material.dart';
import 'package:myapp/functions/frase_service.dart';

class FraseHomePage extends StatefulWidget {
  const FraseHomePage({Key? key}) : super(key: key);

  @override
  State<FraseHomePage> createState() => _FraseHomePageState();
}

class _FraseHomePageState extends State<FraseHomePage> {
  Map<String, List<String>> frasesPorCategoria = {};
  String fraseActual = '';
  String categoriaActual = '';

  @override
  void initState() {
    super.initState();
    cargarFrases().then((resultado) {
      setState(() {
        frasesPorCategoria = resultado;
      });
    });
  }

  void mostrarFraseAleatoria() {
    if (frasesPorCategoria.isNotEmpty) {
      final random = Random();
      final categorias = frasesPorCategoria.keys.toList();
      final categoria = categorias[random.nextInt(categorias.length)];
      final frases = frasesPorCategoria[categoria]!;

      final frase = frases[random.nextInt(frases.length)];

      setState(() {
        categoriaActual = categoria;
        fraseActual = frase;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Frase Aleatoria')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              fraseActual.isEmpty
                  ? 'Presiona el botón para ver una frase'
                  : '"$fraseActual"',
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            if (categoriaActual.isNotEmpty)
              Text(
                'Categoría: $categoriaActual',
                style: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: mostrarFraseAleatoria,
              child: const Text('Mostrar frase'),
            ),
          ],
        ),
      ),
    );
  }
}
