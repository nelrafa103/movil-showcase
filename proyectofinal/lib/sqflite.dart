import 'package:hive/hive.dart';
import 'package:proyectofinal/models/hive/fav_dao.dart';
import 'package:proyectofinal/models/hive/pokemon_dao.dart';

class DbInitializer {
  static Box? _box; // Declare a static Box
  static Box? _box2;

  static Future<void> initialize() async {
    Hive.init('/data/user/0/com.example.proyectofinal/app_flutter');
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(PokemonDaoAdapter());
    }

    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(FavDaoAdapter());
    }

    _box = await Hive.openBox('pokemons');
    _box2 = await Hive.openBox("favs");
  }

  static void insert(PokemonDao pokemon) {
    bool exist = false;

    //   Hive.registerAdapter(PokemonDaoAdapter());
    if (_box != null) {
      _box!.toMap().forEach((key, value) {
        if (value.name == pokemon.name) {
          exist = true;
          //  _box!.delete(key);
        }
      });

      if (!exist) {
        _box!.add(pokemon);
      }
    }
  }

  static void saveFavs(FavDao fav) {
    bool exist = false;

    if (_box2 != null) {
      _box2!.toMap().forEach((key, value) {
        if (value.name == fav.name) {
          exist = true;
          _box2!.delete(key);
        }
      });
      if (!exist) {
        _box2!.add(fav);
      }
    }
  }

  static List<String> search(String param) {
    List<String> name_list = [];
    _box!.toMap().forEach((key, value) {
      if (value.name.toString().startsWith(param)) {
        name_list.add(value.name);
      }
    });
    return name_list;
  }

  static bool searchFav(String param) {
    bool isFav = false;
    if (_box2 != null) {
      _box2!.toMap().forEach((key, value) {
        if (value.name == param) {
          isFav = true;
        }
      });
    }
    return isFav;
  }

  static PokemonDao getPokemon(String name) {
    // PokemonDao pokemon = PokemonDao(id: 0, name: "", url: "");
    int index = 0;
    _box!.toMap().forEach((key, value) {
      if (value.name == name) {
        index = value.id;
      }
    });
    return PokemonDao(id: index, name: "", url: "");
  }
  // Other methods for insert, delete, update, etc.
}
