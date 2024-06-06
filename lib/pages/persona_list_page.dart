import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/models/user_json.dart';

class PersonaListPage extends StatelessWidget {
  const PersonaListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Personas'),
      ),
      body: getPersonaList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/userdetail');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  getPersonaList() {
    return FutureBuilder(
        future: fetchListaPersonas(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child: Text('Error al cargar la lista de users'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final users = userListJsonFromJson(snapshot.data!.body);
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('el usurio: ${users[index].username} '),
                subtitle: Text(
                    '${users[index].id.toString()} su pasword es ${users[index].password}'),
                onTap: () {
                  Navigator.pushNamed(context, '/userdetail',
                      arguments: users[index].id);
                },
              );
            },
          );
        }));
  }

  Future<http.Response> fetchListaPersonas() {
    return http.get(Uri.parse('https://fakestoreapi.com/users'));
  }
}
