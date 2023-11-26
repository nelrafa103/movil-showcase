String names = """query pokemons(\$limit: Int, \$offset: Int) {
  pokemons(limit: \$limit, offset: \$offset) {
    results {
      name
    }
  }
}""";

String types = """query pokemons(\$limit: Int, \$offset: Int) {
  pokemons(limit: \$limit, offset: \$offset) {
    results {
      types
    }
  }
}""";
//String name_image = 