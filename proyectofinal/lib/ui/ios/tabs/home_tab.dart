import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectofinal/hive.dart';
import 'package:proyectofinal/models/hive/pokemon_dao.dart';
import 'package:proyectofinal/states/cubit/pokemons_cubit.dart';
import 'package:proyectofinal/states/pokemons_state.dart';
import 'package:proyectofinal/ui/android/widgets/pokemon_widget.dart';
import 'package:proyectofinal/ui/android/widgets/shimmers/pokemon_item.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeTab();
  }
}

class _HomeTab extends State<HomeTab> {
  late ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();

    controller.addListener(() async {
      if (controller.hasClients) {
        if (controller.position.maxScrollExtent == controller.offset) {
          BlocProvider.of<PokemonsCubit>(context).addMore();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PokemonsCubit, PokemonsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is PopulatedPokemons) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: GridView.builder(
                    controller: controller,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      childAspectRatio: 2,
                    ),
                    itemCount: state.pokemons.length,
                    itemBuilder: (BuildContext context, int index) {
                      double screenHeight = MediaQuery.of(context).size.height;
                      double paddingPerSize = screenHeight > 700 ? 4.0 : 8.0;
                      double pokemonSize = screenHeight > 700 ? 50 : 70;
                      if (state.pokemons.length > index) {
                        DbInitializer.insert(PokemonDao(
                            name: state.pokemons[index].name,
                            id: state.pokemons[index].id,
                            url: state.pokemons[index].sprites.frontDefault));
                        return PokemonWidget(
                          pokemon: state.pokemons[index],
                          paddingPerSize: paddingPerSize,
                          pokemonSize: pokemonSize,
                        );
                      } else {
                        return const PokemonShimmerWidget();
                      }
                    }));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
