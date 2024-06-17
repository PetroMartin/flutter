// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Importar el paquete url_launcher

import '../sample_feature/sample_item.dart';
import '../settings/settings_view.dart';

/// Displays a list of SampleItems.
class LoginView extends StatelessWidget {
  const LoginView({
    Key? key,
    this.items = const [SampleItem(1), SampleItem(2), SampleItem(3)],
  }) : super(key: key);

  static const routeName = '/';

  final List<SampleItem> items;
  static ValueNotifier<bool> _obscureTextNotifier = ValueNotifier<bool>(true);

  void _toggleObscureText() {
    _obscureTextNotifier.value = !_obscureTextNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesion'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      /*body: Center(
        child: InkWell( // Envolver la imagen con InkWell para detectar toques
          onTap: () async { // Función a ejecutar cuando se toca la imagen
            final url = Uri.parse('https://www.facebook.com/easypay.bo'); // URL a abrir
            if (await canLaunchUrl(url)) { // Verificar si se puede abrir la URL
              await launchUrl(url); // Abrir la URL
            } else {
              throw 'No se pudo abrir $url'; // Lanzar una excepción si no se puede abrir la URL
            }
          },
          child: Image.asset('assets/images/easy_pay.png'), // La imagen
        ),
      ),*/
      body: Container(
        color: Colors.yellow, // Color de fondo amarillo
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: InkWell(
                onTap: () async {
                  final url = Uri.parse('https://www.facebook.com/easypay.bo');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw 'No se pudo abrir $url';
                  }
                },
                child: Image.asset('assets/images/easy_pay.png'),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 4.0), // Padding específico para el TextField

                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Usuario',
                    labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    hintText: 'Escriba su usuario',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.text_fields, color: Colors.blue),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    //contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  ),
                ),
              ),
            ),
            Center(
              child: ValueListenableBuilder(
                valueListenable: _obscureTextNotifier,
                builder: (context, obscureText, child) {
                  return TextField(
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: 'Ingrese su contraseña',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.lock, color: Colors.blue),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                          color: Colors.blue,
                        ),
                        onPressed: _toggleObscureText,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      //contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    ),
                  );
                },
              ),
            ),

            // Por ejemplo, un botón
            Center(
              child: ElevatedButton(
                onPressed: () {
                  print('Login presionado');
                },
                child: Text('Login'),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  // Acción del botón
                  print('olvido presionado');
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20.0), // Padding del botón
                  textStyle: TextStyle(fontSize: 18.0), // Estilo del texto
                ),
                child: Text('¿Olvido su contraseña?'),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  print('crea cuenta presionado');
                },
                child: Text('Crear cuenta'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
