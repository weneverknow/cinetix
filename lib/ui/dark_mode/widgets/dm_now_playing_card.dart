part of 'widgets.dart';

class DmNowPlayingCard extends StatelessWidget {
  final double scale;
  final String url;
  final String title;
  final double voteAverage;
  final double cardWidth;
  final double cardHeight;
  final bool withTitle;
  final double margin;
  final Function onTap;
  DmNowPlayingCard(
      {this.scale = 1,
      this.url,
      this.title,
      this.voteAverage,
      this.cardWidth = 275,
      this.cardHeight = 140,
      this.margin = 0,
      this.withTitle = true,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (scale == 1) {
          onTap();
        }
      },
      child: Stack(
        children: [
          Container(
              width: cardWidth * scale,
              height: cardHeight * scale,
              margin: EdgeInsets.symmetric(horizontal: margin),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color(0xFF5F5F5F).withOpacity(0.7), width: 0.8),
                image: DecorationImage(
                    image: NetworkImage(url), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(8),
              )),
          !withTitle
              ? SizedBox()
              : Positioned(
                  bottom: 0,
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.black.withOpacity(0.5),
                            Colors.black.withOpacity(0.3)
                          ]).createShader(
                        Rect.fromLTRB(0, 25, 10, 40),
                      );
                    },
                    blendMode: BlendMode.dstIn,
                    child: Container(
                      width: cardWidth * scale,
                      height: cardHeight * scale,
                      padding: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [dmBgColor, dmBgColor.withOpacity(0.2)]),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              topRight: Radius.circular(8))),
                    ),
                  ),
                ),
          !withTitle
              ? SizedBox()
              : Positioned(
                  bottom: 0,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: cardWidth * scale,
                          //height: 40,
                          alignment: Alignment.centerLeft,

                          child: Text(
                            title,
                            style:
                                dmWhiteTextFont.copyWith(fontSize: 14 * scale),
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        RatingStars(
                          fontSize: 9 * scale,
                          starSize: 10 * scale,
                          voteAverage: voteAverage,
                        )
                      ],
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
