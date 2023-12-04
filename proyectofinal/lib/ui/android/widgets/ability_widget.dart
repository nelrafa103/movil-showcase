import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyectofinal/models/ability.dart';
import 'package:proyectofinal/shared/pokemon.dart';

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
                      Text(
                        '#${widget.ability.id.toString()}',
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.ability.name[0].toUpperCase() +
                                widget.ability.name.substring(1),
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: fontSizes(),
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
                      padding: const EdgeInsets.all(9.0),
                      child: Text(
                        widget.ability.effectEntries[1].shortEffect,
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
