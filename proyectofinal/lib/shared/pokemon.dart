import 'package:proyectofinal/models/param.dart';
import 'package:proyectofinal/models/pokemon.dart';
import 'package:proyectofinal/models/pokemon_chain.dart';
import 'package:proyectofinal/models/pokemon_evolution.dart';
import 'package:dio/dio.dart';
import 'package:proyectofinal/themes/pokemons_types.dart';

final dio = Dio();
String typesToString(List<Type> types) {
  String result = "";
  for (int i = 0; i < types.length; i++) {
    if (i + 1 != types.length) {
      result += '${types[i].type.name} - ';
    } else {
      result += types[i].type.name;
    }
  }
  return result;
}

Future<PokemonChain> fetchEvolution(String type) async {
  String url = "https://pokeapi.co/api/v2/pokemon-species/${type}";
  var response = await dio.get(url);
  var data = Welcome.fromJson(response.data);
  var response2 = await dio.get(data.evolutionChain.url);
  var data2 = PokemonChain.fromJson(response2.data);

  return data2;
}

Future<List<Pokemon>> fetchPokemon(List<String> names) async {
  final future = names.map((name) async {
    var response2 = await dio.get("https://pokeapi.co/api/v2/pokemon/${name}");
    var pokemon = Pokemon.fromJson(response2.data);
    return pokemon;
  });
  final results = await Future.wait(future);
  return results;
}

List<Param> paramList = [
  Param(
    id: 12,
    title: "Grass",
    url: "images/bulbassur.png",
    color: Grass,
  ),
  Param(id: 10, title: "Fire", url: "images/chamander.png", color: Fire),
  Param(id: 11, title: "Water", url: "images/squirtle.png", color: Water),
  Param(id: 7, title: "Bug", url: "images/caterpie.png", color: Bug),
  Param(id: 1, title: "Normal", url: "images/rattata.png", color: Normal),
  Param(id: 3, title: "Flying", url: "images/pidgey.png", color: Flying),
  Param(id: 13, title: "Electric", url: "images/pikachu.png", color: Electric),
  Param(id: 2, title: "Fighting", url: "images/mankey.png", color: Fighting),
  Param(id: 18, title: "Fairy", url: "images/cleafairy.png", color: Fairy),
  Param(id: 9, title: "Steel", url: "images/beldum.png", color: Steel),
  Param(id: 15, title: "Ice", url: "images/snover.png", color: Ice),
  Param(id: 4, title: "Poison", url: "images/nidoran-f.png", color: Poison),
  Param(id: 5, title: "Ground", url: "images/diglett.png", color: Ground),
  Param(id: 14, title: "Psychic", url: "images/abra.png", color: Psychic),
  Param(id: 6, title: "Rock", url: "images/geodude.png", color: Rock),
];
