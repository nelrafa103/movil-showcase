import 'package:flutter/material.dart';
import 'package:proyectofinal/models/param.dart';
import 'package:proyectofinal/themes/pokemons_types.dart';
import 'package:proyectofinal/ui/android/widgets/bottom_bar.dart';
import 'package:proyectofinal/ui/android/widgets/param_item.dart';

class seach_screen extends StatefulWidget {
  const seach_screen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _seach_screen();
  }
}

class _seach_screen extends State<seach_screen> {
  final TextEditingController _searchController = TextEditingController();

  List<Param> param_list = [
    Param(title: "Grass", url: "images/bulbassur.png", color: Grass),
    Param(title: "Fire", url: "images/chamander.png", color: Fire),
    Param(title: "Water", url: "images/squirtle.png", color: Water),
    Param(title: "Bug", url: "images/caterpie.png", color: Bug),
    Param(title: "Normal", url: "images/rattata.png", color: Normal),
    Param(title: "Flying", url: "images/pidgey.png", color: Flying),
    Param(title: "Electric", url: "images/pikachu.png", color: Electric),
    Param(title: "Fighting", url: "images/mankey.png", color: Fighting),
    Param(title: "Fairy", url: "images/cleafairy.png", color: Fairy),
    Param(title: "Steel", url: "images/beldum.png", color: Steel),
    Param(title: "Ice", url: "images/snover.png", color: Ice),
  ];

  @override
  void initState() {
    // TODO: implement initState
    _searchController.addListener(() {
      /* Hacer una busqueda */
         

       // _searchController.selection.

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: SearchBar(
          controller: _searchController,
          hintText: "Buscar pokemon",
        ),
        title: const Text("Buscar"),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          childAspectRatio: 1.6,
        ),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          double screenHeight = MediaQuery.of(context).size.height;
          double paddingPerSize = screenHeight > 600 ? 4.0 : 8.0;
          double pokemonSize = screenHeight > 600 ? 50 : 70;

          return param_item(
              title: param_list[index].title,
              url: param_list[index].url,
              color: param_list[index].color,
              paddingPerSize: paddingPerSize,
              pokemonSize: pokemonSize);
        },
      ),
      bottomNavigationBar: const bottom_bar(),
    );
  }
}
