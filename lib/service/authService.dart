import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AuthService {
  static final HttpLink httpLink = HttpLink("https://optimum-ostrich-33.hasura.app/v1/graphql",
      defaultHeaders: {
        'content-type': 'application/json',
        'x-hasura-admin-secret': '2GIo9SZqYwku38MPsO6MZxLMceFnj4tCy4U24t4Lk2uEE2vWaxctDsubMJUmAiGx'
      });
  final GraphQLClient client = GraphQLClient(link: httpLink, cache: GraphQLCache());


  // Signing Up a New User
  Future<bool> signUp(String username, String name, String lastName, String email, String password, String mobile) async {
    // Creating the mutation object
    const String signupMutation = r'''
      mutation MyMutation($username: String!, $name: String!, $lastName: String!, $email: String!, $password: String!, $mobile: String!) {
        insert_user(objects: {name: $name, username: $username, password: $password, isActive: true,  email: $email,lastname: $lastName, mobile: $mobile}) {
            returning {
              isActive
              name
              username
              password
              email
              lastname
              mobile
            }
          }
        }''';

    // Mutation options
    final MutationOptions options = MutationOptions(
      document: gql(signupMutation),
      variables: <String, dynamic>{
        'name': name,
        'username': username,
        'password': password,
        'email': email,
        'lastName': lastName,
        'mobile': mobile,
      },
    );

    // Query Hasura server
    final QueryResult result = await client.mutate(options);

    if (result.hasException) {
      throw Exception('Signup Failed: ${result.exception.toString()}');
    } else {
      // TODO: Show a popup message
      if (kDebugMode) {
        print("SignUp Success !!! ");
      }
      return true;
    }
  }

  Future<int?> login(String email, String password) async {
    // Creating the query object
    const String loginQuery = r'''
      query login($email: String!, $password: String!) {
        user(where: {password: {_eq: $password}, username: {_eq: $email}}) {
          id
          isActive
          name   
          lastname    
          mobile      
          username
          email
        }
      }''';
    // mutation options
    final MutationOptions options = MutationOptions(
        document: gql(loginQuery),
        variables: <String, dynamic>{
          'email': email,
          'password': password
        }
    );
    // Query Hasura server
    final QueryResult result = await client.mutate(options);

    if (result.hasException) {
      throw Exception('Login Failed: ${result.exception.toString()}');
    } else {
      // Getting response
      Map<String, dynamic>? data = (result.data?['user'] as List<dynamic>).first;

      if (data != null && data.containsKey('id') && data.containsKey('username')) {
        // Email and ID exist in the response
        String userEmail = data['username'] as String;
        int userId = data['id'] as int;
        if (kDebugMode) {
          print('User Email: $userEmail');
        }
        if (kDebugMode) {
          print('User ID: $userId');
        }
        return userId;
      } else {
        return null;
      }
    }
  }

  // Fetch user data by ID
  Future<Map<String, dynamic>> fetchUserData(int userId) async {
    // Creating the query object
    const String query = r'''
      query getUserbyId($userId: Int!) {
        user_by_pk(id: $userId) {
          id
          username
          isActive
          name
          lastName
          mobile
        }
      }''';

    // Query options
    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: <String, dynamic>{
        'userId': userId,
      },
    );

    // Query Hasura server
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw Exception('Failed to fetch user data: ${result.exception}');
    }

    return result.data?['user_by_pk'] as Map<String, dynamic>? ?? {};
  }
}
