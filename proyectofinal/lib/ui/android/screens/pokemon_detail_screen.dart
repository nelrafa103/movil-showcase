import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyectofinal/models/hive/fav_dao.dart';
import 'package:proyectofinal/models/pokemon.dart';
import 'package:proyectofinal/models/pokemon_chain.dart';
import 'package:proyectofinal/hive.dart';
import 'package:proyectofinal/shared/pokemon.dart';
import 'package:proyectofinal/states/cubit/pokemon_cubit.dart';
import 'package:proyectofinal/states/pokemon_state.dart';
import 'package:proyectofinal/themes/pokemons_types.dart';
import 'package:proyectofinal/ui/android/widgets/evolution_widget.dart';
import 'package:proyectofinal/ui/android/widgets/expasion_widget.dart';
import 'package:proyectofinal/ui/android/widgets/pokemon_abilities_widget.dart';
import 'package:proyectofinal/ui/android/widgets/pokemon_info_widget.dart';
import 'package:proyectofinal/ui/android/widgets/pokemon_intro_widget.dart';
import 'package:proyectofinal/ui/android/widgets/stats_graph_widget.dart';

class PokemonDetailScreen extends StatefulWidget {
  const PokemonDetailScreen({super.key});

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;

  // bool isExpan = false;
  bool isFav = false;
  late Future<PokemonChain> pokemon_chain;
  late Future<List<Pokemon>> pokemon_list;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 8));
    _topAlignmentAnimation = TweenSequence<Alignment>(
      [
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1,
        ),
      ],
    ).animate(_controller);

    _bottomAlignmentAnimation = TweenSequence<Alignment>(
      [
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 1,
        ),
      ],
    ).animate(_controller);

    _controller.repeat();
  }

  void changeIcon() {
    setState(() {
      isFav = !isFav;
    });
  }

  @override
  Widget build(BuildContext context) {
    final contexto = BlocProvider.of<PokemonCubit>(context);
    final state = contexto.state as PokemonLoaded;
    return Scaffold(
        appBar: AppBar(
            title: Text(
              state.pokemon.name[0].toUpperCase() +
                  state.pokemon.name.substring(1),
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            backgroundColor:
                customColors[state.pokemon.types[0].type.name]!['color']!),
        body:
            BlocBuilder<PokemonCubit, PokemonState>(builder: (context, state) {
          if (state is PokemonLoaded) {
            isFav = DbInitializer.searchFav(state.pokemon.name);
            pokemon_chain = fetchEvolution(state.pokemon.name);
            return Stack(
              children: [
                AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              customColors[state.pokemon.types[0].type.name]![
                                  'color']!,
                              customColors[state.pokemon.types[0].type.name]![
                                  'lighter']!,
                              customColors[state.pokemon.types[0].type.name]![
                                  'darker']!,
                            ],
                            begin: _topAlignmentAnimation.value,
                            end: _bottomAlignmentAnimation.value,
                          ),
                        ),
                      );
                    }),

                //Poner textura ruido al fondo

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            DbInitializer.saveFavs(FavDao(
                                name: state.pokemon.name,
                                id: state.pokemon.id));
                            changeIcon();
                          },
                          icon: isFav
                              ? const Icon(
                                  Icons.favorite,
                                  size: 20,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.favorite_border,
                                  size: 20,
                                  color: Colors.white,
                                )),
                    ],
                  ),
                ),
                SizedBox.expand(
                  child: DraggableScrollableSheet(
                    initialChildSize: 1,
                    minChildSize: 0.8,
                    maxChildSize: 1,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 100,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Column(children: [
                                    PokemonIntroWidget(pokemon: state.pokemon),

                                    Text(
                                      '#${state.pokemon.id.toString()}',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),

                                    //Descripción del pokemón
                                    // Center(
                                    //   child: Container(
                                    //     child: Text(
                                    //         state.pokemon.species.flavorTextEntries.first.flavorText
                                    //     ),
                                    //   ),
                                    // ),

                                    const SizedBox(
                                      height: 30,
                                    ),

                                    PokemonInfoWidget(pokemon: state.pokemon),
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    //Estadísticas
                                    Column(
                                      children: [
                                        Center(
                                          child: Text(
                                            'Base Stats',
                                            style: GoogleFonts.montserrat(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        Container(
                                            height: 300,
                                            child: StatsGraph(
                                              color: customColors[state
                                                  .pokemon
                                                  .types[0]
                                                  .type
                                                  .name]!['color']!,
                                              stats: state.pokemon.stats,
                                            )),
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 30,
                                    ),

                                    Column(
                                      children: [
                                        Center(
                                          child: Text(
                                            'Abilities',
                                            style: GoogleFonts.montserrat(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              for (var item
                                                  in state.pokemon.abilities)
                                                PokemonAbilitiesWidget(
                                                    ability: item,
                                                    pokemonName:
                                                        item.ability.name,
                                                    typeName: state.pokemon
                                                        .types[0].type.name)
                                            ]),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Column(children: [
                                          Center(
                                            child: Text(
                                              'Moves',
                                              style: GoogleFonts.montserrat(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Card(
                                              elevation: 2,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              color: customColors[state
                                                  .pokemon
                                                  .types[0]
                                                  .type
                                                  .name]!['color']!,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ExpasionWidget(
                                                    pokemon: state.pokemon),
                                              ),
                                            ),
                                          )
                                        ])
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Column(children: [
                                      Center(
                                        child: Text(
                                          'Evolution',
                                          style: GoogleFonts.montserrat(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      FutureBuilder(
                                          future: pokemon_chain,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              List<String> urls = [];
                                              List<Chain> chain = snapshot
                                                  .data!.chain.evolvesTo;
                                              bool noEvolution = false;
                                              urls.add(snapshot
                                                  .data!.chain.species.name);
                                              while (noEvolution != true) {
                                                for (var pokemon in chain) {
                                                  urls.add(
                                                      pokemon.species.name);
                                                  if (pokemon
                                                      .evolvesTo.isNotEmpty) {
                                                    chain = pokemon.evolvesTo;
                                                  } else {
                                                    noEvolution = true;
                                                  }
                                                }
                                              }

                                              pokemon_list = fetchPokemon(urls);

                                              return FutureBuilder(
                                                  future: pokemon_list,
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Wrap(
                                                          alignment:
                                                              WrapAlignment
                                                                  .start,
                                                          children: [
                                                            for (var pokemon
                                                                in snapshot
                                                                    .data!) ...[
                                                              EvolutionWidget(
                                                                  pokemon:
                                                                      pokemon),
                                                            ]
                                                          ]);
                                                    }
                                                    return const CircularProgressIndicator();
                                                  });
                                            } else if (snapshot.hasError) {
                                              return AlertDialog(
                                                  icon:
                                                      const Icon(Icons.cancel),
                                                  title: const Text(
                                                      "There is a problem"),
                                                  content: Text(
                                                      '${snapshot.error}'));
                                            }
                                            return const CircularProgressIndicator();
                                          }),
                                    ]),

                                    const SizedBox(
                                      height: 40,
                                    ),
                                  ])),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return Container();
        }));
  }
}
