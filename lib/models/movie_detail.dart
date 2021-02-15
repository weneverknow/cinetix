part of 'models.dart';

class MovieDetail extends Movie {
  final List<String> genres;
  final String language;
  final int runtime;
  final String country;

  MovieDetail(Movie movie,
      {this.genres, this.language, this.runtime, this.country})
      : super(
            id: movie.id,
            title: movie.title,
            voteAverage: movie.voteAverage,
            overview: movie.overview,
            posterPath: movie.posterPath,
            backdropPath: movie.backdropPath);
  String get getcountry {
    return this.country.replaceAll('(', '').replaceAll(')', '');
  }

  String get durasi {
    String d = '';
    int jam = (this.runtime ~/ 60).toInt();
    d = this.runtime > 60
        ? (jam.toString() +
            ' Jam ' +
            (this.runtime - (jam * 60)).toInt().toString() +
            ' Menit')
        : this.runtime.toString() + ' Menit';
    return d;
  }

  String get genresAndLanguage {
    String s = "";
    for (var genre in genres) {
      s += genre + (genre != genres.last ? ', ' : '');
    }
    return '$s - $language';
  }

  String get genresToString {
    String g = "";
    for (var genre in genres) {
      g += genre + (genre != genres.last ? ', ' : '');
    }
    return '$g';
  }

  @override
  List<Object> get props => [genres, language];
}
