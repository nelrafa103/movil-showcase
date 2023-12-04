import 'package:proyectofinal/models/pokemon.dart';

abstract class PokemonsState {}

class PokemonsInitial extends PokemonsState {}

class PokemonsLoading extends PokemonsState {}

class PokemonsError extends PokemonsState {
  final String message;

  PokemonsError(this.message);
}

class PopulatedPokemons extends PokemonsState {
  final List<Pokemon> pokemons;
  bool isfiltered = false;

  PopulatedPokemons({required this.pokemons});

  void add(Pokemon pokemon) {
    pokemons.add(pokemon);
  }

  void setisfiltered() {
    this.isfiltered = !isfiltered;
  }
}
