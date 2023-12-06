import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectofinal/states/cubit/abilities_cubit.dart';
import 'package:proyectofinal/ui/android/widgets/ability_widget.dart';
import 'package:proyectofinal/ui/android/widgets/bottom_bar_widget.dart';

import '../../../states/abilities_state.dart';

class AbilitiesScreen extends StatefulWidget {
  const AbilitiesScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AbilitiesScreen();
  }
}

class _AbilitiesScreen extends State<AbilitiesScreen> {
  late ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.hasClients) {
        if (controller.position.maxScrollExtent == controller.offset) {
          BlocProvider.of<AbilitiesCubit>(context).addMore();
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AbilitiesCubit, AbilitiesState>(
          builder: (context, state) {
            if (state is PopulatedAbilities) {
              return GridView.builder(
                  controller: controller,
                  itemCount: state.abilities.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    childAspectRatio: 4.4,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return AbilityWidget(ability: state.abilities[index]);
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
