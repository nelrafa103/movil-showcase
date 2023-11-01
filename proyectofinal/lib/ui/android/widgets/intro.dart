import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class intro extends StatelessWidget {
  const intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      expandedHeight: 250,
      floating: false,
      pinned: true,
      backgroundColor: const Color.fromRGBO(193, 39, 45, 1),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Mi Pokedex',
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500, fontStyle: FontStyle.normal),
        ),
        background: Image.asset(
          'images/PokedexMainBg5.png',
          fit: BoxFit.cover,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border),
          color: Colors.white,
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.filter_alt_outlined),
          color: Colors.white,
          onPressed: () {},
        ),
      ],
    );
  }
}
