import 'package:flutter/material.dart';
import 'package:flutter_graph_subscription/page/home_page.dart';
import 'package:flutter_graph_subscription/page/subscription_page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final HttpLink httpLink =
      HttpLink(uri: 'https://apigraphqlv1.herokuapp.com/');

  final WebSocketLink webSocketLink = new WebSocketLink(
    url: 'ws://apigraphqlv1.herokuapp.com/graphql',
    config: SocketClientConfig(
      autoReconnect: true,
      inactivityTimeout: Duration(seconds: 30),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final link = httpLink.concat(webSocketLink);

    final ValueNotifier<GraphQLClient> client =
        new ValueNotifier<GraphQLClient>(
      GraphQLClient(cache: InMemoryCache(), link: link),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        // home: HomePage(),
        home: SubscriptionPage(),
      ),
    );
  }
}
