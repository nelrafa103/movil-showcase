import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectofinal/models/pokemon.dart';
import 'package:proyectofinal/states/list_state.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class ListCubit extends Cubit<ListState> {
  ListCubit() : super(ListInitial());
  var dio = Dio();
  List<Pokemon> list = [];

  void fetch() async {
    emit(ListLoading());
    try {
      String url = "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0";
      var response = await dio.get(url);
      var data = ListLoaded.fromJson(response.data);
      int index = 0;
      data.results.forEach((element) async {
        var response2 = await dio.get(element.url);
        var pokemon = Pokemon.fromJson(response2.data);
        list.add(pokemon);
      });

      if (state is PopulatedList) {
        //  print(list.length);
      }
      emit(PopulatedList(pokemons: list));
    } catch (e) {
      emit(ListError(e.toString()));
    }
  }

  void addMore() async {
    //limit, offset
    try {
      String url = "https://pokeapi.co/api/v2/pokemon?limit=40&offset=20";
      var response = await dio.get(url);
      var data = ListLoaded.fromJson(response.data);
      int index = 0;
      data.results.forEach((element) async {
        var response2 = await dio.get(element.url);
        var pokemon = Pokemon.fromJson(response2.data);
        // print(pokemon.name);
        list.add(pokemon);
      });

      print(list.length);
      emit(RepopulatedList(pokemons: list));
    } catch (e) {
      emit(ListError(e.toString()));
    }
  }


  void filter_by_name(String nombre) async {
    try {
      String url = "https://pokeapi.co/api/v2/pokemon?limit=40&offset=20";
      var response = await dio.get(url);
      var data = ListLoaded.fromJson(response.data);
      int index = 0;
      data.results.forEach((element) async {
        var response2 = await dio.get(element.url);
        var pokemon = Pokemon.fromJson(response2.data);
        // print(pokemon.name);
        list.add(pokemon);
      });

      print(list.length);
      emit(RepopulatedList(pokemons: list));
    } catch (e) {
      emit(ListError(e.toString()));
    }
  }
  /* Por aqui debe haber algun metodo para que
   cada vez que se acerque al final de la lista alga un fecth de mas pokemons */
}
