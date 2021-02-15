part of 'widgets.dart';

class DmComingSoonHeader extends StatelessWidget {
  final double width;
  final double height;
  final MovieDetail movieDetail;

  const DmComingSoonHeader({Key key, this.width, this.height, this.movieDetail})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        child: Stack(
          children: [
            Positioned(
              top: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(height * 0.56),
                child: Container(
                    width: width,
                    height: height * 0.56,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                imageBaseURL + 'w780' + movieDetail.posterPath),
                            fit: BoxFit.cover))),
              ),
            ),
            Container(
              width: width,
              height: height * 0.65,
              decoration: BoxDecoration(
                  color: Colors.red[200],
                  gradient: RadialGradient(colors: [
                    dmBgColor.withOpacity(0.1),
                    dmBgColor.withOpacity(0.7),
                    dmBgColor,
                  ], stops: [
                    0.1,
                    0.75,
                    0.99999
                  ])),
            ),
          ],
        ));
  }
}
