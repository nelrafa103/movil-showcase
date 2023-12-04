import 'dart:convert';

class PokemonIds {
  Data data;

  PokemonIds({
    required this.data,
  });

  factory PokemonIds.fromRawJson(String str) =>
      PokemonIds.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PokemonIds.fromJson(Map<String, dynamic> json) => PokemonIds(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Pokemons pokemons;

  Data({
    required this.pokemons,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pokemons: Pokemons.fromJson(json["pokemons"]),
      );

  Map<String, dynamic> toJson() => {
        "pokemons": pokemons.toJson(),
      };
}

class Pokemons {
  List<Result> results;

  Pokemons({
    required this.results,
  });

  factory Pokemons.fromRawJson(String str) =>
      Pokemons.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pokemons.fromJson(Map<String, dynamic> json) => Pokemons(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  int id;

  Result({
    required this.id,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
