import 'package:flutter/material.dart';
import 'package:flutter_graph_subscription/models/book_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({Key key}) : super(key: key);

  final String addedBook = r"""
      subscription addedBook {
        bookAdded {
          id
          title
          author
        }
      }  
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Subscription'),
        ),
        body: SafeArea(
          child: Container(
            child: Subscription(
              'addedBook',
              addedBook,
              builder: ({loading, error, payload}) {
                if (loading) {
                  return Container(
                    child: Center(
                      child: Text('Esperando dato....'),
                    ),
                  );
                }

                if (error != null) {
                  // handle error
                }

                final Book book = Book.fromJson(payload['bookAdded']);

                print(book);

                return Container(
                  child: Column(
                    children: [
                      Text(book.title),
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }
}
