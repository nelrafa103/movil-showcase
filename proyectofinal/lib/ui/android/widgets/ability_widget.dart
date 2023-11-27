import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyectofinal/models/ability.dart';
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
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('#${widget.ability.id.toString()}',
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          )),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FilledButton(
                            onPressed: null,
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.all(13.0),
                            ),
                            child: Text(
                              widget.ability.name[0].toUpperCase() +
                                  widget.ability.name.substring(1),
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          ),

                          /* Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: icons,
                          ) */
                        ],
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        widget.ability.effectEntries[1].shortEffect,
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
