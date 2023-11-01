import 'dart:convert';

abstract class MovesState {}

class MovesInitial extends MovesState {}

class MovesLoading extends MovesState {}

// To parse this JSON data, do
//
//     final moves = movesFromJson(jsonString);

Moves movesFromJson(String str) => Moves.fromJson(json.decode(str));

String movesToJson(Moves data) => json.encode(data.toJson());

class Moves extends MovesState {
  int count;
  String next;
  dynamic previous;
  List<Result> results;

  Moves({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory Moves.fromJson(Map<String, dynamic> json) => Moves(
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
