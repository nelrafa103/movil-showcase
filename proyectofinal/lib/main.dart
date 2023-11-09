import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectofinal/router.dart';
import 'package:proyectofinal/sqflite.dart';
import 'package:proyectofinal/states/cubit/listeners/app_cubit.dart';
import 'package:proyectofinal/states/cubit/listeners/moves_cubit.dart';
import 'package:proyectofinal/states/cubit/listeners/pokemon_cubit.dart';
import 'package:proyectofinal/states/cubit/listeners/pokemons_cubit.dart';
import 'package:proyectofinal/ui/ios/screens/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  runApp(const MyApp());
  //Inicializando base de datos
  DbInitializer.initialize();
  // await dotenv.load(fileName: ".env");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      if (Platform.isIOS || Platform.isMacOS) {
        return CupertinoApp(
          debugShowCheckedModeBanner: false,
          routes: {"/": (_) => MyHomePage("", title: "")},
        );
      }
    }

    //Implementación de la lógica de negocios
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ListCubit()..fetch(),
          ),
          BlocProvider(
            create: (context) => PokemonCubit(),
          ),
          BlocProvider(
            create: (context) => MovesCubit(),
          ),
          BlocProvider(
            create: (context) => AppCubit()..changeTab(0),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        ));
  }
}
