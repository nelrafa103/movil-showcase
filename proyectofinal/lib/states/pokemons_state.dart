import 'dart:convert';

import 'package:proyectofinal/models/pokemon.dart';

abstract class PokemonsState {}

class PokemonsInitial extends PokemonsState {}

class PokemonsLoading extends PokemonsState {}

PokemonsLoaded PokemonsLoadedFromJson(String str) =>
    PokemonsLoaded.fromJson(json.decode(str));

String PokemonsLoadedToJson(PokemonsLoaded data) => json.encode(data.toJson());

class PokemonsLoaded extends PokemonsState {
  int count;
  String next;
  dynamic previous;
  List<Result> results;

  PokemonsLoaded({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory PokemonsLoaded.fromJson(Map<String, dynamic> json) => PokemonsLoaded(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  String name;
  String url;

  Result({
    required this.name,
    required this.url,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class PokemonsError extends PokemonsState {
  final String message;

  PokemonsError(this.message);
}

class PopulatedPokemons extends PokemonsState {
  final List<Pokemon> pokemons;

  PopulatedPokemons({required this.pokemons});

  void add(Pokemon pokemon) {
    pokemons.add(pokemon);
  }
}
