part of 'models.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final double voteAverage;
  final String overview;
  final String posterPath;
  final String backdropPath;

  Movie(
      {@required this.id,
      @required this.title,
      @required this.voteAverage,
      @required this.overview,
      @required this.posterPath,
      @required this.backdropPath});

  factory Movie.fromJson(Map<String, dynamic> obj) {
    return Movie(
        id: obj['id'],
        title: obj['title'],
        voteAverage: (obj['vote_average'] as num).toDouble(),
        overview: obj['overview'],
        posterPath: obj['poster_path'],
        backdropPath: obj['backdrop_path']);
  }
  @override
  // TODO: implement props
  List<Object> get props =>
      [id, title, voteAverage, overview, posterPath, backdropPath];
}
