
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hello_movies/Api_service.dart';
import 'package:hello_movies/models/movie.dart';
import 'package:hello_movies/widgets/moviesWidget.dart';
import 'package:hello_movies/widgets/search.dart';
import 'package:http/http.dart' as http;
import 'package:anim_search_bar/anim_search_bar.dart';


void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override 
  _App createState() => _App();
}

class _App extends State<App> {

  TextEditingController textController = TextEditingController();
  List<Result> _resultMovies = new List<Result>();
  FetchUserList _userList = FetchUserList();
  String baseUrl = "https://api.themoviedb.org/3/search/movie?api_key=38e61227f85671163c275f9bd95a8803&query=marvel";

  @override
  void initState() {
    super.initState();
    _populateAllMovies();
  }

  void _populateAllMovies() async {
    final resultMovies = await _fetchAllMovies();
    setState(() {
      _resultMovies = resultMovies;
    });
  }

  Future<List<Result>> _fetchAllMovies() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result["results"];
      return list.map((resultMovie) => Result.fromJson(resultMovie)).toList();
    } else {
      throw Exception("Failed to load movies!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Movies App",
        home:
        Scaffold(
          appBar: AppBar(
            toolbarHeight:80,
            flexibleSpace:Container(
                padding: const EdgeInsets.symmetric(horizontal:20,vertical: 0),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    AnimSearchBar(
                      helpText: "Search Movies",
                      autoFocus: true,
                      width: 400,
                      rtl: true,
                      closeSearchOnSuffixTap: true,
                      textController: textController,
                      animationDurationInMilli: 300,
                      onSuffixTap: (){
                        setState(() {
                          showSearch(context: context, delegate: SearchMovie());
                          textController.clear();
                        });
                      },
                    )
                  ],
                )
            ),
            title: Text("Movies"),
            centerTitle: true,
          ),
          body: MoviesWidget2(resultMovies: _resultMovies),
        ),
      /*Scaffold(
          appBar: AppBar(
            toolbarHeight:80,
            title: Text("Movies"),
            actions: [
              IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: SearchMovie());
                },
                icon: Icon(Icons.search_sharp),
              )
            ],
            centerTitle: true,
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            child: FutureBuilder<List<Result>>(
                future: _userList.getuserList(),
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  return ListView.builder(
                      itemCount: data?.length,
                      itemBuilder: (context, index) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurpleAccent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${data[index].id}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${data[index].title}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          '${data[index].releaseDate}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ])
                                ],
                              ),
                              // trailing: Text('More Info'),
                            ),
                          ),
                        );
                      });
                }),
          ),
        ),*/
    );
  }


}

