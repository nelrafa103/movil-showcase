import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:proyectofinal/models/pokemon.dart';
import 'package:proyectofinal/models/types.dart';
import 'package:proyectofinal/sqflite.dart';
import 'package:proyectofinal/states/list_state.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

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
    emit(ListLoading());
    try {
      String url =
          "https://pokeapi.co/api/v2/pokemon?limit=${limit}&offset=${offset}";
      var response = await dio.get(url);
      var data = ListLoaded.fromJson(response.data);
      int index = 0;
      list.sort((a, b) => a.id.compareTo(b.id));
      var box = await Hive.openBox('pokemons');

      final future = data.results.map((element) async {
        var response2 = await dio.get(element.url);
        var pokemon = Pokemon.fromJson(response2.data);
        return pokemon;
      });
      final results = await Future.wait(future);
      list.addAll(results);

      if (state is PopulatedList) {
        //  print(list.length);
      }

      list.forEach((element) {
        //    print(element.name);
      });
      /* Buscar letra por letra a ver si se encuentra algo */
      emit(PopulatedList(pokemons: list));
      limit += 20;
      offset += 20;
    } catch (e) {
      emit(ListError(e.toString()));
    }
  }

  void addMore() async {
    //limit, offset
    try {
      String url =
          "https://pokeapi.co/api/v2/pokemon?limit=${limit}&offset=${offset}";
      var response = await dio.get(url);
      var data = ListLoaded.fromJson(response.data);
      int index = 0;
      final future = data.results.map((element) async {
        var response2 = await dio.get(element.url);
        var pokemon = Pokemon.fromJson(response2.data);
        //    print(pokemon.name);
        return pokemon;
      });
      final results = await Future.wait(future);
      list.addAll(results);
      emit(RepopulatedList(pokemons: list));
      limit += 20;
      offset += 20;
    } catch (e) {
      print(e.toString());
      emit(ListError(e.toString()));
    }
  }

  void filter_by_name(String nombre) async {
    try {
      list = [];
      List<String> name_list = DbInitializer.search(nombre);
      if (name_list.length > 0) {
        final future = name_list.map((element) async {
          print(element + "elemento");
          String url = "https://pokeapi.co/api/v2/pokemon/${element}";
          print(url);
          var response = await dio.get(url);
          var data = Pokemon.fromJson(response.data);
          print(data.name);
          return data;
        });
        final results = await Future.wait(future);
        list.addAll(results);
        emit(RepopulatedList(pokemons: list));
      } else {
        String url = "https://pokeapi.co/api/v2/pokemon/${nombre}";
        var response = await dio.get(url);
        var data = Pokemon.fromJson(response.data);
        int index = 0;

        list.add(data);
        emit(RepopulatedList(pokemons: list));
      }
    } catch (e) {
      emit(ListError(e.toString()));
    }
  }

  void filter_by_type(String type) async {
    list = [];
    try {
      print(type);
      String url = "https://pokeapi.co/api/v2/type/${type}";
      var response = await dio.get(url);
      var data = Types.fromJson(response.data);

      print(data.pokemon.length);
      final future = data.pokemon.map((e) async {
        var response2 = await dio.get(e.pokemon.url);
        var pokemon = Pokemon.fromJson(response2.data);
        print('${pokemon.name} + ' ' ${e.pokemon.url}');
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
