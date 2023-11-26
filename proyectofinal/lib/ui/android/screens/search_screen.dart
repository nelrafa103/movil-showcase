import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyectofinal/models/param.dart';
import 'package:proyectofinal/models/pokemon.dart';
import 'package:proyectofinal/states/cubit/listeners/app_cubit.dart';
import 'package:proyectofinal/states/cubit/listeners/pokemons_cubit.dart';
import 'package:proyectofinal/states/list_state.dart';
import 'package:proyectofinal/themes/pokemons_types.dart';
import 'package:proyectofinal/ui/android/widgets/bottom_bar.dart';
import 'package:proyectofinal/ui/android/widgets/param_item.dart';
import 'package:proyectofinal/ui/android/widgets/pokemon_item.dart';
import 'package:shimmer/shimmer.dart';

class seach_screen extends StatefulWidget {
  const seach_screen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _seach_screen();
  }
}

class _seach_screen extends State<seach_screen> {
  final TextEditingController _searchController = TextEditingController();

  bool filtro = false;
  List<Param> param_list = [
    Param(
      id: 12,
      title: "Grass",
      url: "images/bulbassur.png",
      color: Grass,
    ),
    Param(id: 10, title: "Fire", url: "images/chamander.png", color: Fire),
    Param(id: 11, title: "Water", url: "images/squirtle.png", color: Water),
    Param(id: 7, title: "Bug", url: "images/caterpie.png", color: Bug),
    Param(id: 1, title: "Normal", url: "images/rattata.png", color: Normal),
    Param(id: 3, title: "Flying", url: "images/pidgey.png", color: Flying),
    Param(
        id: 13, title: "Electric", url: "images/pikachu.png", color: Electric),
    Param(id: 2, title: "Fighting", url: "images/mankey.png", color: Fighting),
    Param(id: 18, title: "Fairy", url: "images/cleafairy.png", color: Fairy),
    Param(id: 9, title: "Steel", url: "images/beldum.png", color: Steel),
    Param(id: 15, title: "Ice", url: "images/snover.png", color: Ice),
    Param(id: 4, title: "Poison", url: "images/nidoran-f.png", color: Poison),
    Param(id: 5, title: "Ground", url: "images/diglett.png", color: Ground),
    Param(id: 14, title: "Psychic", url: "images/abra.png", color: Psychic),
    Param(id: 6, title: "Rock", url: "images/geodude.png", color: Rock),
  ];

  void redirect(String param) {
    /*
      Comprobar por nombre o por id 
    */

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
      body: BlocBuilder<ListCubit, ListState>(builder: ((context, state) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            childAspectRatio: 1.6,
          ),
          itemCount: 15,
          itemBuilder: (BuildContext context, int index) {
            double screenHeight = MediaQuery.of(context).size.height;
            double paddingPerSize = screenHeight > 600 ? 4.0 : 8.0;
            double pokemonSize = screenHeight > 600 ? 50 : 70;

            return GestureDetector(
                onTap: () async => {
                  await BlocProvider.of<ListCubit>(context)
                      .filter_by_type(param_list[index].id)
                      .then((value) => showSearch(
                      context: context, delegate: CustomSearchBar())),
                },
                child: param_item(
                    param: param_list[index],
                    color: param_list[index].color,
                    paddingPerSize: paddingPerSize,
                    pokemonSize: pokemonSize));
          },
        );
      })),
      bottomNavigationBar: const bottom_bar(),
    );
  }
}

class CustomSearchBar extends SearchDelegate {
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
          context.read<ListCubit>().fetch();
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
    BlocProvider.of<ListCubit>(context).filter_by_name(query);
    return BlocConsumer<ListCubit, ListState>(listener: (context, state) {
      if (state is RepopulatedList) {}
    }, builder: (context, state) {
      if (state is ListLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is PopulatedList) {
        print(state.pokemons.length);

        List<Pokemon> list = state.pokemons;
        Set<Pokemon> set = Set<Pokemon>.from(list);
        List<Pokemon> result = set.toList();
        list = result;
        //   list.sort((a, b) => a.id.compareTo(b.id));

        return GridView.builder(
          //   controller: controller,
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
              return list_item(
                  pokemon: list[index],
                  types: list[index].types,
                  name: list[index].name,
                  paddingPerSize: paddingPerSize,
                  pokemonSize: pokemonSize,
                  url: list[index].sprites.other?.officialArtwork.frontDefault ?? "");
            });
      } else if (state is ListError) {
        return Center(child: Text(state.message));
      } else if (state is RepopulatedList) {
        //rprint("cargando");
        List<Pokemon> list = state.pokemons;
        //   list.sort((a, b) => a.id.compareTo(b.id));

        print(state.pokemons.length);
        return GridView.builder(
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
              return list_item(
                  pokemon: list[index],
                  types: list[index].types,
                  name: list[index].name,
                  paddingPerSize: paddingPerSize,
                  pokemonSize: pokemonSize,
                  url: list[index].sprites.other?.officialArtwork.frontDefault ?? "");
            });
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}