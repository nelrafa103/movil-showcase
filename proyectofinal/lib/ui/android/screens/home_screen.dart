import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
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
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 130.0,
                stretch: true,
                floating: true,
                pinned: true,
                backgroundColor: Colors.white60,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    'images/AppBarBG.png',
                    fit: BoxFit.cover,
                  ),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'icon/pokeball_outline.svg',
                        height: 30,
                        color: Colors.black54,
                      ),
                      Text(
                        'Mi Pokedex',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  stretchModes: const <StretchMode>[
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                    StretchMode.fadeTitle,
                  ],
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: IconButton(
                        onPressed: () {
                          //Mostrar listado de pokemones favoritos

                          // changeIcon();
                        },
                        icon: const Icon(
                          Icons.favorite_border,
                          size: 24,
                          color: Colors.black54,
                        )),
                  ),
                ],
              )
            ];
          },
          body: BlocConsumer<PokemonsCubit, PokemonsState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is PopulatedPokemons) {
                  double screenWidth = MediaQuery.of(context).size.width;
                  return GridView.builder(
                      controller: controller,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: screenWidth < 600 ? 2 : 4,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        childAspectRatio: screenWidth < 600 ? 1.6 : 1.1,
                      ),
                      itemCount: state.pokemons.length,
                      itemBuilder: (BuildContext context, int index) {
                        double screenHeight =
                            MediaQuery.of(context).size.height;
                        double paddingPerSize = screenHeight > 600 ? 4.0 : 8.0;
                        double pokemonSize = screenHeight > 600 ? 50 : 70;
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
                      });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
