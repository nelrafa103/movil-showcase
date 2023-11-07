import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyectofinal/models/pokemon.dart';
import 'package:proyectofinal/states/cubit/listeners/pokemon_cubit.dart';
import 'package:proyectofinal/states/cubit/listeners/pokemons_cubit.dart';
import 'package:proyectofinal/themes/pokemons_types.dart';

class param_item extends StatefulWidget {
  final String title;
  final String url;
  final double paddingPerSize;
  final double pokemonSize;
  final Color color;

  const param_item(
      {super.key,
      required this.title,
      required this.url,
      required this.paddingPerSize,
      required this.pokemonSize,
      required this.color});
  @override
  State<StatefulWidget> createState() {
    return _param_item();
  }
}

class _param_item extends State<param_item> {
  @override
  Widget build(BuildContext context) {
    String types = '';
    Color card_color = Colors.lightBlue;
    return GestureDetector(
        onTap: () => {},
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.url),
                  fit: BoxFit.cover,
                  alignment: Alignment.centerRight,
                ),
                gradient: LinearGradient(
                    colors: [widget.color, widget.color],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter)),
            child: Padding(
              padding: EdgeInsets.only(
                  left: 0,
                  right: 0,
                  top: widget.paddingPerSize,
                  bottom: widget.paddingPerSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FilledButton(
                            onPressed: null,
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.all(12.0),
                            ),
                            child: Text(
                              widget.title,
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
