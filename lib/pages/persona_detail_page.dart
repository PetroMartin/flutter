import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/components/calendar_input.dart';
import 'package:flutter_application_1/models/persona_json.dart';
import 'package:flutter_application_1/models/user_json.dart';

class PersonaDetailPage extends StatefulWidget {
  final int? personaId;

  const PersonaDetailPage({super.key, required this.personaId});

  @override
  State<PersonaDetailPage> createState() => _PersonaDetailPageState();
}

class _PersonaDetailPageState extends State<PersonaDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  DateTime initialDate = DateTime.now();

  void changeDate(DateTime newDate) {
    setState(() {
      initialDate = newDate; // Cambia el valor de initialDate
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.personaId != null) {
      fetchPersonaById(widget.personaId as int);
    }
  }

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
              labelText: 'Nombres',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese los nombres';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Apellidos',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese los apellidos';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Ciudad',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la ciudad';
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
        if (!_formKey.currentState!.validate()) {
          return;
        }
      },
      child: const Text("Guardar"),
    );
  }

  void savePersona() {
    if (widget.personaId == null) {
      createPersona(UserJson(
          username: _usernameController.text,
          password: _passwordController.text));
    } else {
      updatePersona(UserJson(
          id: widget.personaId,
          username: _usernameController.text,
          password: _passwordController.text));
    }
  }

  void fetchPersonaById(int personaId) async {
    print('fetchPersonaById');
    var persona = await fetchPersonaFromAPI(personaId);

    _usernameController.text = persona.username;
    _passwordController.text = persona.password;
  }

  Future<UserJson> fetchPersonaFromAPI(int personaId) {
    print('fetchPersonaFromAPI');
    return http
        .get(Uri.parse('https://fakestoreapi.com/users/$personaId'))
        .then((response) {
      return userJsonFromJson(response.body);
    });
  }

  void createPersona(UserJson persona) {
    http
        .post(Uri.parse('https://fakestoreapi.com/users'),
            body: userJsonToJson(persona))
        .then((response) {
      Navigator.pop(context);
    });
  }

  void updatePersona(UserJson persona) {
    http
        .post(Uri.parse('https://fakestoreapi.com/users/${widget.personaId}'),
            body: userJsonToJson(persona))
        .then((response) {
      Navigator.pop(context);
    });
  }
}
