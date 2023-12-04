import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectofinal/models/abilities.dart';
import 'package:proyectofinal/models/ability.dart';
import 'package:proyectofinal/states/abilities_state.dart';

class AbilitiesCubit extends Cubit<AbilitiesState> {
  AbilitiesCubit() : super(AbilitiesInitial());
  static int _limit = 20;
  static int _offset = 0;
  List<Ability> _list = [];
  final dio = Dio();

  Future<dynamic> _fetch(int limit, int offset) async {
    try {
      String url =
          "https://pokeapi.co/api/v2/ability?limit=${limit}&offset=${offset}";

      final response1 = await dio.get(url);
      final results1 = Abilities.fromJson(response1.data);
      final future = results1.results.map((element) async {
        var response2 = await dio.get(element.url);
        var ability = Ability.fromJson(response2.data);
        return ability;
      });

      final results2 = await Future.wait(future);
      return results2;
    } catch (e) {
      // print(e.toString());
      return e.toString();
    }
  }

  void fetch() async {
    emit(AbilitiesLoading());
    try {
      _list.clear();
      _list.addAll(await _fetch(_limit, _offset));
      _offset += 20;
      emit(PopulatedAbilities(abilities: _list));
    } catch (e) {
      emit(AbilitiesError(e.toString()));
    }
  }

  void addMore() async {
    emit(AbilitiesLoading());
    try {
      _list.addAll(await _fetch(_limit, _offset));
      _offset += 20;
      emit(PopulatedAbilities(abilities: _list));
    } catch (e) {
      emit(AbilitiesError(e.toString()));
    }
  }

  fetchSpecific(String url) async {
    emit(AbilitiesLoading());
    _list.clear();
    try {
      final response1 = await dio.get(url);
      var ability = Ability.fromJson(response1.data);
      _list.add(ability);
      emit(PopulatedAbilities(abilities: _list));
    } catch (e) {
      emit(AbilitiesError(e.toString()));
    }
  }
}
