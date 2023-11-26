import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      required this.pokemonSize
      });
  @override
  State<StatefulWidget> createState() {
    return _list_item();
  }
}

class _list_item extends State<list_item> {
  bool isFav = false;


  @override
  void initState() {
    isFav = DbInitializer.searchFav(widget.pokemon.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color cardColor = Colors.lightBlue;

    //Mostrar tipos/tipo del pokemon (SVG)
    String typePokemon = '';
    Widget svgTypeIcon = SvgPicture.asset(typePokemon, semanticsLabel: 'Tipo de pokemon');
    List<Widget> pokemonTypes = [];

    for (int i = 0; i < widget.types.length; i++){
      if(i == 0){
        cardColor = checkColor(widget.types[i].type.name);
      }
      // if (i + 1 != widget.types.length){
      //   typePokemon = 'images/Type=${widget.types[i].type.name}.svg';
      //   svgTypeIcon = SvgPicture.asset(typePokemon, semanticsLabel: 'Tipo de Pokemon: ${widget.types[i].type.name}');
      //
      //   counterTypes++;
      // }

      typePokemon = 'images/Type=${widget.types[i].type.name}.svg';
      svgTypeIcon = SvgPicture.asset(typePokemon, semanticsLabel: 'Tipo de Pokemon: ${widget.types[i].type.name}');
      pokemonTypes.add(svgTypeIcon);

    }

    //final String typePokemon = 'images/Type=grass.svg';
    final Row typesRow = widget.types.length == 1 ? Row(mainAxisAlignment: MainAxisAlignment.center,children: [pokemonTypes.first],) : Row(mainAxisAlignment: MainAxisAlignment.center,children: [pokemonTypes.first, pokemonTypes.last],);


    void changeIcon() {
      setState(() {
        isFav = !isFav;
      });
    }

    void funcion() {
      context.read<PokemonCubit>()..providePokemon(widget.pokemon);
      GoRouter.of(context).go("/detalle");
    }

    const double kPaddingValue = 15.0;
    const double kFontSizeValue = 15.0;

    return GestureDetector(
        onTap: () => funcion(),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [cardColor.withOpacity(0.6), cardColor.withOpacity(1)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter)),
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
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
                                color: Colors.white,
                              )
                                  : const Icon(
                                Icons.favorite_border,
                                size: 20,
                                color: Colors.white,
                              )
                          ),
                        ),

                        //Foto del pokemon:
                        Padding(
                          padding: EdgeInsets.only(left: kPaddingValue, bottom: kPaddingValue),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Transform.scale(
                                scale: MediaQuery.of(context).size.width > 600 ? 1.5 : 1.3,
                                child: CachedNetworkImage(
                                  imageUrl: widget.url,
                                  fit: BoxFit.fill,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                )
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),

                  Expanded(
                    flex: MediaQuery.of(context).size.width > 600 ? 2 : 1,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width > 600 ? kPaddingValue * 2 : kPaddingValue),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text('#${widget.pokemon.id.toString()}',
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.width > 600 ? kFontSizeValue * 2 : kFontSizeValue,
                                  fontWeight: FontWeight.w700,)
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 20,),

                              FilledButton(
                                onPressed: null,
                                style: FilledButton.styleFrom(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width > 600 ? kPaddingValue * 2 : kPaddingValue),
                                ),
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    '${widget.name.capitalizeFirstLetter()}',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: MediaQuery.of(context).size.width > 600 ? kFontSizeValue * 2 : kFontSizeValue,

                                    ),
                                  ),
                                ),
                              ),

                              typesRow,
                            ],
                          ),
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

extension CapitalizeFirstLetter on String {
  String capitalizeFirstLetter() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

