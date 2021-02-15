part of 'dm_pages.dart';

class DmSplashPage extends StatefulWidget {
  @override
  _DmSplashPageState createState() => _DmSplashPageState();
}

class _DmSplashPageState extends State<DmSplashPage>
    with TickerProviderStateMixin {
  bool showSlideIcon = true;
  int index;

  AnimationController controllerCircle_1,
      controllerCircle_2,
      controllerCircle_3;
  Animation animationCircle_1, animationCircle_2, animationCircle_3;
  double currentProgress = 0;

  List<ImageProvider> bottomNav = [
    AssetImage('assets/images/circle_1.png'),
    AssetImage('assets/images/circle_2.png'),
    AssetImage('assets/images/circle_3.png'),
  ];

  List color = [Color(0xFF8F54A3), Color(0xFF139167), Color(0xFFC05861)];
  Color currentColor;

  @override
  void initState() {
    super.initState();
    currentColor = color[0];
    index = 0;

    controllerCircle_1 =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    controllerCircle_2 =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    controllerCircle_3 =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
  }

  void process_1(double begin, double end) {
    animationCircle_1 =
        Tween<double>(begin: begin, end: end).animate(controllerCircle_1)
          ..addListener(() {
            setState(() {
              currentProgress = animationCircle_1.value;
            });
          });
    controllerCircle_1.forward();
  }

  void process_2(double begin, double end) {
    animationCircle_2 =
        Tween<double>(begin: begin, end: end).animate(controllerCircle_2)
          ..addListener(() {
            currentProgress = animationCircle_2.value;
            setState(() {});
          });
    controllerCircle_2.forward();
  }

  void process_3(double begin, double end) {
    animationCircle_3 =
        Tween<double>(begin: begin, end: end).animate(controllerCircle_3)
          ..addListener(() {
            setState(() {
              currentProgress = animationCircle_3.value;
            });
          });
    controllerCircle_3.forward();
  }

  @override
  void dispose() {
    controllerCircle_1.dispose();
    controllerCircle_2.dispose();
    controllerCircle_3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
            pages: [
              buildSplashContent(size,
                  image: 'assets/images/onboard_1.png',
                  title: 'CineTix',
                  subtitle:
                      'cara mudah untuk beli tiket bioskop\ndan pilih kursi terbaik anda.',
                  color: Color(0xFFCF8AE6)),
              buildSplashContent(size,
                  image: 'assets/images/onboard_3.png',
                  title: 'CineTix',
                  subtitle:
                      'dapatkan tiket bioskop film favorit anda\ndengan cara yang mudah.',
                  color: Color(0xFF01B075)),
              buildSplashContent(size,
                  image: 'assets/images/onboard_4.png',
                  title: 'CineTix',
                  subtitle:
                      'dapatkan cashback, voucher, promo\ndan keuntungan yang lainnya.',
                  color: Color(0xFFFA8E97)),
            ],
            enableLoop: false,
            enableSlideIcon: showSlideIcon,
            fullTransitionValue: 300,
            positionSlideIcon: 0.5,
            waveType: WaveType.liquidReveal,
            slideIconWidget: Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Icon(
                Icons.arrow_back_ios_outlined,
                color: currentColor,
              ),
            ),
            onPageChangeCallback: (v) {
              if (v == 0) {
                process_1(0, 30);
              } else if (v == 1) {
                process_2(30, 60);
              } else if (v == 2) {
                process_3(60, 100);
              }
              setState(() {
                index = v;
                showSlideIcon = !(v == 2);
                currentColor = color[v];
              });
            },
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: currentProgress >= 100
                        ? () {
                            savePref();
                            context.bloc<PageBloc>().add(GoToLoginPage());
                          }
                        : null,
                    splashColor: Colors.black,
                    child: CustomPaint(
                      foregroundPainter:
                          CircleButton(progress: currentProgress),
                      child: Container(
                        width: 100,
                        height: 100,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: currentProgress >= 100
                              ? Colors.white
                              : Color(0xFFB4B4B4),
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ))
        ],
      ),
    );
  }

  Container buildSplashContent(Size size,
      {String image, String title, String subtitle, Color color}) {
    return Container(
      color: color,
      width: size.width,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 224,
            height: 164,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.fitHeight)),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            title,
            style: blackSplashTextFont.copyWith(
                fontSize: 24, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            subtitle,
            style: blackSplashTextFont.copyWith(
                color: Color(0xFF3C3636),
                fontSize: 12,
                fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
