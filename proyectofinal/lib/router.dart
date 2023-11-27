import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:proyectofinal/states/cubit/abilities_cubit.dart';
import 'package:proyectofinal/ui/android/screens/pokemon_detail_screen.dart';
import 'package:proyectofinal/ui/android/screens/home_screen.dart';
import 'package:proyectofinal/ui/android/screens/abilities_screen.dart';
import 'package:proyectofinal/ui/android/screens/search_screen.dart';
import 'package:proyectofinal/ui/android/screens/settings_screen.dart';

GoRouter router = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: "/",
      routes: <RouteBase>[
        GoRoute(
          path: "configuracion",
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: "habilidades",
          builder: (context, state) => BlocProvider(
              create: (BuildContext context) => AbilitiesCubit()..fetch(),
              child: const AbilitiesScreen()),
        ),
        GoRoute(
          path: "detalle",
          builder: (context, state) => const PokemonDetailScreen(),
        ),
        GoRoute(
          path: "busqueda",
          builder: (context, state) => const SearchScreen(),
        )
      ],
      builder: (context, state) => const MyHomePage(
            "Por aqui",
            title: '',
          )),
]);
