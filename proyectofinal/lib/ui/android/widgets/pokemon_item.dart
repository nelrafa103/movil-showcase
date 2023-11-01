import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyectofinal/models/pokemon.dart';
import 'package:proyectofinal/themes/pokemons_types.dart';

class list_item extends StatefulWidget {
  final String name;
  final List<Type> types;
  final String url;
  final double paddingPerSize;
  final double pokemonSize;

  const list_item(
      {super.key,
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

    return GestureDetector(
        onTap: () => {GoRouter.of(context).go("/detalle")},
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
                          onPressed: () => {},
                          icon: const Icon(
                            Icons.favorite_border,
                            size: 20,
                            color: Colors.white,
                          )),
                      Text('#001',
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
                              padding: const EdgeInsets.all(12.0),
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
                          Text(
                            types,
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
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
