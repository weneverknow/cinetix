part of 'widgets.dart';

class DmMovieDetailDescription extends StatelessWidget {
  final Movie movie;
  final MovieDetail movieDetail;
  final double width;

  const DmMovieDetailDescription(
      {Key key, this.movie, this.movieDetail, this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      width: width - 40 - 160,
      height: 202,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(movie.title,
              style: dmWhiteTextFont.copyWith(
                  fontWeight: FontWeight.w700, fontSize: 16),
              maxLines: 2,
              overflow: TextOverflow.clip),
          SizedBox(
            height: 15,
          ),
          MoviePropertiesRow(
            title: 'Genre',
            desc: movieDetail.genresToString,
          ),
          SizedBox(
            height: 5,
          ),
          MoviePropertiesRow(
            title: 'Bahasa',
            desc: movieDetail.language,
          ),
          SizedBox(
            height: 5,
          ),
          MoviePropertiesRow(
            title: 'Durasi',
            desc: movieDetail.durasi ?? '-',
          ),
          SizedBox(
            height: 5,
          ),
          MoviePropertiesRow(
            title: 'Negara Asal',
            desc: movieDetail.getcountry ?? '-',
          ),
          SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Visit Website',
              style: dmBlueTextFont.copyWith(fontSize: 10),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          RatingStars(
            starSize: 12,
            isEnd: true,
            textColor: Color(0xFFADADAD),
            fontSize: 12,
            voteAverage: movie.voteAverage,
          )
        ],
      ),
    );
  }
}
