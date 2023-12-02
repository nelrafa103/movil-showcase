import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyectofinal/models/pokemon.dart';
import 'package:proyectofinal/themes/pokemons_types.dart';

class EvolutionWidget extends StatelessWidget {
  final Pokemon pokemon;

  const EvolutionWidget({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              customColors[pokemon.types[0].type.name]!['color']!,
              Colors.white,
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(imageUrl: pokemon.sprites.other!.officialArtwork.frontDefault!, width: 75,),
              ),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    pokemon.name[0].toUpperCase() + pokemon.name.substring(1),
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ))
            ],
          ),
        ));
  }
}
