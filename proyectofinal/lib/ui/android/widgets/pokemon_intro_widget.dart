import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyectofinal/models/pokemon.dart';

class PokemonIntroWidget extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonIntroWidget({super.key, required this.pokemon});
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 120, // Establece la altura máxima que desees
        maxWidth: double.infinity, // O ajusta el ancho máximo si es necesario
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          FractionalTranslation(
            translation: const Offset(0, -0.6), // Ajusta la posición vertical
            child: SizedBox(
              width: 250, // Ajusta el ancho de la imagen
              height: 250, // Ajusta el alto de la imagen
              child: Transform.scale(
                  scale: 1.5,
                  child: CachedNetworkImage(
                      progressIndicatorBuilder: (context, url, progress) =>
                          const Center(child: CircularProgressIndicator()),
                      imageUrl: pokemon
                          .sprites.other!.officialArtwork.frontDefault!)),
            ),
          ),
          FractionalTranslation(
            translation: const Offset(0, 0.5), // Ajusta la posición vertical
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                pokemon.name[0].toUpperCase() + pokemon.name.substring(1),
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 38,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
