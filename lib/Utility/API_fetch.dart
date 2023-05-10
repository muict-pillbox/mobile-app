import 'package:graphql/client.dart';

enum GraphQLResultState { loading, success, error }

class GraphQLResult<T> {
  final GraphQLResultState state;
  final T? data;
  final dynamic error;

  GraphQLResult(this.state, {this.data, this.error});
}

Future<GraphQLResult<Map<String, dynamic>>> getGraphQLData(
    String query, Map<String, dynamic> variables) async {
  const String url =
      'http://0.tcp.ap.ngrok.io:19944/graphql'; // replace with your actual API endpoint
  final HttpLink httpLink = HttpLink(url);
  final GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
  );

  final QueryOptions options = QueryOptions(
    document: gql(query),
    variables: variables,
  );

  final QueryResult result = await client.query(options);

  if (result.hasException) {
    return GraphQLResult(GraphQLResultState.error, error: result.exception!);
  } else {
    return GraphQLResult(GraphQLResultState.success, data: result.data);
  }
}
