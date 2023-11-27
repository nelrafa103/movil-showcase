import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyectofinal/models/hive/fav_dao.dart';
import 'package:proyectofinal/models/pokemon.dart';
import 'package:proyectofinal/hive.dart';
import 'package:proyectofinal/states/cubit/pokemon_cubit.dart';
import 'package:proyectofinal/themes/pokemons_types.dart';

class PokemonWidget extends StatefulWidget {
  final Pokemon pokemon;

  final double paddingPerSize;
  final double pokemonSize;

  const PokemonWidget(
      {super.key,
      required this.pokemon,
      required this.paddingPerSize,
      required this.pokemonSize});
  @override
  State<StatefulWidget> createState() {
    return _PokemonWidget();
  }
}

class _PokemonWidget extends State<PokemonWidget> {
  bool isFav = false;

  @override
  void initState() {
    isFav = DbInitializer.searchFav(widget.pokemon.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Color> cardColor = [];
    final List<Widget> icons = [];
    cardColor.add(Colors.white);

    cardColor.add(checkColor(widget.pokemon.types[0].type.name));

    for (var element in widget.pokemon.types) {
      dynamic type = customColors[element.type.name];
      icons.add(SvgPicture.asset(type["icon"], semanticsLabel: ""));
    }
    void changeIcon() {
      setState(() {
        isFav = !isFav;
      });
    }

    void funcion() {
      context.read<PokemonCubit>().providePokemon(widget.pokemon);
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
                    colors: cardColor,
                    begin: Alignment.bottomRight,
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
                      SizedBox(
                        width: widget.pokemonSize,
                        height: widget.pokemonSize,
                        child: Center(
                            child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Transform.scale(
                              scale: 1,
                              child: CachedNetworkImage(
                                imageUrl: widget.pokemon.sprites.other!
                                        .officialArtwork.frontDefault ??
                                    widget.pokemon.sprites.frontDefault,
                                fit: BoxFit.fill,
                                filterQuality: FilterQuality.none,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
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
                              widget.pokemon.name[0].toUpperCase() +
                                  widget.pokemon.name.substring(1),
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: icons,
                          )
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
