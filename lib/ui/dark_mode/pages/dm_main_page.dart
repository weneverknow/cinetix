part of 'dm_pages.dart';

class DmMainPage extends StatefulWidget {
  final int bottomNavBarIndex;
  final bool isExpired;
  DmMainPage({this.bottomNavBarIndex = 0, this.isExpired = false});
  @override
  _DmMainPageState createState() => _DmMainPageState();
}

class _DmMainPageState extends State<DmMainPage> {
  int bottomNavBarIndex;
  PageController pageController;
  DateTime currentTime;

  Future<bool> exit() {
    DateTime now = DateTime.now();
    if (currentTime == null ||
        now.difference(currentTime) > Duration(seconds: 2)) {
      currentTime = now;
      Fluttertoast.showToast(
          msg: 'Tekan sekali lagi untuk keluar',
          backgroundColor: Colors.white54,
          textColor: Colors.black,
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_SHORT);
      return Future.value(false);
    } else {
      Fluttertoast.cancel();
      return Future.value(true);
    }
  }

  @override
  void initState() {
    super.initState();
    bottomNavBarIndex = widget.bottomNavBarIndex;
    pageController = PageController(initialPage: bottomNavBarIndex);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => exit(),
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            color: dmMainColor,
          ),
          SafeArea(child: Container(color: dmBgColor)),
          SafeArea(
              child: PageView(
            controller: pageController,
            onPageChanged: (v) {
              bottomNavBarIndex = v;
              setState(() {});
            },
            children: [
              DmMoviePage(),
              DmRiwayatPage(),
              DmTicketPage(
                isExpiredTicket: widget.isExpired,
              )
            ],
          )),
          //BOTTOM NAV BAR
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: size.width,
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  decoration: BoxDecoration(
                      color: dmBgColor,
                      border: Border(
                          top: BorderSide(
                              color: Color(0xFF515050).withOpacity(0.7),
                              width: 0.8))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      bottomNavBarIndex == 0
                          ? buildMenuVisited(Icons.home_filled)
                          : buildMenu(0, Icons.home_filled, 'Beranda'),
                      bottomNavBarIndex == 1
                          ? buildMenuVisited(Icons.analytics_rounded)
                          : buildMenu(1, Icons.analytics_rounded, 'Riwayat'),
                      bottomNavBarIndex == 2
                          ? buildMenuVisited(Icons.auto_stories)
                          : buildMenu(2, Icons.auto_stories, 'Tiket')
                    ],
                  )))
        ],
      )),
    );
  }

  AnimatedContainer buildMenuVisited(IconData icon) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      child: Icon(
        icon,
        size: 30,
        color: dmMainColor,
      ),
    );
  }

  Widget buildMenu(int page, IconData icon, String text) {
    return GestureDetector(
        onTap: () {
          pageController.jumpToPage(page);
        },
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon, size: 24, color: Colors.white),
            Text(text,
                style: dmWhiteTextFont.copyWith(
                    fontSize: 8, fontWeight: FontWeight.w700))
          ],
        )));
  }
}
