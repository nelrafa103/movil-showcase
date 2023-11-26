import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyectofinal/models/param.dart';

class FilterWidget extends StatefulWidget {
  final double paddingPerSize;
  final double pokemonSize;
  final Color color;
  final Param param;
  const FilterWidget(
      {super.key,
      required this.param,
      required this.paddingPerSize,
      required this.pokemonSize,
      required this.color});
  @override
  State<StatefulWidget> createState() {
    return _FilterWidget();
  }
}

class _FilterWidget extends State<FilterWidget> {
  @override
  Widget build(BuildContext context) {
    String types = '';
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(widget.param.url),
              fit: BoxFit.cover,
              alignment: Alignment.centerRight,
            ),
            gradient: LinearGradient(
                colors: [widget.color, widget.color],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)),
        child: Padding(
          padding: EdgeInsets.only(
              left: 0,
              right: 0,
              top: widget.paddingPerSize,
              bottom: widget.paddingPerSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FilledButton(
                        onPressed: null,
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.all(12.0),
                        ),
                        child: Text(
                          widget.param.title,
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Text(
                        types,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
