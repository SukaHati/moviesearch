import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_app/models/movies_search.dart';
import 'package:movie_app/widgets/details.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _movies = [
  /*{
  "Title": "The Lord of the Rings: The Fellowship of the Ring",
  "Year": "2001",
  "imdbID": "tt0120737",
  "Type": "movie",
  "Poster": "https://m.media-amazon.com/images/M/MV5BN2EyZjM3NzUtNWUzMi00MTgxLWI0NTctMzY4M2VlOTdjZWRiXkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_SX300.jpg"
  },
  {
  "Title": "The Lord of the Rings: The Return of the King",
  "Year": "2003",
  "imdbID": "tt0167260",
  "Type": "movie",
  "Poster": "https://m.media-amazon.com/images/M/MV5BNzA5ZDNlZWMtM2NhNS00NDJjLTk4NDItYTRmY2EwMWZlMTY3XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg"
  },
  {
  "Title": "The Lord of the Rings: The Two Towers",
  "Year": "2002",
  "imdbID": "tt0167261",
  "Type": "movie",
  "Poster": "https://m.media-amazon.com/images/M/MV5BZGMxZTdjZmYtMmE2Ni00ZTdkLWI5NTgtNjlmMjBiNzU2MmI5XkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg"
  },
  {
  "Title": "The Lord of the Rings: The Rings of Power",
  "Year": "2022–",
  "imdbID": "tt7631058",
  "Type": "series",
  "Poster": "https://m.media-amazon.com/images/M/MV5BNTg3NjcxYzgtYjljNC00Y2I2LWE3YmMtOTliZTkwYTE1MmZiXkEyXkFqcGdeQXVyNTY4NDc5MDE@._V1_SX300.jpg"
  },
  {
  "Title": "Lord of War",
  "Year": "2005",
  "imdbID": "tt0399295",
  "Type": "movie",
  "Poster": "https://m.media-amazon.com/images/M/MV5BMTYzZWE3MDAtZjZkMi00MzhlLTlhZDUtNmI2Zjg3OWVlZWI0XkEyXkFqcGdeQXVyNDk3NzU2MTQ@._V1_SX300.jpg"
  }*/];
  final searchEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(flex: 2, child: TextField(decoration: InputDecoration(hintText: "Enter movie name"), controller: searchEditingController,)),
              Expanded(
                flex: 1,
                child: ElevatedButton(onPressed: (){
                  print("TextField: ${searchEditingController.text}");
                  fetchMovies(searchEditingController.text).then((value) => setState((){
                    _movies = value;
                  }));
                }, child: Text("Search")),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _movies.length,
                itemBuilder: (context, index){
              return ListTile(
                title: Text(_movies[index].title),
                subtitle: Text(_movies[index].year),
                leading: Image.network(_movies[index].poster),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage()));
                },
              );
            }),
          )
        ],
      ),
    );
  }
  //Future bermaksud asynchronous function (ia dipanggil di background)
  //Bila panggil function ini, kita akan gunakan async await atau then
  //Jika saya memanipulasi [], yang <> akan jadi <List<classname>>
  //Jika saya memanipulasi {}, yang [] akan jadi <classname>
  Future<List<MovieSearch>> fetchMovies(String searchname) async {
    print("This is: $searchname");
    String thelink = "https://www.omdbapi.com/?apikey=87d10179&s=pumping";

    if(searchname != "") {
      thelink = 'https://www.omdbapi.com/?apikey=87d10179&s=$searchname';
    }

    print(thelink);

    final response = await http
        .get(Uri.parse(thelink));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //Jika saya memanipulasi [], panggil method ke-5
      //Jika saya memanipulasi {}, panggil method ke-4
      return MovieSearch.moviesFromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
