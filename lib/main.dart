import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:movie_list/graphql_config.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

void main() {
  runApp(GraphQLProvider(
    child: MyApp(),
    client: graphQLConfiguration.client,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MoveList",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String query = '''
            query fetchMovies{
              movies{
                name,
                genre,
                actor{
                  name
                }
              }
            }
        ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: Text("MovieList"),
      ),
      body: Query(
          options: QueryOptions(document: gql(query)),
          builder: (QueryResult result, {fetchMore, refetch}) {
            if (result.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    elevation: 1,
                    color: Colors.white,
                    child: Container(
                      margin: EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Text(
                                  result.data['movies'][index]['name'],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                              )),
                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      child: Text("Name"),
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                      child: Text(
                                          result.data['movies'][index]['name']),
                                    ))
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      child: Text("Genre"),
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                      child: Text(result.data['movies'][index]
                                          ['genre']),
                                    ))
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      child: Text("Actor"),
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                      child: Text(result.data['movies'][index]
                                          ['actor']['name']),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: result.data['movies'].length,
              );
            }
          },
        ),
    );
  }
}
