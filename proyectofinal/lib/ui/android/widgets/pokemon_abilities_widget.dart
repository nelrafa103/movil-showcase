import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyectofinal/themes/pokemons_types.dart';

class PokemonAbilitiesWidget extends StatelessWidget {
  final String pokemonName;
  final String typeName;

  const PokemonAbilitiesWidget({
    super.key,
    required this.pokemonName,
    required this.typeName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(9),
      width: double.infinity,
      child: Card(
          color: customColors[typeName]!['color']!,
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                pokemonName[0].toUpperCase() + pokemonName.substring(1),
                style: GoogleFonts.montserrat(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ))),
    );
  }
}
