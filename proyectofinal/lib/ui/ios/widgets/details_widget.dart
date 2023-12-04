import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyectofinal/models/pokemon.dart';
import 'package:proyectofinal/models/pokemon_chain.dart';
import 'package:proyectofinal/shared/pokemon.dart';
import 'package:proyectofinal/themes/pokemons_types.dart';
import 'package:proyectofinal/ui/android/widgets/evolution_widget.dart';
import 'package:proyectofinal/ui/android/widgets/pokemon_abilities_widget.dart';
import 'package:proyectofinal/ui/android/widgets/pokemon_info_widget.dart';
import 'package:proyectofinal/ui/android/widgets/pokemon_intro_widget.dart';
import 'package:proyectofinal/ui/android/widgets/stats_graph_widget.dart';

class DetailsWidget extends StatelessWidget {
  final Pokemon pokemon;

  const DetailsWidget({super.key, required this.pokemon});
  @override
  Widget build(BuildContext context) {
    late Future<PokemonChain> pokemonChain;
    late Future<List<Pokemon>> pokemonList;
    pokemonChain = fetchEvolution(pokemon.name);
    return Stack(
      children: [
        SizedBox.expand(
          child: DraggableScrollableSheet(
            initialChildSize: 1,
            minChildSize: 0.8,
            maxChildSize: 1,
            builder: (BuildContext context, ScrollController scrollController) {
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
                            PokemonIntroWidget(pokemon: pokemon),
                            Text(
                              pokemon.id.toString(),
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            PokemonInfoWidget(pokemon: pokemon),
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
                                SizedBox(
                                    height: 300,
                                    child: StatsGraph(
                                      color: customColors[pokemon
                                          .types[0].type.name]!['color']!,
                                      stats: pokemon.stats,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      for (var item in pokemon.abilities)
                                        PokemonAbilitiesWidget(
                                            ability: item,
                                            pokemonName: item.ability.name,
                                            typeName:
                                                pokemon.types[0].type.name)
                                    ]),
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
                                  future: pokemonChain,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<String> urls = [];
                                      List<Chain> chain =
                                          snapshot.data!.chain.evolvesTo;
                                      bool noEvolution = false;
                                      urls.add(
                                          snapshot.data!.chain.species.name);
                                      while (noEvolution != true) {
                                        for (var pokemon in chain) {
                                          urls.add(pokemon.species.name);
                                          if (pokemon.evolvesTo.isNotEmpty) {
                                            chain = pokemon.evolvesTo;
                                          } else {
                                            noEvolution = true;
                                          }
                                        }
                                      }

                                      pokemonList = fetchPokemon(urls);

                                      return FutureBuilder(
                                          future: pokemonList,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Wrap(
                                                  alignment:
                                                      WrapAlignment.start,
                                                  children: [
                                                    for (var pokemon
                                                        in snapshot.data!) ...[
                                                      EvolutionWidget(
                                                          pokemon: pokemon),
                                                    ]
                                                  ]);
                                            }
                                            return const CircularProgressIndicator();
                                          });
                                    } else if (snapshot.hasError) {
                                      return const CircularProgressIndicator();
                                    }
                                    return const CircularProgressIndicator();
                                  }),
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
}
