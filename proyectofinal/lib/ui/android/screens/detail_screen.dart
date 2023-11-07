import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyectofinal/models/bar_chart.dart';
import 'package:proyectofinal/models/hive/fav_dao.dart';
import 'package:proyectofinal/models/pokemon.dart';
import 'package:proyectofinal/models/pokemon_chain.dart';
import 'package:proyectofinal/models/pokemon_evolution.dart';
import 'package:proyectofinal/sqflite.dart';
import 'package:proyectofinal/states/cubit/listeners/pokemon_cubit.dart';
import 'package:proyectofinal/states/pokemon_state.dart';
import 'package:proyectofinal/themes/pokemons_types.dart';
//import 'package:flutter_charts/flutter_charts.dart' as charts;
import 'package:charts_flutter/flutter.dart' as charts;

class PokemonDetail extends StatefulWidget {
  //final Pokemon pokemon;

  const PokemonDetail({super.key});

  @override
  State<PokemonDetail> createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;

  bool isExpan = false;
  bool isFav = false;
  late Future<PokemonChain> pokemon_chain;
  Future<PokemonChain> fetchEvolution(String type) async {
    var dio = Dio();

    String url = "https://pokeapi.co/api/v2/pokemon-species/${type}";
    var response = await dio.get(url);
    var data = Welcome.fromJson(response.data);
    var response2 = await dio.get(data.evolutionChain.url);
    var data2 = PokemonChain.fromJson(response2.data);

    return data2;
  }

