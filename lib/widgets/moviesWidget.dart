
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:hello_movies/models/movie.dart';
import 'package:readmore/readmore.dart';

class MoviesWidget2 extends StatelessWidget {

  final List<Result> resultMovies;
  String base_image_url = "https://image.tmdb.org/t/p/w500";
  MoviesWidget2({this.resultMovies});

  @override
  Widget build(BuildContext context) {


    return ListView.builder(
      itemCount: resultMovies.length,
      itemBuilder: (context, index) {

        final movie = resultMovies[index];

        return ListTile(
          title: Column(
            children: [
              Row(
                children: [
                SizedBox(
                  width: 120,
                  child:
                  ClipRRect(
                    child: Image.network(base_image_url+movie.posterPath),
                    borderRadius: BorderRadius.circular(10),
                  )
                ),

                Flexible(
                  flex: 2,
                  child:
                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ReadMoreText(
                          movie.title,
                              trimLines: 3,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                              ),
                              textAlign: TextAlign.center,
                            ),
                        SizedBox(height: 10,),
                        ReadMoreText(
                          movie.overview,
                              trimLines: 3,
                              style: TextStyle(color: Colors.black),
                              colorClickableText: Colors.red,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: '...Expand',
                              trimExpandedText: ' Collapse ',
                            ),
                      ],
                    ),
                  ),

                ),

                /*Flexible(
                   flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                      child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(movie.title),
                        SizedBox(height: 10,),

                      ],
                      ),
                    ),
                )*/
              ],
        ),
            ]
          )
        );
      }
    );
    
  }
}