import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyectofinal/models/hive/fav_dao.dart';
import 'package:proyectofinal/models/pokemon.dart';
import 'package:proyectofinal/sqflite.dart';
import 'package:proyectofinal/states/cubit/listeners/pokemon_cubit.dart';
import 'package:proyectofinal/themes/pokemons_types.dart';

class list_item extends StatefulWidget {
  final String name;
  final Pokemon pokemon;
  final List<Type> types;
  final String url;
  final double paddingPerSize;
  final double pokemonSize;

  const list_item(
      {super.key,
      required this.pokemon,
      required this.name,
      required this.types,
      required this.url,
      required this.paddingPerSize,
      required this.pokemonSize});
  @override
  State<StatefulWidget> createState() {
    return _list_item();
  }
}

class _list_item extends State<list_item> {
  bool isFav = false;

  @override
  void initState() {
    print(widget.pokemon.name);
    isFav = DbInitializer.searchFav(widget.pokemon.name);
    print(isFav);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String types = '';
    Color card_color = Colors.lightBlue;
    for (int i = 0; i < widget.types.length; i++) {
      if (i == 0) {
        card_color = checkColor(widget.types[i].type.name);
      }
      if (i + 1 != widget.types.length) {
        types += '${widget.types[i].type.name} - ';
      } else {
        types += '${widget.types[i].type.name}';
      }
    }

    void changeIcon() {
      setState(() {
        isFav = !isFav;
      });
    }

    void funcion() {
      // PokemonCubit()..providePokemon(widget.pokemon);
      context.read<PokemonCubit>()..providePokemon(widget.pokemon);

      // print(widget.pokemon.name);
      GoRouter.of(context).go("/detalle");
    }

    return GestureDetector(
        onTap: () => funcion(),
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [card_color, card_color],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter)),
            child: Padding(
              padding: EdgeInsets.all(widget.paddingPerSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            DbInitializer.saveFavs(FavDao(
                                name: widget.pokemon.name,
                                id: widget.pokemon.id));
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
                      Text(
                        types,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      Text('#${widget.pokemon.id.toString()}',
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
                        width: widget.pokemonSize,
                        height: widget.pokemonSize,
                        child: Center(
                            child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Transform.scale(
                              scale: 1.3,
                              child: CachedNetworkImage(
                                imageUrl: widget.url,
                                fit: BoxFit.fill,
                                filterQuality: FilterQuality.none,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              )),
                        )),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FilledButton(
                            onPressed: null,
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.all(13.0),
                            ),
                            child: Text(
                              widget.name,
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
