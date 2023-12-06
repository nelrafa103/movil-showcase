import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyectofinal/models/ability.dart';
import 'package:proyectofinal/shared/pokemon.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectofinal/states/abilities_state.dart';
import 'package:proyectofinal/states/cubit/abilities_cubit.dart';
import 'package:proyectofinal/themes/pokemons_types.dart';

class AbilityWidget extends StatefulWidget {
  final Ability ability;

  const AbilityWidget({Key? key, required this.ability}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AbilityWidget();
  }
}

class _AbilityWidget extends State<AbilityWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => (),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: ListTile(
              title: Text(
                '#${widget.ability.id.toString()} - ${widget.ability.name[0].toUpperCase() + widget.ability.name.substring(1)}',
                style: GoogleFonts.montserrat(
                  color: Colors.black87,
                  fontSize: fontSizes(),
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                widget.ability.effectEntries[1].shortEffect,
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              selected: true,
              trailing: const Icon(Icons.info_outline, color: Colors.black87),
              onTap: () {
                _showAbilityBottomSheet(
                    context,
                    widget.ability.name,
                    widget.ability.flavorTextEntries[0].flavorText,
                    widget.ability.effectEntries[0].effect,
                    widget.ability.effectEntries[0].shortEffect);
              },
            ),
          ),
        ));
  }

  void _showAbilityBottomSheet(BuildContext context, String ability,
      String description, String short, String effect) {
    if (!kIsWeb && Platform.isIOS) {
      showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) =>
              BlocBuilder<AbilitiesCubit, AbilitiesState>(
                  builder: (context, state) {
                if (state is PopulatedAbilities) {
                  return CupertinoActionSheet(
                    title: Text(
                      ability[0].toUpperCase() + ability.substring(1),
                      overflow: TextOverflow.fade,
                    ),
                    message: Text(
                      description,
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
          return BlocBuilder<AbilitiesCubit, AbilitiesState>(
              builder: (context, state) {
            if (state is PopulatedAbilities) {
              return SizedBox(
                height: 600,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          ability,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
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
                                  short,
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
                        Card(
                          child: Center(
                            child: ListTile(
                              title: Text(
                                "Effect",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              subtitle: Text(
                                effect,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              isThreeLine: true,
                            ),
                          ),
                        ),
                        Card(
                          child: Center(
                            child: ListTile(
                              title: Text(
                                "Effect in depth",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              subtitle: Text(
                                description,
                                // overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              isThreeLine: true,
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
