import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfiguration {
  static HttpLink httpLink =
      HttpLink("https://n7b67.sse.codesandbox.io/graphql");

  ValueNotifier<GraphQLClient> client =
      ValueNotifier(GraphQLClient(link: httpLink, cache: GraphQLCache()));
}
