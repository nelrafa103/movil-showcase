import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectofinal/states/cubit/pokemons_cubit.dart';
import 'package:proyectofinal/states/pokemons_state.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonsCubit, PokemonsState>(
        builder: ((context, state) {
      return CupertinoSearchTextField(
        onChanged: (String value) {},
        onSubmitted: (String value) {
          if (state is PopulatedPokemons) {
            BlocProvider.of<PokemonsCubit>(context).filterByName(value);
          }
        },
      );
    }));
  }
}
