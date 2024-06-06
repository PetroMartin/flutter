import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/camiones_json.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ListaCamionesPage extends StatelessWidget {
  const ListaCamionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Camiones'),
      ),
      body: getListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/camionesdetail');
        },
        child: Icon(Icons.add),
        tooltip: 'Agregar nuevo camión',
      ),
    );
  }

  Widget getListView() {
    return FutureBuilder(
      future: fetchListaCamiones(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar los posts'));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        print(snapshot.data);
        final List<CamionesJson> posts =
            camionesListJsonFromJson(snapshot.data!.body);

        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/camionesdetail',
                    arguments: posts[index].idcamion);
              },
              title: Text(posts[index].descripcion),
            );
          },
        );
      },
    );
  }

  Future<http.Response> fetchListaCamiones() {
    final String apiUrl = dotenv.env['API_URL']!;
    return http.get(Uri.parse('$apiUrl/camiones'));
  }
}
