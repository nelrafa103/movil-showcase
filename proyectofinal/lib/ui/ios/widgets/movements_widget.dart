import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyectofinal/models/pokemon.dart';
import 'package:proyectofinal/themes/pokemons_types.dart';

class MovementsWidget extends StatelessWidget {
  final Pokemon pokemon;

  const MovementsWidget({super.key, required this.pokemon});

  @override
  Widget build(Object context) {
    return ListView(
      children: [
        for (var item in pokemon.moves)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9),
            width: double.infinity,
            child: Card(
                color: customColors[pokemon.types[0].type.name]!['color']!,
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      item.move.name[0].toUpperCase() +
                          item.move.name.substring(1),
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ))),
          )
      ],
    );
  }
}
