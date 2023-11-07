import 'package:hive/hive.dart';
part 'pokemon_dao.g.dart';

@HiveType(typeId: 1)
class PokemonDao {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String url;
  PokemonDao({required this.name, required this.id, required this.url});

  String get getName => name;
  int get getId => id;
  String get getUrl => url;

  set setName(String name) => name = name;
  set setId(int id) => id = id;
  set setUrl(String url) => url = url;
}
