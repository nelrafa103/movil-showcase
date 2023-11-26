import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyectofinal/models/hive/pokemon_dao.dart';
import 'package:proyectofinal/models/pokemon.dart';
import 'package:proyectofinal/sqflite.dart';
import 'package:proyectofinal/states/cubit/listeners/pokemons_cubit.dart';
import 'package:proyectofinal/states/list_state.dart';
import 'package:proyectofinal/ui/android/widgets/bottom_bar.dart';
import 'package:proyectofinal/ui/android/widgets/pokemon_item.dart';
import 'package:proyectofinal/ui/android/widgets/shimmers/pokemon_item.dart';
import 'package:shimmer/shimmer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage(String s, {super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late ScrollController controller;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    controller = ScrollController();

    controller.addListener(() async {
      if (controller.hasClients) {
        if (controller.position.maxScrollExtent == controller.offset) {
          BlocProvider.of<ListCubit>(context).addMore();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ListCubit, ListState>(listener: (context, state) {
        if (state is RepopulatedList) {}
      }, builder: (context, state) {
        if (state is ListLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PopulatedList) {
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
                  return list_item(
                      pokemon: state.pokemons[index],
                      types: state.pokemons[index].types,
                      name: state.pokemons[index].name,
                      paddingPerSize: paddingPerSize,
                      pokemonSize: pokemonSize,
                      url: state.pokemons[index].sprites.frontDefault);
                } else {
                  return pokemon_item_shimmer();
                }
              });
        } else if (state is ListError) {
          return Center(child: Text(state.message));
        } else if (state is RepopulatedList) {
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
                DbInitializer.insert(PokemonDao(
                    name: state.pokemons[index].name,
                    id: state.pokemons[index].id,
                    url: state.pokemons[index].sprites.frontDefault));
                return list_item(
                    pokemon: state.pokemons[index],
                    types: state.pokemons[index].types,
                    name: state.pokemons[index].name,
                    paddingPerSize: paddingPerSize,
                    pokemonSize: pokemonSize,
                    url: state.pokemons[index].sprites.frontDefault);
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
      bottomNavigationBar: bottom_bar(),
    );
  }
}
