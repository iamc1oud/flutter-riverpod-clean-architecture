import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GraphQL {
  late Link link; // Declare a Link variable for handling GraphQL requests.

  final HttpLink _httpLink = HttpLink(
    'http://10.0.2.2:3000/graphql', // Initialize an HTTP Link with the GraphQL server's URL.
  );
  late GraphQLClient? client; // Declare a nullable GraphQLClient variable.

  GraphQL() {
    create(); // Call the create() method to set up the GraphQL client.
  }

  create() async {
    final AuthLink authLink = AuthLink(
      getToken: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token');
        return 'Bearer $token'; // Fetch and return a token from SharedPreferences as a Bearer token.
      },
    );

    link = authLink.concat(
        _httpLink); // Combine the AuthLink and HTTPLink to create a single link.

    return client = GraphQLClient(
      cache: GraphQLCache(), // Initialize a GraphQL client with a cache.
      link: link, // Set the created link as the client's communication link.
    );
  }

  Future<QueryResult> resolve(String document,
      [Map<String, dynamic>? variables]) async {
    final QueryOptions options = QueryOptions(
        document: gql(
          document,
        ),
        variables: variables ??
            {}); // Create QueryOptions with the provided document and optional variables.

    return await client!.query(
        options); // Execute a GraphQL query using the client and return the result.
  }
}
