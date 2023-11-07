import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
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
    try {
      list.clear();
      List<String> name_list = DbInitializer.search(nombre);
      if (name_list.isNotEmpty) {
        final future = name_list.map((element) async {
          String url = "https://pokeapi.co/api/v2/pokemon/${element}";
          var response = await dio.get(url);
          var data = Pokemon.fromJson(response.data);
          return data;
        });
        final results = await Future.wait(future);
        results.removeWhere((element) => list.contains(element));
        list.addAll(results);
        emit(RepopulatedList(pokemons: list));
      } else {
        String url = "https://pokeapi.co/api/v2/pokemon/${nombre}";
        var response = await dio.get(url);
        var data = Pokemon.fromJson(response.data);

        list.add(data);
        emit(RepopulatedList(pokemons: list));
      }
    } catch (e) {
      emit(ListError(e.toString()));
    }
  }

  void filter_by_type(String type) async {
    list = [];
    String url = "https://pokeapi.co/api/v2/type/${type}";

    try {
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
    } catch (e) {
      emit(ListError(e.toString()));
    }
  }
  //void _busqueda(String nombre) {}
  /* Por aqui debe haber algun metodo para que
   cada vez que se acerque al final de la lista alga un fecth de mas pokemons */
}
