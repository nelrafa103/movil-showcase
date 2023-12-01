import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectofinal/shared/pokemon.dart';
import 'package:proyectofinal/states/cubit/pokemons_cubit.dart';
import 'package:proyectofinal/states/pokemons_state.dart';
import 'package:proyectofinal/ui/android/widgets/filter_widget.dart';
import 'package:proyectofinal/ui/android/widgets/pokemon_widget.dart';
import 'package:proyectofinal/ui/ios/widgets/search_bar_widget.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SearchTab();
  }
}

class _SearchTab extends State<SearchTab> {
  String text = '';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          leading: SearchBarWidget(),
        ),
        child: BlocBuilder<PokemonsCubit, PokemonsState>(
            builder: ((context, state) {
          if (state is PopulatedPokemons) {
            if (state.isfiltered) {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    childAspectRatio: 2,
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
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          } else {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  childAspectRatio: 1.6,
                ),
                itemCount: 12,
                itemBuilder: (BuildContext context, int index) {
                  double screenHeight = MediaQuery.of(context).size.height;
                  double paddingPerSize = screenHeight > 600 ? 4.0 : 8.0;
                  double pokemonSize = screenHeight > 600 ? 50 : 70;

                  return GestureDetector(
                      onTap: () async => {},
                      child: FilterWidget(
                          param: paramList[index],
                          color: paramList[index].color,
                          paddingPerSize: paddingPerSize,
                          pokemonSize: pokemonSize));
                });
          }
        })));
  }
}
