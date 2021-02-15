part of 'dm_pages.dart';

class DmAccountConfirmationPage extends StatefulWidget {
  final RegistrationData registrationData;
  DmAccountConfirmationPage({this.registrationData});

  @override
  _DmAccountConfirmationPageState createState() =>
      _DmAccountConfirmationPageState();
}

class _DmAccountConfirmationPageState extends State<DmAccountConfirmationPage> {
  bool isSignUp = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Container(color: dmMainColor),
        SafeArea(child: Container(color: dmBgColor)),
        SafeArea(
            child: Container(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Container(
                  width: size.width,
                  child: Stack(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 20, top: 20),
                          child: BackIcon()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text('Konfirmasi Akun Baru',
                                style: dmWhiteTextFont.copyWith(
                                    fontSize: 18, fontWeight: FontWeight.w600)),
                          ),
                        ],
                      )
                    ],
                  )),
              SizedBox(
                height: 130,
              ),
              Center(
                child: Container(
                    width: size.width,
                    height: 180,
                    child: Column(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                              ),
                              image: DecorationImage(
                                  image: FileImage(
                                      widget.registrationData.profileImage),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text('Selamat Datang',
                              style: dmGreyTextFont.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w200)),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 2),
                            child: Text(widget.registrationData.name,
                                style: dmWhiteTextFont.copyWith(
                                    fontSize: 18, fontWeight: FontWeight.w500)))
                      ],
                    )),
              ),
              SizedBox(
                height: size.height * 0.3,
              ),
              isSignUp
                  ? Container(
                      width: 260,
                      height: 36,
                      child: Center(
                          child: SpinKitFadingCircle(
                              size: 35, color: dmMainColor)))
                  : Container(
                      width: 260,
                      height: 36,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: dmMainColor),
                      child: FlatButton(
                        onPressed: () async {
                          setState(() {
                            isSignUp = true;
                          });
                          imageFileToUpload =
                              widget.registrationData.profileImage;
                          SignInSignUpResult result = await AuthServices.signUp(
                              widget.registrationData.email,
                              widget.registrationData.password,
                              widget.registrationData.name,
                              widget.registrationData.selectedGenre,
                              widget.registrationData.selectedLang);
                          if (result.users == null) {
                            Flushbar(
                                message: result.message.toString(),
                                backgroundColor: dmRedColor,
                                duration: Duration(milliseconds: 1500))
                              ..show(context);
                          }
                          setState(() {
                            isSignUp = true;
                          });
                        },
                        child: Center(
                            child: Text('BUAT AKUN',
                                style: dmWhiteTextFont.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500))),
                      )),
            ],
          ),
        ))
      ],
    ));
  }
}
