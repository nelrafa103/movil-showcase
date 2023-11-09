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
    // TODO: implement initState
    super.initState();
    controller = ScrollController();

    controller.addListener(() async {
      if (controller.hasClients) {
        if (controller.position.maxScrollExtent == controller.offset) {
          print("Llego al final");
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
                      url: state.pokemons[index].sprites.other!.officialArtwork.frontDefault));
                  return list_item(
                      pokemon: state.pokemons[index],
                      types: state.pokemons[index].types,
                      name: state.pokemons[index].name,
                      paddingPerSize: paddingPerSize,
                      pokemonSize: pokemonSize,
                      url: state.pokemons[index].sprites.other!.officialArtwork.frontDefault);
                } else {
                  return Shimmer.fromColors(
                      baseColor: Colors.black54,
                      highlightColor: Colors.white70,
                      child: SingleChildScrollView(
                          padding: EdgeInsets.all(paddingPerSize),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () => {},
                                      icon: const Icon(
                                        Icons.favorite_border,
                                        size: 20,
                                        color: Colors.white,
                                      )),
                                  Text('#',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                      )),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //Foto del pokemon:
                                  Container(
                                    // color: Colors.grey,
                                    width: pokemonSize,
                                    height: pokemonSize,
                                    child: Center(
                                        child: Transform.scale(
                                            scale: 1.0,
                                            child: CachedNetworkImage(
                                              imageUrl: "",
                                              fit: BoxFit.fill,
                                              progressIndicatorBuilder: (context,
                                                      url, downloadProgress) =>
                                                  CircularProgressIndicator(
                                                      value: downloadProgress
                                                          .progress),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ))),
                                  ),

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      FilledButton(
                                        onPressed: null,
                                        style: FilledButton.styleFrom(
                                          padding: const EdgeInsets.all(12.0),
                                        ),
                                        child: Text(
                                          "",
                                          style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "",
                                        style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )));
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
                    url: state.pokemons[index].sprites.other!.officialArtwork.frontDefault));
                return list_item(
                    pokemon: state.pokemons[index],
                    types: state.pokemons[index].types,
                    name: state.pokemons[index].name,
                    paddingPerSize: paddingPerSize,
                    pokemonSize: pokemonSize,
                    url: state.pokemons[index].sprites.other!.officialArtwork.frontDefault);
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
