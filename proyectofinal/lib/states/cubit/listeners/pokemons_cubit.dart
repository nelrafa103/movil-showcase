import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:proyectofinal/graphql.dart';
import 'package:proyectofinal/models/graphql/pokemons.dart';
import 'package:proyectofinal/models/graphql/queries.dart';
import 'package:proyectofinal/models/pokemon.dart';
import 'package:proyectofinal/models/types.dart';
import 'package:proyectofinal/sqflite.dart';
import 'package:proyectofinal/states/list_state.dart';

class ListCubit extends Cubit<ListState> {
  ListCubit() : super(ListInitial());
  var dio = Dio();
  List<Pokemon> list = [];
  static int limit = 20;
  static int offset = 0;

  /*
   Aqui se podria reciclar un poco de codigo 
  */
  void fetch() async {
    list.clear();
    offset = 0;
    emit(ListLoading());
    try {
      String url =
          "https://pokeapi.co/api/v2/pokemon?limit=${limit}&offset=${offset}";
      var response = await dio.get(url);
      var data = ListLoaded.fromJson(response.data);
      final future = data.results.map((element) async {
        var response2 = await dio.get(element.url);
        var pokemon = Pokemon.fromJson(response2.data);
        return pokemon;
      });
      final results = await Future.wait(future);

      list.addAll(results);
      offset += 20;
      emit(PopulatedList(pokemons: list));
    } catch (e) {
      emit(ListError(e.toString()));
    }
  }

  Future<bool> addMore() async {
    try {
      String url =
          "https://pokeapi.co/api/v2/pokemon?limit=${limit}&offset=${offset}";
      var response = await dio.get(url);
      var data = ListLoaded.fromJson(response.data);
      final future = data.results.map((element) async {
        var response2 = await dio.get(element.url);
        var pokemon = Pokemon.fromJson(response2.data);
        return pokemon;
      });
      final results = await Future.wait(future);
      results.removeWhere((element) => list.contains(element));
      list.addAll(results);
      offset += 20;
      emit(RepopulatedList(pokemons: list));
      return true;
    } catch (e) {
      emit(ListError(e.toString()));
      return false;
    }
  }

  void filter_by_name(String nombre) async {
    List<String> name_list = [];

    try {
      final grapql_response =
          await dio.post("https://graphql-pokeapi.graphcdn.app/", data: {
        'query': names,
        'variables': {'limit': 900, 'offset': 0}
      });
      PokemonGraphql pokemons_names =
          PokemonGraphql.fromJson(grapql_response.data);

      if (grapql_response.statusCode != 200) {
        emit(ListError(grapql_response.statusMessage.toString()));
      } else {
        pokemons_names.data.pokemons.results.forEach((element) {
          if (element.name.startsWith(nombre) && nombre.isNotEmpty) {
            name_list.add(element.name);
          }
        });
      }

      if (name_list.isNotEmpty) {
        list.clear();
        final searching = name_list.map((nombre) async {
          var response2 =
              await dio.get("https://pokeapi.co/api/v2/pokemon/${nombre}");
          var pokemon = Pokemon.fromJson(response2.data);
          return pokemon;
        });

        final results = await Future.wait(searching);
        list.addAll(results);
        emit(RepopulatedList(pokemons: list));
      }
    } catch (e) {
      emit(ListError(e.toString()));
    }
  }

  Future<List<Pokemon>> filter_by_type(int type) async {
    list = [];
    String url = "https://pokeapi.co/api/v2/type/${type}";

    try {
      emit(ListLoading());
      var response = await dio.get(url);
      var data = Types.fromJson(response.data);

      final future = data.pokemon.map((e) async {
        var response2 = await dio.get(e.pokemon.url);
        var pokemon = Pokemon.fromJson(response2.data);
        return pokemon;
      });
      final results = await Future.wait(future);
      list.addAll(results);
      emit(RepopulatedList(pokemons: list));
      return list;
    } catch (e) {
      emit(ListError(e.toString()));
      return list;
    }
  }
}
