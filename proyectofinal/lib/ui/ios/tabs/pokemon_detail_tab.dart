import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectofinal/states/cubit/pokemon_cubit.dart';
import 'package:proyectofinal/states/pokemon_state.dart';
import 'package:proyectofinal/ui/ios/widgets/details_widget.dart';
import 'package:proyectofinal/ui/ios/widgets/movements_widget.dart';

class PokemonDetailTab extends StatefulWidget {
  const PokemonDetailTab({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PokemonDetailTab();
  }
}

class _PokemonDetailTab extends State<PokemonDetailTab> {
  Map<String, String> views = {"home": "Ejemplo", "moves": "Ejempl02"};
  String def = "home";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: CupertinoSlidingSegmentedControl<String>(
          backgroundColor: CupertinoColors.systemGrey2,
          groupValue: def,
          onValueChanged: (String? value) {
            setState(() {
              def = value!;
            });
          },
          children: const <String, Widget>{
            "home": Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Home',
                style: TextStyle(color: CupertinoColors.black),
              ),
            ),
            "moves": Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Moves',
                style: TextStyle(color: CupertinoColors.black),
              ),
            ),
          },
        ),
        leading: CupertinoNavigationBarBackButton(
            onPressed: () => {Navigator.of(context).pushNamed("/")}),
      ),
      child: BlocBuilder<PokemonCubit, PokemonState>(builder: (context, state) {
        if (state is PokemonLoaded) {
          if (def == "home") {
            return DetailsWidget(pokemon: state.pokemon);
          } else if (def == "moves") {
            return MovementsWidget(pokemon: state.pokemon);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
