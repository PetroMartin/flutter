import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/camiones_json.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CamionesDetailPage extends StatefulWidget {
  final String? camionesId;

  const CamionesDetailPage({super.key, required this.camionesId});

  @override
  State<CamionesDetailPage> createState() => _CamionesDetailPageState();
}

class _CamionesDetailPageState extends State<CamionesDetailPage> {
  final String apiUrl = dotenv.env['API_URL']!;
  final _formKey = GlobalKey<FormState>();
  final _patenteController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _idcamionController = TextEditingController();
  DateTime initialDate = DateTime.now();

  void changeDate(DateTime newDate) {
    setState(() {
      initialDate = newDate; // Cambia el valor de initialDate
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.camionesId != null) {
      fetchPersonaById(widget.camionesId as String);
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
            controller: _idcamionController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'idcamion',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el id';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _patenteController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'patente',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la patente';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _descripcionController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'descripcion',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la descripcion';
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
        } else {
          savePersona();
        }
      },
      child: const Text("Guardar"),
    );
  }

  void savePersona() {
    print("salvar auto");
    if (widget.camionesId == null) {
      createPersona(CamionesJson(
          idcamion: _idcamionController.text,
          patente: _patenteController.text,
          descripcion: _descripcionController.text));
    } else {
      updatePersona(CamionesJson(
          idcamion: _idcamionController.text,
          patente: _patenteController.text,
          descripcion: _descripcionController.text));
    }
  }

  void fetchPersonaById(String camionesId) async {
    print('fetchPersonaById');
    var persona = await fetchPersonaFromAPI(camionesId);
    _idcamionController.text = persona.idcamion;
    _patenteController.text = persona.patente;
    _descripcionController.text = persona.descripcion;
  }

  Future<CamionesJson> fetchPersonaFromAPI(String camionesId) {
    print('fetchPersonaFromAPI');

    return http.get(Uri.parse('$apiUrl/camiones/$camionesId')).then((response) {
      return camionesJsonFromJson(response.body);
    });
  }

  void createPersona(CamionesJson persona) {
    print(camionesJsonToJson(persona));
    http
        .post(Uri.parse('$apiUrl/camiones'),
            headers: {"Content-Type": "application/json"},
            body: camionesJsonToJson(persona))
        .then((response) {
      Navigator.pushReplacementNamed(context, '/camioneslist');
    });
  }

  void updatePersona(CamionesJson persona) {
    print('$apiUrl/camiones/${widget.camionesId}');
    http
        .put(Uri.parse('$apiUrl/camiones/${widget.camionesId}'),
            headers: {"Content-Type": "application/json"},
            body: camionesJsonToJson(persona))
        .then((response) {
      print('fin');
      Navigator.pushReplacementNamed(context, '/camioneslist');
    });
  }
}
