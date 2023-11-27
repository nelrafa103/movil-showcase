import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:proyectofinal/shared/pokemon.dart';
import 'package:proyectofinal/states/cubit/app_cubit.dart';
import 'package:proyectofinal/states/cubit/pokemons_cubit.dart';
import 'package:proyectofinal/states/pokemons_state.dart';
import 'package:proyectofinal/ui/android/widgets/bottom_bar_widget.dart';
import 'package:proyectofinal/ui/android/widgets/filter_widget.dart';
import 'package:proyectofinal/ui/android/widgets/pokemon_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchScreen();
  }
}

class _SearchScreen extends State<SearchScreen> {
  bool filtro = false;

  void redirect(String param) {
    GoRouter.of(context).go("/");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buscar"),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchBar());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body:
          BlocBuilder<PokemonsCubit, PokemonsState>(builder: ((context, state) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            childAspectRatio: 1.6,
          ),
          itemCount: 16,
          itemBuilder: (BuildContext context, int index) {
            double screenHeight = MediaQuery.of(context).size.height;
            double paddingPerSize = screenHeight > 600 ? 4.0 : 8.0;
            double pokemonSize = screenHeight > 600 ? 50 : 70;

            return GestureDetector(
                onTap: () async => {
                      await BlocProvider.of<PokemonsCubit>(context)
                          .filterByType(paramList[index].id)
                          .then((value) => showSearch(
                              context: context, delegate: CustomSearchBar())),
                    },
                child: FilterWidget(
                    param: paramList[index],
                    color: paramList[index].color,
                    paddingPerSize: paddingPerSize,
                    pokemonSize: pokemonSize));
          },
        );
      })),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

class CustomSearchBar extends SearchDelegate {
  ScrollController controller = ScrollController();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          context.read<PokemonsCubit>().fetch();
          GoRouter.of(context).go("/");
          context.read<AppCubit>().changeTab(0);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Column(
      children: [],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    BlocProvider.of<PokemonsCubit>(context).filterByName(query);
    return BlocConsumer<PokemonsCubit, PokemonsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is PopulatedPokemons) {
            return GridView.builder(
                controller: controller,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  childAspectRatio: 1.6,
                ),
                itemCount: state.pokemons.length,
                itemBuilder: (BuildContext context, int index) {
                  double screenHeight = MediaQuery.of(context).size.height;
                  double paddingPerSize = screenHeight > 600 ? 4.0 : 8.0;
                  double pokemonSize = screenHeight > 600 ? 50 : 70;

                  return PokemonWidget(
                    pokemon: state.pokemons[index],
                    paddingPerSize: paddingPerSize,
                    pokemonSize: pokemonSize,
                  );
                });
          } else if (state is PokemonsError) {
            return Text(state.message);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
