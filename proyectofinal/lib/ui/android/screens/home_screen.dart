import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyectofinal/sqflite.dart';
import 'package:proyectofinal/states/cubit/listeners/pokemon_cubit.dart';
import 'package:proyectofinal/states/cubit/listeners/pokemons_cubit.dart';
import 'package:proyectofinal/states/list_state.dart';
import 'package:proyectofinal/ui/android/widgets/bottom_bar.dart';
import 'package:proyectofinal/ui/android/widgets/pokemon_item.dart';

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

    controller.addListener(() {
      if (controller.hasClients) {
        if (controller.position.maxScrollExtent == controller.offset) {
          BlocProvider.of<ListCubit>(context).addMore();
          print("llego al final");
          //    ListCubit()..addMore();
        }
      }
    });
    // var db = await DbInitilizer.initializeDb();

    //final fetch = BlocProvider.of<ListCubit>(context).fetch();
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
              itemCount: 60,
              itemBuilder: (BuildContext context, int index) {
                double screenHeight = MediaQuery.of(context).size.height;
                double paddingPerSize = screenHeight > 600 ? 4.0 : 8.0;
                double pokemonSize = screenHeight > 600 ? 50 : 70;
                if (state.pokemons.length > index) {
                  return list_item(
                      types: state.pokemons[index].types,
                      name: state.pokemons[index].name,
                      paddingPerSize: paddingPerSize,
                      pokemonSize: pokemonSize,
                      url: state.pokemons[index].sprites.frontDefault);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              });
        } else if (state is ListError) {
          print(state.message);
          return Center(child: Text(state.message));
        } else if (state is RepopulatedList) {
          print(state.pokemons.length);
          return GridView.builder(
              controller: controller,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                childAspectRatio: 1.6,
              ),
              // itemCount: 60,
              itemBuilder: (BuildContext context, int index) {
                double screenHeight = MediaQuery.of(context).size.height;
                double paddingPerSize = screenHeight > 600 ? 4.0 : 8.0;
                double pokemonSize = screenHeight > 600 ? 50 : 70;
                if (state.pokemons.length > index) {
                  return list_item(
                      types: state.pokemons[index].types,
                      name: state.pokemons[index].name,
                      paddingPerSize: paddingPerSize,
                      pokemonSize: pokemonSize,
                      url: state.pokemons[index].sprites.frontDefault);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              });
        } else {
          print("cargando");
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
      bottomNavigationBar: bottom_bar(),
    );
  }
}
