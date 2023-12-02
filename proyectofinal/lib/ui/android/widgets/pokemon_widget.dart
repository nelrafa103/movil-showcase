import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:proyectofinal/ui/android/screens/pokemon_detail_screen.dart';
import 'package:proyectofinal/ui/ios/tabs/pokemon_detail_tab.dart';

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
      icons.add(SvgPicture.asset(type["icon"], semanticsLabel: "", height: 40,));
    }
    void changeIcon() {
      setState(() {
        isFav = !isFav;
      });
    }

    void funcion() {
      context.read<PokemonCubit>().providePokemon(widget.pokemon);
      if (!Platform.isIOS) {
        GoRouter.of(context).go("/detalle");
      } else {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (context) => PokemonDetailTab(),
          ),
        );
      }
    }

    const double kPaddingValue = 15.0;
    const double kFontSizeValue = 15.0;

    return GestureDetector(
        onTap: () => funcion(),
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              cardColor.first.withOpacity(0.6),
              cardColor.last.withOpacity(1)
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width > 600
                  ? kPaddingValue * 2
                  : 2),
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        //Foto del pokemon:
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Transform.scale(
                              scale: MediaQuery.of(context).size.width > 600
                                  ? 1.5
                                  : 1.0,
                              child: CachedNetworkImage(
                                imageUrl: widget.pokemon.sprites.other!
                                    .officialArtwork.frontDefault!,
                                fit: BoxFit.fill,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              )),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    flex: MediaQuery.of(context).size.width > 600 ? 2 : 1,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                          size: kFontSizeValue + 5,
                                          color: Colors.white,
                                        )
                                      : const Icon(
                                          Icons.favorite_border,
                                          size: kFontSizeValue + 3,
                                          color: Colors.white,
                                        )),
                              Text('#${widget.pokemon.id.toString()}  ',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width >
                                                600
                                            ? kFontSizeValue * 2
                                            : kFontSizeValue,
                                    fontWeight: FontWeight.w700,
                                  )),
                            ],
                          ),
                        ),

                        Align(
                          alignment: Alignment.center,
                          child: FilledButton(
                            onPressed: null,
                            style: FilledButton.styleFrom(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width > 600
                                      ? kPaddingValue * 2
                                      : kPaddingValue / 2),
                            ),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                widget.pokemon.name[0].toUpperCase() +
                                    widget.pokemon.name.substring(1),
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize:
                                  MediaQuery.of(context).size.width >
                                      600
                                      ? kFontSizeValue * 2
                                      : kFontSizeValue - 2,
                                ),
                              ),
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: icons,
                          )
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
