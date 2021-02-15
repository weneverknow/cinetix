part of 'dm_pages.dart';

class DmComingSoonDetailPage extends StatefulWidget {
  final Movie movie;
  final MovieDetail movieDetail;
  final List<Credit> credits;
  DmComingSoonDetailPage(this.movie, {this.movieDetail, this.credits});

  @override
  _DmComingSoonDetailPageState createState() => _DmComingSoonDetailPageState();
}

class _DmComingSoonDetailPageState extends State<DmComingSoonDetailPage> {
  PageController pageController = PageController(initialPage: 0);

  PageController backPageViewController;
  PageController frontPageViewController;
  int currentPage = 0;

  MovieDetail movieDetail;
  List<Credit> credits;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieDetail = widget.movieDetail;
    credits = widget.credits;

    backPageViewController = PageController(initialPage: 0);
    frontPageViewController =
        PageController(viewportFraction: 0.8, initialPage: 0);
    frontPageViewController.addListener(() {
      int next = frontPageViewController.page.round();
      if (next != currentPage) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
          body: Stack(children: [
        Container(color: dmMainColor),
        SafeArea(child: Container(color: dmBgColor)),
        SafeArea(
            child: Stack(
          children: [
            PageView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              controller: pageController,
              children: [
                Stack(
                  //disimpan dalam page view
                  children: [
                    DmComingSoonHeader(
                        width: size.width,
                        height: size.height,
                        movieDetail: movieDetail),
                    DmComingSoonDetail(
                      width: size.width,
                      height: size.height,
                      movieDetail: movieDetail,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: size.width,
                        height: 70,
                        alignment: Alignment.topRight,
                        padding: EdgeInsets.only(right: 10),
                        child: FloatingActionButton(
                            onPressed: () {
                              pageController.jumpToPage(1);
                            },
                            backgroundColor: dmMainColor.withOpacity(0.2),
                            elevation: 0,
                            shape: StadiumBorder(),
                            child: Transform.rotate(
                              angle: -(pi / 2),
                              child: Icon(
                                Icons.arrow_back_ios_outlined,
                                color: dmGreyColor,
                              ),
                            )),
                      ),
                    )
                  ],
                ),
                //PAGE 2
                Stack(children: [
                  PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: backPageViewController,
                      itemCount: credits.length,
                      itemBuilder: (context, index) {
                        return Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(imageBaseURL +
                                        'w780' +
                                        credits[index].profilePath),
                                    fit: BoxFit.cover)),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: dmBgColor.withOpacity(0.7))));
                      }),
                  PageView.builder(
                    itemCount: credits.length,
                    physics: BouncingScrollPhysics(),
                    controller: frontPageViewController,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      bool active = currentPage == index;
                      return comingSoonCard(
                          image: imageBaseURL +
                              'w780' +
                              credits[index].profilePath,
                          name: credits[index].name,
                          isActive: active,
                          size: size);
                    },
                    onPageChanged: (index) {
                      backPageViewController.animateToPage(index,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeIn);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: DmHeaderTitle('Pemeran'),
                      )
                    ],
                  )
                ])
              ],
            ),
            GestureDetector(
              onTap: () {
                context.read<PageBloc>().add(GoToMainPage());
              },
              child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  margin: EdgeInsets.only(left: 20, top: 20),
                  child: BackIcon()),
            ),
          ],
        ))
      ])),
    );
  }

  Widget comingSoonCard({String image, String name, bool isActive, Size size}) {
    double paddingTop = isActive ? 140 : 230;
    double blur = isActive ? 30 : 0;
    double offset = isActive ? 20 : 0;
    return AnimatedPadding(
        duration: Duration(milliseconds: 400),
        padding: EdgeInsets.only(top: paddingTop, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
                duration: Duration(milliseconds: 400),
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    Text(name.split(' ')[0],
                        style: GoogleFonts.notoSans().copyWith(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w100)),
                    Text((name.replaceAll(name.split(' ')[0], '')).trim(),
                        style: GoogleFonts.notoSans().copyWith(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w600))
                  ],
                )),
            AnimatedContainer(
                width: size.width * 0.8,
                height: size.height * 0.50,
                duration: Duration(milliseconds: 400),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: dmGreyColor, width: 0.6),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black87,
                          blurRadius: blur,
                          offset: Offset(offset, offset))
                    ],
                    image: DecorationImage(
                        image: NetworkImage(image), fit: BoxFit.cover))),
          ],
        ));
  }

  Widget froastedBox(Widget child, Size size) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(170),
        child: Container(
          margin: EdgeInsets.only(top: 50),
          width: size.width,
          height: size.height * 0.6,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [dmBgColor, dmBgColor.withOpacity(0.1)])),
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), child: child),
        ));
  }
}
