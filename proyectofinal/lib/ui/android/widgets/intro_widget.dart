import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 130.0,
      stretch: true,
      floating: true,
      pinned: true,
      backgroundColor: Colors.white60,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          'images/AppBarBG.png',
          fit: BoxFit.cover,
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'icon/pokeball_outline.svg',
              height: 30,
              color: Colors.black54,
            ),
            Text(
              'Mi Pokedex',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                color: Colors.black54,
                fontSize: 16,
              ),
            ),
          ],
        ),
        stretchModes: const <StretchMode>[
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
          StretchMode.fadeTitle,
        ],
      ),
      actions: [
        Padding(
            padding: const EdgeInsets.all(18),
            child: IconButton(
                onPressed: () {
                  //Mostrar listado de pokemones favoritos
                },
                icon: const Icon(
                  Icons.favorite,
                  size: 24,
                  color: Colors.black54,
                ))
            /* icon: isFav
                  ? const Icon(
                      Icons.favorite,
                      size: 24,
                      color: Colors.black54,
                    )
                  : const Icon(
                      Icons.favorite_border,
                      size: 24,
                      color: Colors.black54,
                    )), */
            ),
      ],
    );
  }
}
