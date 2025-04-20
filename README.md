# myapp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# punto de entrada
```dart
//main.dart
class FraseApp extends StatelessWidget {
  const FraseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frase Aleatoria',
      theme: ThemeData(primarySwatch: Colors.blue), // Puedes personalizar el tema
      home: const FraseHomePage(), // La página principal será FraseHomePage
      //------------------>    VA A "frase_home_page.dart"
    );
  }
}
```

# FraseHomePage

## Constructor : Clase `FraseHomePage`
```dart
class FraseHomePage extends StatefulWidget {
  const FraseHomePage({Key? key}) : super(key: key);

  @override
  State<FraseHomePage> createState() => _FraseHomePageState();
}
```
- `FraseHomePage` es un `StatefulWidget`, lo que significa que tiene un estado mutable (es decir, su contenido puede cambiar en función de la interacción del usuario).
- El método `createState()` retorna una instancia de la clase `_FraseHomePageState` (que maneja el estado real del widget).

## Constructor : Clase `_FraseHomePageState`
```dart
class _FraseHomePageState extends State<FraseHomePage> {
  Map<String, List<String>> frasesPorCategoria = {};  // Mapa de frases por categoría
  String fraseActual = '';  // Frase que se mostrará en pantalla
  String categoriaActual = '';  // Categoría de la frase actual

```
- `frasesPorCategoria` es un mapa que asocia categorías con una lista de frases.
- `fraseActual` y `categoriaActual` son variables que almacenan la frase y la categoría actualmente mostradas.

## Constructor : Método `initState()`
```dart
@override
void initState() {
  super.initState();
  cargarFrases().then((resultado) {
    setState(() {
      frasesPorCategoria = resultado;
    });
  });
}
```
- El método `initState()` se ejecuta cuando el widget es creado, antes de que se construya la interfaz de usuario.
- Aquí, se llama a `cargarFrases()`, que es una función asincrónica que, probablemente, obtiene las frases desde alguna fuente externa (como un archivo o base de datos). Una vez que las frases se cargan, se actualiza el estado con `setState()`.

## Constructor : Método `mostrarFraseAleatoria()`
```dart
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
```
- `mostrarFraseAleatoria()` selecciona una frase aleatoria de las frases cargadas.
    - Primero, genera un número aleatorio con `Random()`.
    - Luego, selecciona aleatoriamente una categoría de las disponibles en `frasesPorCategoria`.
    - A continuación, elige una frase aleatoria dentro de esa categoría.
    - Finalmente, actualiza el estado con `setState()` para reflejar la frase y categoría seleccionadas en la interfaz de usuario.

## Constructor : Método `build()`
```dart
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
```
- El método `build()` es el encargado de construir la interfaz de usuario.
    - Usa un `Scaffold`, que proporciona una estructura básica de la interfaz (como un AppBar y un body).
    - En el `body`, se tiene un `Column` que alinea varios elementos:
        - Un `Text` que muestra la frase actual. Si no hay una frase, muestra un mensaje predeterminado.
        - Otro `Text` para mostrar la categoría de la frase, pero solo si la categoría no está vacía.
        - Un `ElevatedButton` que, al ser presionado, llama a `mostrarFraseAleatoria()` para cambiar la frase y la categoría.

# cargarFrases

## Importaciones
```dart
import 'dart:convert';  // Para convertir datos JSON a objetos de Dart
import 'package:flutter/services.dart';  // Para acceder a los assets de la app
```
- `dart:convert`: Esta librería proporciona herramientas para trabajar con JSON. En este caso, se usa para decodificar una cadena JSON a una estructura de datos de Dart (como un `Map`).
- `flutter/services.dart`: Permite acceder a los recursos de la aplicación (como archivos estáticos o "assets") a través de `rootBundle`, que se usa para cargar el archivo `frases.json`.

## Función `cargarFrases()`
```dart
Future<Map<String, List<String>>> cargarFrases() async {
```
- `cargarFrases()` es una función asincrónica (`async`) que retorna un `Future`. Esto significa que la función no devolverá el valor inmediatamente, sino que lo hará en algún momento en el futuro cuando se haya completado la operación asincrónica (en este caso, la carga y decodificación del archivo JSON).
- El tipo de retorno es `Future<Map<String, List<String>>>`, lo que indica que esta función devolverá un mapa donde:
    - La clave (`String`) es el nombre de la categoría (por ejemplo, "motivacional").
    - El valor asociado a esa clave es una lista de frases (`List<String>`).

## Lectura del archivo JSON
```dart
final String response = await rootBundle.loadString('assets/frases.json');
```
- `rootBundle.loadString('assets/frases.json')` carga el contenido del archivo `frases.json` que está ubicado en la carpeta de assets del proyecto.
- `loadString` lee el archivo y devuelve una cadena de texto que representa el contenido del archivo JSON.
- `await` espera a que la operación de lectura del archivo se complete antes de continuar con el flujo del código.

## Decodificación del JSON
```dart
final data = json.decode(response) as Map<String, dynamic>;
```
- `json.decode(response)` toma la cadena de texto `response` (que es un JSON) y la convierte en una estructura de datos de Dart. El resultado es un `Map<String, dynamic>`. Esto significa que el JSON debe tener claves de tipo `String`, pero los valores pueden ser de cualquier tipo (en este caso, probablemente sean listas de cadenas, como veremos a continuación).
- `as Map<String, dynamic>` es una forma de hacer una conversión explícita a un `Map<String, dynamic>`, lo que le indica al compilador que esperamos que el JSON sea un mapa con claves de tipo `String`.

## Conversión de datos a un tipo más específico
```dart
return data.map((key, value) => MapEntry(key, List<String>.from(value)));
```
- `data.map((key, value) => MapEntry(key, List<String>.from(value)))`:
    - `map()` es una función que transforma cada elemento del mapa `data`. En este caso, el elemento tiene dos partes: una clave (`key`) y un valor (`value`).
    - `MapEntry(key, List<String>.from(value))`: Para cada par clave-valor en el mapa, estamos creando un nuevo `MapEntry` donde:
        - `key` sigue siendo la misma clave (la categoría de la frase).
        - `List<String>.from(value)` toma el valor (que es dinámico) y lo convierte explícitamente a una lista de cadenas (`List<String>`), usando `List<String>.from()` para garantizar que el valor sea del tipo adecuado (una lista de cadenas).
- El resultado es un mapa con las claves originales (las categorías) y los valores convertidos a listas de cadenas (`List<String>`).

## Manejo de errores
```dart
} catch (e) {
  print('Error al cargar frases: $e');
  return {}; // Retorna un mapa vacío en caso de error
}
```
- El bloque `try-catch` es utilizado para manejar posibles errores que puedan ocurrir al intentar cargar el archivo JSON (por ejemplo, si el archivo no se encuentra o está mal formado).
- Si ocurre un error, el `catch` captura la excepción y muestra un mensaje en la consola con `print('Error al cargar frases: $e')`.
- En caso de error, la función retorna un mapa vacío `{}`, para que el código que llama a esta función no falle y pueda manejar el error de manera apropiada.