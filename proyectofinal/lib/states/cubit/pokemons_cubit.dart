import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectofinal/hive.dart';
import 'package:proyectofinal/models/graphql/pokemons.dart';
import 'package:proyectofinal/models/graphql/pokemons_ids.dart';
import 'package:proyectofinal/models/graphql/queries.dart';
import 'package:proyectofinal/models/list.dart';
import 'package:proyectofinal/models/pokemon.dart';
import 'package:proyectofinal/models/types.dart';
import 'package:proyectofinal/states/pokemons_state.dart';
import 'package:string_validator/string_validator.dart';

class PokemonsCubit extends Cubit<PokemonsState> {
  PokemonsCubit() : super(PokemonsInitial());
  var dio = Dio();
  List<Pokemon> _list = [];
  static const int _limit = 20;
  static int _offset = 0;

  void fetch() async {
    _list.clear();
    emit(PokemonsLoading());
    try {
      _list.addAll(await _fetch(_limit, 0));
      emit(PopulatedPokemons(pokemons: _list));
      _offset += 20;
    } catch (e) {
      emit(PokemonsError(e.toString()));
    }
  }

  void addMore() async {
    try {
      _list.addAll(await _fetch(_limit, _offset));
      emit(PopulatedPokemons(pokemons: _list));
      _offset += 20;
    } catch (e) {
      emit(PokemonsError(e.toString()));
    }
  }

  void filterByName(String nombre) async {
    List<String> nameList = [];
    List<int> idsList = [];
    if (nombre.isEmpty) {
      _fetch(_limit, _offset);
      return;
    }
    if (isNumeric(nombre)) {
      final grapqlResponse =
          await dio.post("https://graphql-pokeapi.graphcdn.app/", data: {
        'query': ids,
        'variables': {'limit': 900, 'offset': 0}
      });

      PokemonIds pokemonsIds = PokemonIds.fromJson(grapqlResponse.data);

      if (grapqlResponse.statusCode != 200) {
        emit(PokemonsError(grapqlResponse.statusMessage.toString()));
      } else {
        for (var element in pokemonsIds.data.pokemons.results) {
          String idToString = element.id.toString();
          if (idToString.contains(nombre) && nombre.isNotEmpty) {
            idsList.add(element.id);
          }
        }
      }

      if (idsList.isNotEmpty) {
        _list.clear();
        final searching = idsList.map((id) async {
          var response2 =
              await dio.get("https://pokeapi.co/api/v2/pokemon/${id}");
          var pokemon = Pokemon.fromJson(response2.data);
          return pokemon;
        });

        final results = await Future.wait(searching);
        _list.addAll(results);
        PopulatedPokemons _pokemons = PopulatedPokemons(pokemons: _list);
        _pokemons.setisfiltered();
        emit(_pokemons);
      }
    } else {
      try {
        final grapqlResponse =
            await dio.post("https://graphql-pokeapi.graphcdn.app/", data: {
          'query': names,
          'variables': {'limit': 900, 'offset': 0}
        });
        PokemonGraphql pokemonsNames =
            PokemonGraphql.fromJson(grapqlResponse.data);

        if (grapqlResponse.statusCode != 200) {
          emit(PokemonsError(grapqlResponse.statusMessage.toString()));
        } else {
          for (var element in pokemonsNames.data.pokemons.results) {
            if (element.name.startsWith(nombre.toLowerCase()) &&
                nombre.isNotEmpty) {
              nameList.add(element.name);
              print(element.name);
            }
          }
        }

        if (nameList.isNotEmpty) {
          _list.clear();
          final searching = nameList.map((nombre) async {
            var response2 =
                await dio.get("https://pokeapi.co/api/v2/pokemon/${nombre}");
            var pokemon = Pokemon.fromJson(response2.data);
            return pokemon;
          });
          final results = await Future.wait(searching);
          _list.addAll(results);
          PopulatedPokemons _pokemons = PopulatedPokemons(pokemons: _list);
          _pokemons.setisfiltered();
          emit(_pokemons);
        } else {
          emit(PopulatedPokemons(pokemons: []));
        }
      } catch (e) {
        emit(PokemonsError(e.toString()));
      }
    }
  }

  Future<List<Pokemon>> filterByType(int type) async {
    _list = [];
    String url = "https://pokeapi.co/api/v2/type/${type}";
    final dynamic results;
    try {
      emit(PokemonsLoading());
      switch (type) {
        case 0:
          results = await _findFavs();
        default:
          var response = await dio.get(url);
          var data = Types.fromJson(response.data);

          final future = data.pokemon.map((e) async {
            var response2 = await dio.get(e.pokemon.url);
            var pokemon = Pokemon.fromJson(response2.data);
            return pokemon;
          });
          results = await Future.wait(future);
      }

      _list.addAll(results);
      PopulatedPokemons _pokemons = PopulatedPokemons(pokemons: _list);
      _pokemons.setisfiltered();
      emit(_pokemons);

      return _list;
    } catch (e) {
      emit(PokemonsError(e.toString()));
      return _list;
    }
  }

  Future<dynamic> _fetch(int limit, int offset) async {
    try {
      String url =
          "https://pokeapi.co/api/v2/pokemon?limit=${limit}&offset=${offset}";
      var response = await dio.get(url);
      var data = PokeList.fromJson(response.data);
      final future = data.results.map((element) async {
        var response2 = await dio.get(element.url);
        var pokemon = Pokemon.fromJson(response2.data);
        return pokemon;
      });
      final results = await Future.wait(future);
      return results;
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> _findFavs() async {
    try {
      List<String> nameList = DbInitializer.getAllFavs();
      final future = nameList.map((element) async {
        var response2 =
            await dio.get("https://pokeapi.co/api/v2/pokemon/${element}");
        var pokemon = Pokemon.fromJson(response2.data);
        return pokemon;
      });
      final results = await Future.wait(future);

      return results;
    } catch (e) {
      return e.toString();
    }
  }

  void addFilter() {
    // PopulatedPokemons _pokemons = PopulatedPokemons(pokemons: _list);
    //_pokemons.setisfiltered();
    emit(PokemonsLoading());
  }
}
