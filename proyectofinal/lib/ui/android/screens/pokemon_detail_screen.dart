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

  bool isExpan = false;
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
            title: Text(state.pokemon.name),
            backgroundColor:
                Custom_Colors[state.pokemon.types[0].type.name]!['color']!),
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
                              Custom_Colors[state.pokemon.types[0].type.name]![
                                  'color']!,
                              Custom_Colors[state.pokemon.types[0].type.name]![
                                  'lighter']!,
                              Custom_Colors[state.pokemon.types[0].type.name]![
                                  'darker']!,
                            ],
                            begin: _topAlignmentAnimation.value,
                            end: _bottomAlignmentAnimation.value,
                          ),
                        ),
                      );
                    }),
                Padding(
                  padding: EdgeInsets.all(16.0),
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
                                  color: Colors.red,
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
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Column(children: [
                                    PokemonIntroWidget(pokemon: state.pokemon),
                                    Text(
                                      state.pokemon.id.toString(),
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 10,
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
                                              color: Custom_Colors[state
                                                  .pokemon
                                                  .types[0]
                                                  .type
                                                  .name]!['color']!,
                                              stats: state.pokemon.stats,
                                            )),
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 20,
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
                                                    pokemonName:
                                                        item.ability.name,
                                                    typeName: state.pokemon
                                                        .types[0].type.name)
                                            ]),
                                        const SizedBox(
                                          height: 20,
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
                                          ExpansionPanelList(
                                            expansionCallback:
                                                (int index, bool isExpanded) {
                                              setState(() {
                                                isExpan = !isExpan;
                                              });
                                            },
                                            children: [
                                              ExpansionPanel(
                                                headerBuilder:
                                                    (BuildContext context,
                                                        bool isExpanded) {
                                                  return const ListTile(
                                                    title: Text('Movements'),
                                                  );
                                                },
                                                body: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      for (var item in state
                                                          .pokemon.moves)
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(9),
                                                          width:
                                                              double.infinity,
                                                          child: Card(
                                                              color: Custom_Colors[state
                                                                      .pokemon
                                                                      .types[0]
                                                                      .type
                                                                      .name]![
                                                                  'color']!,
                                                              child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          10),
                                                                  child: Text(
                                                                    item.move
                                                                        .name,
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ))),
                                                        )
                                                    ]),
                                                isExpanded: isExpan,
                                              ),
                                            ],
                                          ),
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
                                              return Text('${snapshot.error}');
                                            }
                                            return const CircularProgressIndicator();
                                          })
                                    ]),
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
