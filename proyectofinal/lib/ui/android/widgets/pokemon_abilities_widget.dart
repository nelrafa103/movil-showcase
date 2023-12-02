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
      padding: const EdgeInsets.all(5),
      width: double.infinity,
      child: Card(
          elevation: 1,
          color: customColors[typeName]!['color']!,
          child: ListTile(
            title: Text(
              pokemonName[0].toUpperCase() + pokemonName.substring(1),
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Icon(Icons.info_outline, color: Colors.white),
            onTap: (){
              _showAbilityBottomSheet(context, pokemonName);
            },
          )
      ),
    );
  }

  void _showAbilityBottomSheet(BuildContext context, String ability){
    showModalBottomSheet<void>(context: context, builder: (BuildContext context){
      return SizedBox(
        height: 600,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(ability, style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),),

                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    child: Card(
                      child: Center(
                        child: ListTile(
                          title: Text("Description", style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                          ),),
                          subtitle: Text("Ups GRASS moves in a pinch.", style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                          ),),
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  child: Card(
                    child: Center(
                      child: ListTile(
                        title: Text("Effect", style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                        ),),
                        subtitle: Text("Strengthens grass moves to inflict 1.5× damage at 1/3 max HP or less.", style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                        ),),
                      ),
                    ),
                  ),
                ),

                Container(
                  child: Card(
                    child: Center(
                      child: ListTile(
                        title: Text("Effect in depth", style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                        ),),
                        subtitle: Text("When this Pokémon has 1/3 or less of its HP remaining, its grass-type moves inflict 1.5× as much regular damage.", style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                        ),),
                      ),
                    ),
                  ),
                ),

                ElevatedButton(style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ), onPressed: () => Navigator.pop(context), child: Text("Cerrar", style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),),)
              ],
            ),
          ),
        ),
      );
    });
  }
}

