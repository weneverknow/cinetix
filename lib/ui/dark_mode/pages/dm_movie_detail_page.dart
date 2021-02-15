part of 'dm_pages.dart';

class DmMovieDetailPage extends StatelessWidget {
  final Movie movie;
  DmMovieDetailPage(this.movie);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    MovieDetail movieDetail;
    List<Credit> credits;
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: dmMainColor,
            ),
            SafeArea(
              child: Container(
                color: dmBgColor,
              ),
            ),
            SafeArea(
              child: Stack(
                children: [
                  HeaderBackdrop(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: FutureBuilder(
                        future: MovieServices.getDetails(movie),
                        builder: (_, snapshot) {
                          if (snapshot.hasData) {
                            movieDetail = snapshot.data;
                            return FutureBuilder(
                                future: MovieServices.getCredits(movie.id),
                                builder: (_, snapshot) {
                                  if (snapshot.hasData) {
                                    credits = snapshot.data;
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 20),
                                        BackIcon(
                                          size: 20,
                                          onTap: () {
                                            context
                                                .read<PageBloc>()
                                                .add(GoToMainPage());
                                          },
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 18,
                                            bottom: 20,
                                          ),
                                          child: Row(
                                            children: [
                                              DmMovieDetailPoster(imageBaseURL +
                                                  'w780' +
                                                  movie.posterPath),
                                              DmMovieDetailDescription(
                                                  movie: movie,
                                                  movieDetail: movieDetail,
                                                  width: size.width)
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        DmSectionLabel('Pemeran',
                                            leftPadding: 0),
                                        SizedBox(
                                            height: 110,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: credits.length,
                                                itemBuilder: (context, index) {
                                                  return DmMovieDetailCast(
                                                    credits: credits,
                                                    credit: credits[index],
                                                  );
                                                })),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        DmSectionLabel('Sinopsis',
                                            leftPadding: 0),
                                        SizedBox(height: 5),
                                        Container(
                                          width: double.infinity,
                                          height: 170,
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            movie.overview,
                                            style: dmGreyTextFont.copyWith(
                                                fontSize: 14),
                                            textAlign: TextAlign.justify,
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                        SizedBox(height: 25),
                                        Center(
                                            child: DmDefaultButton(
                                                width: 150,
                                                height: 45,
                                                color: dmMainColor,
                                                onTap: () {
                                                  context.read<PageBloc>().add(
                                                      GoToSelectSchedulePage(
                                                          movieDetail));
                                                },
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                        Icons
                                                            .add_shopping_cart_outlined,
                                                        size: 18,
                                                        color: Colors.white),
                                                    SizedBox(width: 8),
                                                    Text('BELI TIKET',
                                                        style: dmWhiteTextFont)
                                                  ],
                                                ))),
                                      ],
                                    );
                                  } else {
                                    return SizedBox();
                                  }
                                });
                          } else {
                            return SizedBox();
                          }
                        }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
