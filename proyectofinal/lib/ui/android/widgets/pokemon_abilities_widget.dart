import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyectofinal/models/pokemon.dart';
import 'package:proyectofinal/states/abilities_state.dart';
import 'package:proyectofinal/states/cubit/abilities_cubit.dart';
import 'package:proyectofinal/themes/pokemons_types.dart';

class PokemonAbilitiesWidget extends StatelessWidget {
  final String pokemonName;
  final String typeName;
  final Ability ability;

  const PokemonAbilitiesWidget({
    super.key,
    required this.ability,
    required this.pokemonName,
    required this.typeName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: customColors[typeName]!['color']!,
          child: ListTile(
            title: Text(
              pokemonName[0].toUpperCase() + pokemonName.substring(1),
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            trailing: Icon(Icons.info_outline, color: Colors.white),
            onTap: () {
              _showAbilityBottomSheet(context);
            },
            selected: true,
          )),
    );
  }

  void _showAbilityBottomSheet(BuildContext context) {
    if (!kIsWeb && Platform.isIOS) {
      BlocProvider.of<AbilitiesCubit>(context)
          .fetchSpecific(ability.ability.url);
      showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) =>
              BlocBuilder<AbilitiesCubit, AbilitiesState>(
                  builder: (context, state) {
                if (state is PopulatedAbilities) {
                  return CupertinoActionSheet(
                    title: Text(
                      state.abilities[0].name[0].toUpperCase() +
                          state.abilities[0].name.substring(1),
                      overflow: TextOverflow.fade,
                    ),
                    message: Text(
                      state.abilities[0].effectEntries[1].effect,
                      overflow: TextOverflow.fade,
                    ),
                    actions: <CupertinoActionSheetAction>[
                      CupertinoActionSheetAction(
                        isDefaultAction: true,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cerrar"),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }));
    }
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          BlocProvider.of<AbilitiesCubit>(context)
              .fetchSpecific(ability.ability.url);

          return BlocBuilder<AbilitiesCubit, AbilitiesState>(
              builder: (context, state) {
            if (state is PopulatedAbilities) {
              return SizedBox(
                height: 800,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          pokemonName,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            child: Card(
                              child: Center(
                                child: ListTile(
                                  title: Text(
                                    "Description",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  subtitle: Text(
                                    state.abilities[0].flavorTextEntries[0]
                                        .flavorText,
                                    // overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  isThreeLine: true,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Card(
                            child: Center(
                              child: ListTile(
                                title: Text(
                                  "Effect",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                subtitle: Text(
                                  state.abilities[0].effectEntries[0]
                                      .shortEffect,
                                  // overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                isThreeLine: true,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Card(
                            child: Center(
                              child: ListTile(
                                title: Text(
                                  "Effect in depth",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                subtitle: Text(
                                  state.abilities[0].effectEntries[0].effect,
                                  // overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                isThreeLine: true,
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "Cerrar",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          });
        });
  }
}
