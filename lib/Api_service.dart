import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello_movies/models/movie.dart';
import 'package:http/http.dart' as http;


class FetchUserList {
  var data = [];
  List<Result> results = [];
  String urlList = "https://api.themoviedb.org/3/search/movie?api_key=38e61227f85671163c275f9bd95a8803&query=marvel";

  Future<List<Result>> getuserList({String query}) async {
    var url = Uri.parse(urlList);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
      
        data = json.decode(response.body);
        results = data.map((e) => Result.fromJson(e)).toList();
        if (query!= null){
          results = results.where((element) => element.title.toLowerCase().contains((query.toLowerCase()))).toList();
        }
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }
}
