import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/calculator_page.dart';
import 'package:flutter_application_1/pages/camionesdetail_page.dart';
import 'package:flutter_application_1/pages/card_page.dart';
import 'package:flutter_application_1/pages/form_page.dart';
import 'package:flutter_application_1/pages/formvalidado_page.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/image_page.dart';
import 'package:flutter_application_1/pages/lista_page.dart';
import 'package:flutter_application_1/pages/listacamiones_page.dart';
import 'package:flutter_application_1/pages/listaposts_page.dart';
import 'package:flutter_application_1/pages/listbuilder_page.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:flutter_application_1/pages/persona_detail_page.dart';
import 'package:flutter_application_1/pages/persona_list_page.dart';
import 'package:flutter_application_1/pages/postdetail_page.dart';
import 'package:flutter_application_1/pages/productolist_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        var arguments = settings.arguments;
        var routes = <String, WidgetBuilder>{
          //'/': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
          //'/': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
          '/': (context) => const LoginPage(),
          //'/': (context) => const ListaCamionesPage(),
          '/home': (context) =>
              const MyHomePage(title: 'Flutter Demo Home Page'),
          '/camioneslist': (context) => const ListaCamionesPage(),
          '/camionesdetail': (context) {
            if (arguments is String) {
              return CamionesDetailPage(camionesId: arguments);
            } else {
              return const CamionesDetailPage(camionesId: null);
            }
          },

          //=> const CamionesDetailPage(camionesId: '',),

          '/image': (context) => const ImagePage(),
          '/calculator': (context) => const CalculatorPage(),
          '/lista': (context) => const ListaPage(),
          '/listabuilder': (context) => const ListBuilderPage(),
          '/card': (context) => const CardPage(),
          '/form': (context) => const FormPage(),
          '/formvalidado': (context) => const FormValidadoPage(),
          '/postlist': (context) => const ListaPostsPage(),
          '/postdetail': (context) => const PostDetailPage(),
          '/personas': (context) => const PersonaListPage(),
          '/userdetail': (context) {
            if (arguments is int) {
              return PersonaDetailPage(personaId: arguments);
            } else {
              return const PersonaDetailPage(personaId: null);
            }
          },
          '/productos': (context) => const ProductoListPage(),
          '/login': (context) => const LoginPage(),
        };
        WidgetBuilder? builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder!(ctx));
      },
    );
  }
}
