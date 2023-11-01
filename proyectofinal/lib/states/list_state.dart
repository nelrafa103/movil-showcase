import 'dart:convert';

import 'package:proyectofinal/models/pokemon.dart';

abstract class ListState {}

class ListInitial extends ListState {}

class ListLoading extends ListState {}

ListLoaded ListLoadedFromJson(String str) =>
    ListLoaded.fromJson(json.decode(str));

String ListLoadedToJson(ListLoaded data) => json.encode(data.toJson());

class ListLoaded extends ListState {
  int count;
  String next;
  dynamic previous;
  List<Result> results;

  ListLoaded({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory ListLoaded.fromJson(Map<String, dynamic> json) => ListLoaded(
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

class ListError extends ListState {
  final String message;

  ListError(this.message);
}

class PopulatedList extends ListState {
  final List<Pokemon> pokemons;

  PopulatedList({required this.pokemons});

  void add(Pokemon pokemon) {
    pokemons.add(pokemon);
  }
}

class RepopulatedList extends ListState {
  final List<Pokemon> pokemons;

  RepopulatedList({required this.pokemons});


}
