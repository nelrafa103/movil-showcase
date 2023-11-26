import 'package:go_router/go_router.dart';
import 'package:proyectofinal/ui/android/screens/pokemon_detail_screen.dart';
import 'package:proyectofinal/ui/android/screens/home_screen.dart';
import 'package:proyectofinal/ui/android/screens/moves_screen.dart';
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
          builder: (context, state) => const MoveScreen(),
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
