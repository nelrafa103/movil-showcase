import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyectofinal/models/pokemon.dart';
import 'package:proyectofinal/shared/pokemon.dart';
import 'package:proyectofinal/themes/pokemons_types.dart';

class PokemonInfoWidget extends StatelessWidget {
  final Pokemon pokemon;

  PokemonInfoWidget({
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> icons = [];

    for (var element in pokemon.types) {
      dynamic type = customColors[element.type.name];
      icons.add(SvgPicture.asset(type["icon"], semanticsLabel: "", height: 40,));
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Text(
                  'Height',
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                Text(
                  pokemon.height.toString() + " feet",
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
        
            const VerticalDivider(),
        
            Column(
              children: [
                Text(
                  'Type',
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                Row(children: icons),
              ],
            ),
        
            VerticalDivider(),
        
            Column(
              children: [
                Text(
                  'Weight',
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${pokemon.weight} kg',
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
