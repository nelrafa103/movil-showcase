import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlService {
  late GraphQLClient _client;

  GraphqlService() {
    HttpLink link = HttpLink("https://graphql-pokeapi.graphcdn.app/");
    _client =
        GraphQLClient(link: link, cache: GraphQLCache(store: InMemoryStore()));
  }

  Future<QueryResult> peticion(String query,
      {required Map<String, dynamic> variables}) async {
    QueryOptions options =
        QueryOptions(document: gql(query), variables: variables);
    final result = await _client.query(options);
    return result;
  }
}
