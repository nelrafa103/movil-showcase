import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyectofinal/models/pokemon.dart';
import 'package:proyectofinal/themes/pokemons_types.dart';

class ExpasionWidget extends StatefulWidget {
  final Pokemon pokemon;

  const ExpasionWidget({super.key, required this.pokemon});
  @override
  State<StatefulWidget> createState() {
    return _ExpasionWidget();
  }
}

class _ExpasionWidget extends State<ExpasionWidget> {
  bool isExpan = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          isExpan = !isExpan;
        });
      },
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return const ListTile(
              title: Text('Movements'),
            );
          },
          body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (var item in widget.pokemon.moves)
                  Container(
                    padding: const EdgeInsets.all(9),
                    width: double.infinity,
                    child: Card(
                        color: customColors[widget.pokemon.types[0].type.name]![
                            'color']!,
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              item.move.name,
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ))),
                  )
              ]),
          isExpanded: isExpan,
        ),
      ],
    );
  }
}
