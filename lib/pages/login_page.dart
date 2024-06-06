import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_json.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/models/persona_json.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final String apiUrl = dotenv.env['API_URL']!;
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de la persona'),
      ),
      body: getForm(context),
    );
  }

  getForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _usernameController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Usuario',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el usuario';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Contraseña',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la contraseña';
              }
              return null;
            },
          ),
          getButton()
        ],
      ),
    );
  }

  getButton() {
    return ElevatedButton(
      onPressed: () {
        login(UserJson(
            password: _passwordController.text,
            username: _usernameController.text));
      },
      child: const Text("Guardar"),
    );
  }

  Future<PersonaJson> fetchPersonaFromAPI(int personaId) {
    print('fetchPersonaFromAPI');
    return http
        .get(Uri.parse('http://personas.jmacboy.com/personas/$personaId'))
        .then((response) {
      return personaJsonFromJson(response.body);
    });
  }

  void createPersona(PersonaJson persona) {
    http
        .post(Uri.parse('http://personas.jmacboy.com/personas'),
            body: personaJsonToJson(persona))
        .then((response) {
      Navigator.pop(context);
    });
  }

  void login(UserJson persona) {
    http
        .post(
      Uri.parse('$apiUrl/usuario/login'),
      headers: {"Content-Type": "application/json"},
      body: userJsonToJson(persona),
    )
        .then((response) {
      if (response.statusCode == 201) {
        // var responseBody = personaJsonFromJson(response.body);

        if (response.body.isNotEmpty) {
          // Successful login: navigate to another page
          Navigator.pushReplacementNamed(
              context, '/home'); // Replace with your route
        } else {
          // Failed login: show failure message
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Login Failed"),
                content: Text("Incorrect username or password."),
                actions: <Widget>[
                  TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      } else {
        // Handle other status codes or network errors
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Login Error"),
              content: Text("An error occurred. Please try again later."),
              actions: <Widget>[
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }).catchError((error) {
      // Handle network or parsing errors
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Network Error"),
            content:
                Text("Unable to reach the server. Please try again later."),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }
}
