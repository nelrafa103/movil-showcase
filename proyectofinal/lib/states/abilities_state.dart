import 'dart:convert';

import 'package:proyectofinal/models/ability.dart';

abstract class AbilitiesState {}

class AbilitiesInitial extends AbilitiesState {}

class AbilitiesLoading extends AbilitiesState {}

class PopulatedAbilities extends AbilitiesState {
  List<Ability> abilities = [];
  PopulatedAbilities({required this.abilities});
}

class AbilitiesError extends AbilitiesState {
  final String message;

  AbilitiesError(this.message);
}
