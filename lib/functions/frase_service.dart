import 'dart:convert';
import 'package:flutter/services.dart';

Future<Map<String, List<String>>> cargarFrases() async {
  try {
    final String response = await rootBundle.loadString('assets/frases.json');
    final data = json.decode(response) as Map<String, dynamic>;

    // Convertimos dinámico a Map<String, List<String>>
    return data.map((key, value) => MapEntry(key, List<String>.from(value)));
  } catch (e) {
    print('Error al cargar frases: $e');
    return {}; // Retorna un mapa vacío en caso de error
  }
}
