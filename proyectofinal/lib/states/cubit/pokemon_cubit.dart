import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectofinal/models/pokemon.dart';
import 'package:proyectofinal/states/pokemon_state.dart';

class PokemonCubit extends Cubit<PokemonState> {
  PokemonCubit() : super(PokemonInitial());

  //void selectPokemon(Pokemon pokemon) => emit(pokemon);

  //void unselectPokemon() => emit(null);

  void providePokemon(Pokemon pokemon) {
    emit(PokemonLoaded(pokemon: pokemon));
  }
}
