import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:proyectofinal/models/pokemon.dart';
import 'package:proyectofinal/states/cubit/listeners/pokemons_cubit.dart';
import 'package:proyectofinal/ui/android/screens/detail_screen.dart';
import 'package:proyectofinal/ui/android/screens/home_screen.dart';
import 'package:proyectofinal/ui/android/screens/login_screen.dart';
import 'package:proyectofinal/ui/android/screens/moves_screen.dart';
import 'package:proyectofinal/ui/android/screens/search_screen.dart';
import 'package:proyectofinal/ui/android/screens/settings_screen.dart';

//GoRouter programado para navegación entre pantallas
//Se pusieron cada una de las rutuas bases para entrar a las pantallas de c/u
GoRouter router = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: "/",
      routes: <RouteBase>[
        GoRoute(
          path: "configuracion",
          builder: (context, state) => settings_screen(),
        ),
        GoRoute(
          path: "habilidades",
          builder: (context, state) => moves_screen(),
        ),
        GoRoute(
          path: "detalle",
          builder: (context, state) => PokemonDetail(
              //  pokemon: state.extra as Pokemon,
              ),
        ),
        GoRoute(
          path: "busqueda",
          builder: (context, state) => seach_screen(),
        )
      ],
      builder: (context, state) => const MyHomePage(
            "Por aqui",
            title: '',
          )),
]);
