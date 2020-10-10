import 'package:flutter/material.dart';
import 'package:flutter_graph_subscription/page/create_book_page.dart';
import 'package:flutter_graph_subscription/page/home_page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final HttpLink httpLink = HttpLink(uri: 'http://fd320cb45869.ngrok.io/');

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<GraphQLClient> client =
        new ValueNotifier<GraphQLClient>(
      GraphQLClient(cache: InMemoryCache(), link: httpLink),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Material App',
        // home: HomePage(),
        home: CreateBookPage(),
      ),
    );
  }
}
