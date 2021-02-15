part of 'widgets.dart';

class DmComingSoonDetail extends StatelessWidget {
  final double width;
  final double height;
  final MovieDetail movieDetail;

  const DmComingSoonDetail({Key key, this.width, this.height, this.movieDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        child: Column(
          children: [
            SizedBox(height: height * 0.54),
            Container(
                width: width * 0.8,
                height: 60,
                child: Center(
                    child: Text(movieDetail.title.toUpperCase(),
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.center,
                        style: dmWhiteTextFont.copyWith(
                            fontSize: 22, fontWeight: FontWeight.w700)))),
            Container(
                width: width * 0.7,
                height: 30,
                child: RatingStars(
                    isCenter: true,
                    voteAverage: movieDetail.voteAverage,
                    fontSize: 12,
                    textColor: Color(0xFFADADAD))),
            Container(
                width: width * 0.8,
                height: 30,
                alignment: Alignment.center,
                child: Text(
                    movieDetail.durasi +
                        '  |  ' +
                        movieDetail.language +
                        '  |  ' +
                        movieDetail.genresToString,
                    style: dmGreyTextFont.copyWith(
                        fontSize: 10, fontWeight: FontWeight.w500))),
            Container(
                width: width * 0.8,
                height: 30,
                margin: EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                child: Text('Sinopsis',
                    style: dmWhiteTextFont.copyWith(fontSize: 14))),
            Expanded(
              child: Container(
                  width: width,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(movieDetail.overview,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.clip,
                      style: dmGreyTextFont.copyWith(
                          fontSize: 10, fontWeight: FontWeight.w200))),
            )
          ],
        ));
  }
}
