import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class pokemon_item_shimmer extends StatelessWidget {
  const pokemon_item_shimmer({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double paddingPerSize = screenHeight > 600 ? 4.0 : 8.0;
    double pokemonSize = screenHeight > 600 ? 50 : 70;
    return Shimmer.fromColors(
        baseColor: Colors.black54,
        highlightColor: Colors.white70,
        child: SingleChildScrollView(
            padding: EdgeInsets.all(paddingPerSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => {},
                        icon: const Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: Colors.white,
                        )),
                    Text('#',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        )),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Foto del pokemon:
                    Container(
                      width: pokemonSize,
                      height: pokemonSize,
                      child: Center(
                          child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Transform.scale(
                            scale: 1.3,
                            child: CachedNetworkImage(
                              imageUrl: "",
                              fit: BoxFit.fill,
                              filterQuality: FilterQuality.none,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            )),
                      )),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FilledButton(
                          onPressed: null,
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.all(12.0),
                          ),
                          child: Text(
                            "",
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          "",
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
            )));
  }
}
