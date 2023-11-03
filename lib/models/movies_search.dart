//Step1. Create the class
class MovieSearch {
  //Step2. Properties of the movie
  final String imdbId;
  final String title;
  final String year;
  final String poster;
  final String type;

  //Step3. Create the constructor of the class
  MovieSearch({required this.imdbId, required this.title, required this.year, required this.poster, required this.type});

  //Step4. Create json to object transformer
  factory MovieSearch.fromJson(Map<String, dynamic> json) {
    return MovieSearch(imdbId: json["imdbID"], title: json["Title"], year: json["Year"], poster: json["Poster"], type: json["Type"]);
  }

  //Step5. Array of json to list of object transformer
  static List<MovieSearch> moviesFromJson(dynamic json ){
    var searchResult = json["Search"];
    List<MovieSearch> results = List.empty(growable: true);

    if (searchResult != null){

      searchResult.forEach((v)=>{
        results.add(MovieSearch.fromJson(v))
      });
      return results;
    }
    return results;
  }

}