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
        color: Custom_Colors[pokemon.types[0].type.name]!['color']!,
        child: Column(
          children: [
            CachedNetworkImage(imageUrl: pokemon.sprites.frontDefault),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  pokemon.name[0].toUpperCase() + pokemon.name.substring(1),
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ))
          ],
        ));
  }
}
