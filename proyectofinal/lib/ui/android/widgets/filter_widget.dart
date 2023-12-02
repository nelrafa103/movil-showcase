import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [widget.color, widget.color.withOpacity(0.5)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)),
        child: Padding(
          padding: EdgeInsets.only(
              left: 0,
              right: 0,
              top: widget.paddingPerSize,
              bottom: widget.paddingPerSize),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: SvgPicture.asset(
                  widget.param.icon,
                  height: 100,
                  ),
                ),

                Expanded(
                  child: SizedBox(
                    child: FilledButton(
                      onPressed: null,
                      style: FilledButton.styleFrom(
                        padding: EdgeInsets.all(7),
                      ),
                      child: Text(
                        widget.param.title,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
