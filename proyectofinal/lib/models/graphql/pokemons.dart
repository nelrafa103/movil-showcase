class PokemonGraphql {
  PokemonGraphql({
    required this.data,
  });
  late final Data data;

  PokemonGraphql.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.pokemons,
  });
  late final Pokemons pokemons;

  Data.fromJson(Map<String, dynamic> json) {
    pokemons = Pokemons.fromJson(json['pokemons']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pokemons'] = pokemons.toJson();
    return _data;
  }
}

class Pokemons {
  Pokemons({
    required this.results,
  });
  late final List<Results> results;

  Pokemons.fromJson(Map<String, dynamic> json) {
    results =
        List.from(json['results']).map((e) => Results.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['results'] = results.map((e) => e.toJson()).toList();
    print(_data);
    return _data;
  }
}

class Results {
  Results({
    required this.name,
  });
  late final String name;

  Results.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    //print(name);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    return _data;
  }
}
