part of 'services.dart';

class MovieServices {
  static Future<List<Movie>> getMovies(int page, {http.Client client}) async {
    String url =
        'https://api.themoviedb.org/3/discover/movie?api_key=$apikey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=' +
            page.toString();
    //client ?? http.Client;
    var response = await http.get(url);
    if (response.statusCode != 200) {
      return [];
    }
    var data = json.decode(response.body);
    //var dataResult = (data as Map<String, dynamic>)['result'];
    List result = data['results'];

    return result.map((e) => Movie.fromJson(e)).toList();
  }

  static Future<MovieDetail> getDetails(Movie movie,
      {int movieID, http.Client client}) async {
    String url =
        'https://api.themoviedb.org/3/movie/${movieID ?? movie.id}?api_key=$apikey&language=en-US';

    client ??= http.Client();
    var response = await client.get(url);
    var data = json.decode(response.body);

    List genres = (data as Map<String, dynamic>)['genres'];
    String language;
    int runtime = (data as Map<String, dynamic>)['runtime'];
    String country =
        ((data as Map<String, dynamic>)['production_countries'] as List)
            .map((country) => country['name'].toString())
            .toString();
    switch ((data as Map<String, dynamic>)['original_language'].toString()) {
      case 'ja':
        language = 'Japanese';
        break;
      case 'id':
        language = 'Indonesia';
        break;
      case 'ko':
        language = 'Korean';
        break;
      case 'en':
        language = 'English';
        break;
    }

    return movieID != null
        ? MovieDetail(Movie.fromJson(data),
            language: language,
            runtime: runtime,
            country: country,
            genres: genres
                .map(
                    (item) => (item as Map<String, dynamic>)['name'].toString())
                .toList())
        : MovieDetail(movie,
            language: language,
            runtime: runtime,
            country: country,
            genres: genres
                .map(
                    (item) => (item as Map<String, dynamic>)['name'].toString())
                .toList());
  }

  static Future<List<Credit>> getCredits(int movieId,
      {http.Client client}) async {
    String url =
        'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apikey';
    client ??= http.Client();
    var response = await client.get(url);
    var data = json.decode(response.body);

    return ((data as Map<String, dynamic>)['cast'] as List)
        .map((items) => Credit((items as Map<String, dynamic>)['name'],
            (items as Map<String, dynamic>)['profile_path']))
        .take(8)
        .toList();
  }
}