  @override
  void initState() {
    // TODO: implement initState
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
    /* Aqui se tiene que aplicar un Future builder para manejar la parte 
         de las evoluciones el plan es hacer un fetch al entrar a la pagina y asi se muestra 
         una lista de las evoluciones del pokemon
         */
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
                                    ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        maxHeight:
                                            120, // Establece la altura máxima que desees
                                        maxWidth: double
                                            .infinity, // O ajusta el ancho máximo si es necesario
                                      ),
                                      child: Stack(
                                        alignment: Alignment.topCenter,
                                        clipBehavior: Clip.none,
                                        children: [
                                          FractionalTranslation(
                                            translation: const Offset(0,
                                                -0.6), // Ajusta la posición vertical
                                            child: Container(
                                              width:
                                                  250, // Ajusta el ancho de la imagen
                                              height:
                                                  250, // Ajusta el alto de la imagen
                                              child: Transform.scale(
                                                  scale: 1.5,
                                                  child: CachedNetworkImage(
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  progress) =>
                                                              Center(
                                                                  child:
                                                                      const CircularProgressIndicator()),
                                                      imageUrl: state
                                                          .pokemon
                                                          .sprites
                                                          .other!
                                                          .officialArtwork
                                                          .frontDefault)),
                                            ),
                                          ),
                                          FractionalTranslation(
                                            translation: const Offset(0,
                                                0.5), // Ajusta la posición vertical
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Text(
                                                state.pokemon.name,
                                                style: GoogleFonts.montserrat(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 38,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

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

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                'Species',
                                                style: GoogleFonts.montserrat(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                state.pokemon.species.name,
                                                style: GoogleFonts.montserrat(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'Type',
                                                style: GoogleFonts.montserrat(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                'Grass - Poison',
                                                style: GoogleFonts.montserrat(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'Weight',
                                                style: GoogleFonts.montserrat(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                '${state.pokemon.weight} kg',
                                                style: GoogleFonts.montserrat(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

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
                                                Container(
                                                  padding: EdgeInsets.all(9),
                                                  width: double.infinity,
                                                  child: Card(
                                                      color: Custom_Colors[state
                                                          .pokemon
                                                          .types[0]
                                                          .type
                                                          .name]!['color']!,
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: Text(
                                                            item.ability.name
                                                                .toUpperCase(),
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              color: Colors
                                                                  .black87,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14,
                                                            ),
                                                          ))),
                                                )
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
                                                              EdgeInsets.all(9),
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
                                              return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Card(
                                                        color: Custom_Colors[
                                                                state
                                                                    .pokemon
                                                                    .types[0]
                                                                    .type
                                                                    .name]![
                                                            'color']!,
                                                        child: Column(
                                                          children: [
                                                            CachedNetworkImage(
                                                                imageUrl:
                                                                    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${DbInitializer.getPokemon(snapshot.data!.chain!.species!.name).id}.png"),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        10),
                                                                child: Text(
                                                                  snapshot
                                                                      .data!
                                                                      .chain!
                                                                      .species!
                                                                      .name,
                                                                  style: GoogleFonts
                                                                      .montserrat(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        10,
                                                                  ),
                                                                ))
                                                          ],
                                                        )),
                                                    Icon(Icons.arrow_forward),
                                                    Card(
                                                        color: Custom_Colors[
                                                                state
                                                                    .pokemon
                                                                    .types[0]
                                                                    .type
                                                                    .name]![
                                                            'color']!,
                                                        child: Column(
                                                          children: [
                                                            CachedNetworkImage(
                                                                imageUrl:
                                                                    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${DbInitializer.getPokemon(snapshot.data!.chain!.species!.name).id + 1}.png"),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        10),
                                                                child: Text(
                                                                  snapshot
                                                                      .data!
                                                                      .chain!
                                                                      .evolvesTo[
                                                                          0]
                                                                      .species!
                                                                      .name,
                                                                  style: GoogleFonts
                                                                      .montserrat(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        10,
                                                                  ),
                                                                ))
                                                          ],
                                                        )),
                                                    Icon(Icons.arrow_forward),
                                                    Card(
                                                        color: Custom_Colors[
                                                                state
                                                                    .pokemon
                                                                    .types[0]
                                                                    .type
                                                                    .name]![
                                                            'color']!,
                                                        child: Column(
                                                          children: [
                                                            CachedNetworkImage(
                                                                imageUrl:
                                                                    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${DbInitializer.getPokemon(snapshot.data!.chain!.species!.name).id + 2}.png"),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        10),
                                                                child: Text(
                                                                  snapshot
                                                                      .data!
                                                                      .chain!
                                                                      .evolvesTo[
                                                                          0]
                                                                      .evolvesTo[
                                                                          0]
                                                                      .species
                                                                      .name,
                                                                  style: GoogleFonts
                                                                      .montserrat(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        10,
                                                                  ),
                                                                ))
                                                          ],
                                                        )),
                                                  ]);
                                            } else if (snapshot.hasError) {
                                              return Text('${snapshot.error}');
                                            }
                                            return CircularProgressIndicator();
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

class StatsGraph extends StatefulWidget {
  final Color color;

  final List<Stat> stats;
  StatsGraph({super.key, required this.color, required this.stats});

  @override
  State<StatefulWidget> createState() {
    return _StatsGraph();
  }
}

class _StatsGraph extends State<StatsGraph> {
  @override
  Widget build(BuildContext context) {
    final List<BarChartModel> data = [
      BarChartModel(
        label: "HP",
        value: widget.stats.elementAt(0).baseStat,
      ),
      BarChartModel(
        label: "Attack",
        value: widget.stats.elementAt(1).baseStat,
      ),
      BarChartModel(
        label: "Defense",
        value: widget.stats.elementAt(2).baseStat,
      ),
      BarChartModel(
        label: "Special-Attack",
        value: widget.stats.elementAt(3).baseStat,
      ),
      BarChartModel(
        label: "Special-Defense",
        value: widget.stats.elementAt(4).baseStat,
      ),
      BarChartModel(
        label: "Speed",
        value: widget.stats.elementAt(5).baseStat,
      ),
    ];

    List<charts.Series<BarChartModel, String>> series = [
      charts.Series(
        id: "value",
        data: data,
        domainFn: (BarChartModel series, _) => series.label,
        measureFn: (BarChartModel series, _) => series.value,
        colorFn: (BarChartModel series, _) =>
            charts.ColorUtil.fromDartColor(widget.color),
        // Agrega el valor dentro de cada barra
        // insideLabelStyleAccessorFn: (BarChartModel series, _) => series.value.,
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(10),
      child: charts.BarChart(
        series,
        animate: true,
        vertical: false,
      ),
    );
  }
}
