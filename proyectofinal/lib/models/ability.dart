import 'dart:convert';

class Ability {
  List<EffectChange> effectChanges;
  List<AbilityEffectEntry> effectEntries;
  List<FlavorTextEntry> flavorTextEntries;
  Generation generation;
  int id;
  bool isMainSeries;
  String name;
  List<Name> names;
  List<Pokemon> pokemon;

  Ability({
    required this.effectChanges,
    required this.effectEntries,
    required this.flavorTextEntries,
    required this.generation,
    required this.id,
    required this.isMainSeries,
    required this.name,
    required this.names,
    required this.pokemon,
  });

  factory Ability.fromRawJson(String str) => Ability.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
        effectChanges: List<EffectChange>.from(
            json["effect_changes"].map((x) => EffectChange.fromJson(x))),
        effectEntries: List<AbilityEffectEntry>.from(
            json["effect_entries"].map((x) => AbilityEffectEntry.fromJson(x))),
        flavorTextEntries: List<FlavorTextEntry>.from(
            json["flavor_text_entries"]
                .map((x) => FlavorTextEntry.fromJson(x))),
        generation: Generation.fromJson(json["generation"]),
        id: json["id"],
        isMainSeries: json["is_main_series"],
        name: json["name"],
        names: List<Name>.from(json["names"].map((x) => Name.fromJson(x))),
        pokemon:
            List<Pokemon>.from(json["pokemon"].map((x) => Pokemon.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "effect_changes":
            List<dynamic>.from(effectChanges.map((x) => x.toJson())),
        "effect_entries":
            List<dynamic>.from(effectEntries.map((x) => x.toJson())),
        "flavor_text_entries":
            List<dynamic>.from(flavorTextEntries.map((x) => x.toJson())),
        "generation": generation.toJson(),
        "id": id,
        "is_main_series": isMainSeries,
        "name": name,
        "names": List<dynamic>.from(names.map((x) => x.toJson())),
        "pokemon": List<dynamic>.from(pokemon.map((x) => x.toJson())),
      };
}

class EffectChange {
  List<EffectChangeEffectEntry> effectEntries;
  Generation versionGroup;

  EffectChange({
    required this.effectEntries,
    required this.versionGroup,
  });

  factory EffectChange.fromRawJson(String str) =>
      EffectChange.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EffectChange.fromJson(Map<String, dynamic> json) => EffectChange(
        effectEntries: List<EffectChangeEffectEntry>.from(json["effect_entries"]
            .map((x) => EffectChangeEffectEntry.fromJson(x))),
        versionGroup: Generation.fromJson(json["version_group"]),
      );

  Map<String, dynamic> toJson() => {
        "effect_entries":
            List<dynamic>.from(effectEntries.map((x) => x.toJson())),
        "version_group": versionGroup.toJson(),
      };
}

class EffectChangeEffectEntry {
  String effect;
  Generation language;

  EffectChangeEffectEntry({
    required this.effect,
    required this.language,
  });

  factory EffectChangeEffectEntry.fromRawJson(String str) =>
      EffectChangeEffectEntry.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EffectChangeEffectEntry.fromJson(Map<String, dynamic> json) =>
      EffectChangeEffectEntry(
        effect: json["effect"],
        language: Generation.fromJson(json["language"]),
      );

  Map<String, dynamic> toJson() => {
        "effect": effect,
        "language": language.toJson(),
      };
}

class Generation {
  String name;
  String url;

  Generation({
    required this.name,
    required this.url,
  });

  factory Generation.fromRawJson(String str) =>
      Generation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Generation.fromJson(Map<String, dynamic> json) => Generation(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class AbilityEffectEntry {
  String effect;
  Generation language;
  String shortEffect;

  AbilityEffectEntry({
    required this.effect,
    required this.language,
    required this.shortEffect,
  });

  factory AbilityEffectEntry.fromRawJson(String str) =>
      AbilityEffectEntry.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AbilityEffectEntry.fromJson(Map<String, dynamic> json) =>
      AbilityEffectEntry(
        effect: json["effect"],
        language: Generation.fromJson(json["language"]),
        shortEffect: json["short_effect"],
      );

  Map<String, dynamic> toJson() => {
        "effect": effect,
        "language": language.toJson(),
        "short_effect": shortEffect,
      };
}

class FlavorTextEntry {
  String flavorText;
  Generation language;
  Generation versionGroup;

  FlavorTextEntry({
    required this.flavorText,
    required this.language,
    required this.versionGroup,
  });

  factory FlavorTextEntry.fromRawJson(String str) =>
      FlavorTextEntry.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FlavorTextEntry.fromJson(Map<String, dynamic> json) =>
      FlavorTextEntry(
        flavorText: json["flavor_text"],
        language: Generation.fromJson(json["language"]),
        versionGroup: Generation.fromJson(json["version_group"]),
      );

  Map<String, dynamic> toJson() => {
        "flavor_text": flavorText,
        "language": language.toJson(),
        "version_group": versionGroup.toJson(),
      };
}

class Name {
  Generation language;
  String name;

  Name({
    required this.language,
    required this.name,
  });

  factory Name.fromRawJson(String str) => Name.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        language: Generation.fromJson(json["language"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "language": language.toJson(),
        "name": name,
      };
}

class Pokemon {
  bool isHidden;
  Generation pokemon;
  int slot;

  Pokemon({
    required this.isHidden,
    required this.pokemon,
    required this.slot,
  });

  factory Pokemon.fromRawJson(String str) => Pokemon.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        isHidden: json["is_hidden"],
        pokemon: Generation.fromJson(json["pokemon"]),
        slot: json["slot"],
      );

  Map<String, dynamic> toJson() => {
        "is_hidden": isHidden,
        "pokemon": pokemon.toJson(),
        "slot": slot,
      };
}
