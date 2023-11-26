import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectofinal/models/hive/pokemon_dao.dart';
import 'package:proyectofinal/hive.dart';
import 'package:proyectofinal/states/cubit/pokemons_cubit.dart';
import 'package:proyectofinal/states/pokemons_state.dart';
import 'package:proyectofinal/ui/android/widgets/bottom_bar_widget.dart';
import 'package:proyectofinal/ui/android/widgets/pokemon_widget.dart';
import 'package:proyectofinal/ui/android/widgets/shimmers/pokemon_item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage(String s, {super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();

    controller.addListener(() async {
      if (controller.hasClients) {
        if (controller.position.maxScrollExtent == controller.offset) {
          BlocProvider.of<PokemonsCubit>(context).addMore();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PokemonsCubit, PokemonsState>(
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
                    if (state.pokemons.length > index) {
                      DbInitializer.insert(PokemonDao(
                          name: state.pokemons[index].name,
                          id: state.pokemons[index].id,
                          url: state.pokemons[index].sprites.frontDefault));
                      return PokemonWidget(
                          pokemon: state.pokemons[index],
                          types: state.pokemons[index].types,
                          name: state.pokemons[index].name,
                          paddingPerSize: paddingPerSize,
                          pokemonSize: pokemonSize,
                          url: state.pokemons[index].sprites.frontDefault);
                    } else {
                      return const PokemonShimmerWidget();
                    }
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
