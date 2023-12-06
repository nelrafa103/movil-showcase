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
                  '#${widget.ability.id.toString()} - ${widget.ability.name[0].toUpperCase() +
                      widget.ability.name.substring(1)}',
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

              trailing: Icon(Icons.info_outline, color: Colors.black87),
              onTap: () {
                //_showAbilityBottomSheet(context);
              },

            ),
          ),
        ));
  }
}
