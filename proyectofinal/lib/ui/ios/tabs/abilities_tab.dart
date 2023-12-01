import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectofinal/states/abilities_state.dart';
import 'package:proyectofinal/states/cubit/abilities_cubit.dart';
import 'package:proyectofinal/ui/android/widgets/ability_widget.dart';

class AbilitiesTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AbilitiesTab();
  }
}

class _AbilitiesTab extends State<AbilitiesTab> {
  late ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbilitiesCubit, AbilitiesState>(
      builder: (context, state) {
        if (state is PopulatedAbilities) {
          return GridView.builder(
              controller: controller,
              itemCount: state.abilities.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                childAspectRatio: 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                return AbilityWidget(ability: state.abilities[index]);
              });
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
