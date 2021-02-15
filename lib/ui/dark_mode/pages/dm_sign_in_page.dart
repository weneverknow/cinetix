part of 'dm_pages.dart';

class DmSignInPage extends StatefulWidget {
  @override
  _DmSignInPageState createState() => _DmSignInPageState();
}

class _DmSignInPageState extends State<DmSignInPage>
    with SingleTickerProviderStateMixin {
  bool changeEye = true;
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSignIn = false;
  String errMsg = 'a';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  DateTime currentTime;

  Future<bool> popped() {
    DateTime now = DateTime.now();
    if (currentTime == null ||
        now.difference(currentTime) > Duration(seconds: 3)) {
      currentTime = now;
      Fluttertoast.showToast(
          msg: 'Tekan sekali lagi untuk keluar',
          toastLength: Toast.LENGTH_SHORT);
      return Future.value(false);
    } else {
      Fluttertoast.cancel();
      return Future.value(true);
    }
  }

  AnimationController controller;
  Animation animation;
  Animation iconAnimation;
  Animation msgAnimation;
  double changePaddingTop = 0;
  double posisi = 0;
  double posisiIcon = 0;
  double posisiMsg = 0;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    iconAnimation = Tween<double>(begin: 0, end: 20).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.1, 0.4, curve: Curves.easeIn)))
      ..addListener(() {
        setState(() {
          posisiIcon = iconAnimation.value;
        });
      });

    msgAnimation = Tween<double>(begin: 0, end: 14).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.3, 0.6, curve: Curves.easeIn)))
      ..addListener(() {
        posisiMsg = msgAnimation.value;
        setState(() {});
      });
  }

  void adaError() {
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: Colors.white)));
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => popped(),
      child: Scaffold(
        backgroundColor: dmBgColor,
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
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    width: size.width,
                    height: size.height - 24,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: DmLogo()),
                        SizedBox(
                          height: 41,
                        ),
                        //untuk alert info
                        (errMsg == '')
                            ? SizedBox(
                                height: 22,
                              )
                            : Container(
                                width: size.width - 24 * 2,
                                height: 44,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AnimatedContainer(
                                      margin: EdgeInsets.only(top: 12),
                                      duration: Duration(milliseconds: 400),
                                      width: iconAnimation.value ?? 0,
                                      height: iconAnimation.value ?? 0,
                                      child: Image.asset(
                                        'assets/icons/ic_sad.png',
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    AnimatedContainer(
                                        margin: EdgeInsets.only(top: 14),
                                        duration: Duration(milliseconds: 400),
                                        child: Text(
                                          errMsg,
                                          style: dmRedTextFont.copyWith(
                                              fontSize: msgAnimation.value ?? 0,
                                              fontWeight: FontWeight.w500),
                                        ))
                                  ],
                                ),
                              ),
                        SizedBox(height: 15),
                        buildInputField(size,
                            controller: emailController,
                            text: 'Email : ',
                            hint: 'ketik email anda disini', onchange: (value) {
                          setState(() {
                            isEmailValid = EmailValidator.validate(value);
                          });
                        }),
                        SizedBox(height: 30),
                        buildInputField(size,
                            controller: passwordController,
                            text: 'Kata Sandi : ',
                            hint: 'ketik kata sandi anda disini',
                            isPassword: true, onchange: (value) {
                          setState(() {
                            isPasswordValid = value.toString().length >= 6;
                          });
                        }),
                        SizedBox(height: 31),
                        !isSignIn
                            ? DmDefaultButton(
                                width: 260,
                                height: 45,
                                color: (isEmailValid && isPasswordValid)
                                    ? dmMainColor
                                    : Color(0xFF1B2121),
                                onTap: (isEmailValid && isPasswordValid)
                                    ? () async {
                                        if (errMsg != "") {
                                          controller.reverse();
                                        }
                                        setState(() {
                                          errMsg = '';
                                          isSignIn = true;
                                        });
                                        SignInSignUpResult result =
                                            await AuthServices.signInUser(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text);
                                        if (result.users == null) {
                                          errMsg =
                                              SignInSignUpResult.getMessage(
                                                  result.errorCode);
                                          isSignIn = false;
                                          setState(() {});
                                          adaError();
                                        } else {
                                          setState(() {
                                            isSignIn = false;
                                          });
                                        }
                                      }
                                    : null,
                                child: Text('MASUK',
                                    style: (isEmailValid && isPasswordValid)
                                        ? dmWhiteTextFont.copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)
                                        : dmGreyTextFont.copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)))
                            : SpinKitFadingCircle(
                                size: 45,
                                color: dmMainColor,
                              ),
                        SizedBox(height: 11),
                        DmSecondaryButton(
                            width: 260,
                            height: 45,
                            onTap: () {
                              context.read<PageBloc>().add(
                                  GoToRegistrationPage(RegistrationData()));
                            },
                            child: Text('BUAT AKUN BARU',
                                style: dmWhiteTextFont.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500))),
                      ],
                    ),
                  ),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }

  Container buildInputField(Size size,
      {String text,
      String hint,
      bool isPassword = false,
      Function onchange,
      TextEditingController controller}) {
    return Container(
      width: size.width - defaultMargin * 2,
      height: 52,
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: dmWhiteTextFont.copyWith(fontSize: 14),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: dmGreyColor))),
              child: TextField(
                controller: controller,
                style: dmWhiteTextFont.copyWith(
                  fontSize: 14,
                ),
                onChanged: onchange,
                obscureText: changeEye == false ? false : isPassword,
                decoration: InputDecoration(
                  suffix: isPassword
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              changeEye = !changeEye;
                            });
                          },
                          child: Container(
                            width: 24,
                            height: 14,
                            margin: EdgeInsets.only(right: 5),
                            child: Image.asset(
                              changeEye
                                  ? 'assets/icons/ic_close_eye.png'
                                  : 'assets/icons/ic_open_eye.png',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        )
                      : null,
                  hintText: hint,
                  hintStyle: dmGreyTextFont.copyWith(
                      fontSize: 14, fontStyle: FontStyle.italic),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
