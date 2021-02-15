part of 'dm_pages.dart';

class DmMoviePage extends StatefulWidget {
  @override
  _DmMoviePageState createState() => _DmMoviePageState();
}

class _DmMoviePageState extends State<DmMoviePage>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> promoContent = [
    {
      "title": "Natal & Tahun Baru",
      "subtitle": "* hanya untuk 2 orang saja",
      "discount": 50,
      "color": dmMainColor
    },
    {
      "title": "Liburan Semester",
      "subtitle": "* hanya untuk mahasiswa",
      "discount": 30,
      "color": dmRedColor
    },
    {
      "title": "Happy Valentine Day",
      "subtitle": "* hanya untuk pasangan",
      "discount": 35,
      "color": dmMainColor
    }
  ];

  List<Color> warna = [Colors.green, Colors.red, Colors.blue];

  PageController nowPlayingController =
      PageController(initialPage: 0, viewportFraction: 0.6);
  PageController comingSoonPageController =
      PageController(initialPage: 0, viewportFraction: 0.3);

  double currentNowPlayingPage = 0;
  double currentComingSoonPage = 0;

  ScrollController controller = ScrollController();
  bool needResize = false;
  bool needResizeName = false;
  bool needResizeBalance = false;
  double balanceToRight = 0;
  bool closeTopContainer = false;
  bool moveLeft = false;
  double additionalLeftPadding = 0;
  double resizeName = 0;
  double defaultSeparator = 20;
  bool moveName = false;
  bool moveBalance = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        closeTopContainer = controller.offset > 55;
        moveLeft = controller.offset > 70;
        if (controller.offset.toInt() >= 71) {
          additionalLeftPadding =
              additionalLeftPadding + (controller.offset.toInt() - 71);
        }
        needResize = controller.offset > 70;
        needResizeName = controller.offset > 71;
        needResizeBalance = controller.offset > 70;
        moveName = controller.offset > 67;
        moveBalance = controller.offset > 69;
        if (controller.offset.toInt() >= 70) {
          resizeName = ((controller.offset - 70) / 10);
        }
        if (controller.offset.toInt() >= 70) {
          balanceToRight = balanceToRight + ((controller.offset - 70)) / 10;
        }
      });
      print("closeTopContainer " + controller.offset.toString());
      print("resizeName " + resizeName.toString());
    });
    nowPlayingController.addListener(() {
      setState(() {
        currentNowPlayingPage = nowPlayingController.page;
      });
      print('currentNowPlayingPage : ' + currentNowPlayingPage.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: [
          BlocBuilder<UserBloc, UserState>(builder: (context, userState) {
            if (userState is UserLoaded) {
              Users users = userState.users;
              return Stack(
                children: [
                  AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      height: closeTopContainer
                          ? size.height * 0.14
                          : size.height * 0.2,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [dmMainColor, dmBgColor]))),
                  GestureDetector(
                    onTap: () {
                      context.read<PageBloc>().add(GoToProfilePage());
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      height: closeTopContainer
                          ? ((size.height * 0.12) * 0.8)
                          : ((size.height * 0.2) * 0.6),
                      width: closeTopContainer
                          ? ((size.height * 0.12) * 0.8)
                          : ((size.height * 0.2) * 0.6),
                      margin: EdgeInsets.only(
                          left: moveLeft
                              ? (20)
                              : (size.width * 0.5) -
                                  (closeTopContainer
                                      ? (((size.height * 0.12) * 0.8) / 2)
                                      : (((size.height * 0.2) * 0.6) / 2)),
                          top: (closeTopContainer
                                  ? ((size.height * 0.12) / 2)
                                  : ((size.height * 0.2)) / 2) -
                              (closeTopContainer
                                  ? (((size.height * 0.12) * 0.8) / 2)
                                  : (((size.height * 0.2) * 0.85) / 2))),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white),
                          image: DecorationImage(
                              image: (users.profilePicture ?? '') != ''
                                  ? NetworkImage(users.profilePicture)
                                  : AssetImage('assets/images/mira.jpg'),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    width: size.width * 0.6,
                    //color: Colors.black38,
                    height: 30,
                    margin: EdgeInsets.only(
                        left: moveName
                            ? (((size.height * 0.12) * 0.8) + 30)
                            : ((size.width * 0.5) - ((size.width * 0.6) / 2)),
                        top: moveName
                            ? ((size.height * 0.2) * 0.15)
                            : (((size.height * 0.2) * 0.6) + 15)),
                    alignment:
                        moveName ? Alignment.centerLeft : Alignment.center,
                    child: Text(users.name,
                        style: dmWhiteTextFont.copyWith(
                            fontSize: needResizeName ? 14 : 18)),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    width: size.width * 0.6,
                    //color: Colors.black38,
                    height: 20,
                    margin: EdgeInsets.only(
                        left: moveBalance
                            ? (((size.height * 0.12) * 0.8) + 30)
                            : ((size.width * 0.5) - ((size.width * 0.6) / 2)),
                        top: moveBalance
                            ? ((size.height * 0.2) * 0.30)
                            : (((size.height * 0.2) * 0.6) + 38)),
                    alignment:
                        moveBalance ? Alignment.centerLeft : Alignment.center,
                    child: Text(
                        NumberFormat.currency(
                                locale: 'id_ID',
                                decimalDigits: 0,
                                symbol: 'IDR ')
                            .format(users.balance),
                        style: dmRedTextFont.copyWith(fontSize: 12)),
                  ),
                  BlocBuilder<UserBloc, UserState>(
                      builder: (context, userState) {
                    if (userState is UserLoaded) {
                      return FutureBuilder(
                          future: TicketServices.isHasTicketToday(
                              userState.users.id),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                bool tickets = snapshot.data;

                                return Padding(
                                    padding:
                                        EdgeInsets.only(top: 20, right: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<PageBloc>()
                                                  .add(GoToTicketToday());
                                            },
                                            child: DmNotifications(
                                                length: tickets ? 1 : 0))
                                      ],
                                    ));
                              } else {
                                return Padding(
                                    padding:
                                        EdgeInsets.only(top: 20, right: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [DmNotifications(length: 0)],
                                    ));
                              }
                            } else {
                              return Padding(
                                  padding: EdgeInsets.only(top: 20, right: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [DmNotifications(length: 0)],
                                  ));
                            }
                          });
                    } else {
                      return SpinKitFadingCircle(size: 20, color: dmMainColor);
                    }
                  })
                ],
              );
            } else {
              return Center(
                  child: SpinKitFadingCircle(color: dmMainColor, size: 50));
            }
          }),
          Expanded(
              child: ListView(
            physics: BouncingScrollPhysics(),
            controller: controller,
            children: [
              SizedBox(height: 30),
              SizedBox(
                  height: 60,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: promoContent.map((item) {
                        return DmPromoCard(
                          title: item['title'],
                          subtitle: item['subtitle'],
                          discount: item['discount'],
                          color: item['color'],
                        );
                      }).toList())),
              SizedBox(height: 30),
              DmSectionLabel('Sedang Tayang'),
              SizedBox(height: 10),
              SizedBox(
                height: 140,
                child: BlocBuilder<MovieBloc, MovieState>(
                    builder: (_, movieState) {
                  if (movieState is MovieLoaded) {
                    List<Movie> movies = movieState.movie.sublist(0, 10);
                    return PageView.builder(
                        controller: nowPlayingController,
                        itemCount: movies.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          double difference = index - currentNowPlayingPage;
                          if (difference < 0) {
                            difference *= -1;
                          }
                          difference = min(1, difference);

                          return Center(
                            child: DmNowPlayingCard(
                              url: imageBaseURL +
                                  'w780' +
                                  movies[index].backdropPath,
                              scale: 1 - (difference * 0.4),
                              title: movies[index].title,
                              voteAverage: movies[index].voteAverage,
                              onTap: () {
                                context
                                    .bloc<PageBloc>()
                                    .add(GoToMovieDetailPage(movies[index]));
                              },
                            ),
                          );
                        });
                  } else {
                    return SpinKitFadingCircle(color: dmMainColor, size: 45);
                  }
                }),
              ),
              SizedBox(height: 30),
              DmSectionLabel('Kategori Film'),
              SizedBox(height: 10),
              SizedBox(
                  height: 70,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: BlocBuilder<UserBloc, UserState>(
                        builder: (context, userState) {
                      if (userState is UserLoaded) {
                        Users users = userState.users;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                              users.selectedGenre.length,
                              (index) => DmKategoriCard(
                                  genre: users.selectedGenre[index])),
                        );
                      } else {
                        return SpinKitFadingCircle(
                          size: 50,
                          color: dmMainColor,
                        );
                      }
                    }),
                  )),
              SizedBox(
                height: 30,
              ),
              DmSectionLabel('Akan Tayang'),
              SizedBox(height: 10),
              SizedBox(
                height: 220,
                child: BlocBuilder<MovieBloc, MovieState>(
                    builder: (context, movieState) {
                  if (movieState is MovieLoaded) {
                    List<Movie> movies = movieState.movie.sublist(10);
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          return DmComingSoonCard(
                            index: index,
                            onTap: () {
                              MovieDetail movieDetail;
                              List<Credit> credits;
                              MovieServices.getDetails(movies[index])
                                  .then((detailMovie) {
                                movieDetail = detailMovie;
                                MovieServices.getCredits(movies[index].id)
                                    .then((listCredit) {
                                  credits = listCredit;
                                  context.read<PageBloc>().add(
                                      GoToComingSoonDetailPage(movies[index],
                                          movieDetail: movieDetail,
                                          credits: credits));
                                });
                              });
                            },
                            movies: movies,
                          );
                        });
                  } else {
                    return SpinKitFadingCircle(
                      color: dmMainColor,
                      size: 50,
                    );
                  }
                }),
              ),
              SizedBox(height: 70)
            ],
          ))
        ],
      ),
    );
  }

  Container buildContainer(Size size,
      {String image, String name, int balance}) {
    return Container(
      width: size.width,
      height: 80,
      padding: EdgeInsets.only(left: 20, top: 3, bottom: 10),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              //transform: Gradien,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF01B075), Color(0xFF101313)])),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 55,
                height: 55,
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: image == ''
                            ? AssetImage('assets/images/user_pic.png')
                            : NetworkImage(image),
                        fit: BoxFit.cover)),
              ),
              Positioned(
                right: 2,
                top: 3,
                child: Container(
                  width: 12,
                  height: 12,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFFFBD460)),
                  child: Icon(
                    Icons.edit,
                    size: 8,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16),
              ),
              SizedBox(height: 3),
              Text(
                NumberFormat.currency(
                        locale: 'id_ID', symbol: 'IDR ', decimalDigits: 0)
                    .format(balance),
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFFE737E),
                    fontSize: 10),
                textAlign: TextAlign.end,
              )
            ],
          )
        ],
      ),
    );
  }
}
