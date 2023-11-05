import 'dart:convert';

import 'package:proyectofinal/models/pokemon.dart';

abstract class PokemonState {}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonLoaded extends PokemonState {
 final Pokemon pokemon;

  PokemonLoaded({required this.pokemon});

}
