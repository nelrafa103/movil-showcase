import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectofinal/models/pokemon.dart';

class PokemonCubit extends Cubit<Pokemon?> {
  PokemonCubit() : super(null);


  void selectPokemon(Pokemon pokemon) => emit(pokemon);

  void unselectPokemon() => emit(null);


}
