import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CreateBookPage extends StatefulWidget {
  const CreateBookPage({Key key}) : super(key: key);

  @override
  _CreateBookPageState createState() => _CreateBookPageState();
}

class _CreateBookPageState extends State<CreateBookPage> {
  String title;
  String author;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String addBookMutation = r"""
        mutation addBook($title: String!, $author: String!){
          createBook(title: $title, author: $author) {
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
        title: Text('Create Book'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 20.0,
            left: 20.0,
            right: 20.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Titulo'),
                  onSaved: (value) {
                    this.title = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Titulo vacio';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Autor'),
                  onSaved: (value) {
                    this.author = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Autor vacio';
                    }
                    return null;
                  },
                ),
                Mutation(
                  options: MutationOptions(
                      documentNode: gql(this.addBookMutation),
                      update: (cache, result) {
                        return cache;
                      },
                      onCompleted: (resultData) {
                        print('Se guardó');
                        print(resultData);
                      }),
                  builder: (runMutation, QueryResult result) {
                    return Column(
                      children: [
                        FlatButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              runMutation(
                                  {"title": this.title, "author": this.author});
                            }
                          },
                          child: Text(
                            'Guardar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
