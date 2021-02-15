part of 'dm_pages.dart';

class DmEditProfilePage extends StatefulWidget {
  final Users users;
  DmEditProfilePage(this.users);
  @override
  _DmEditProfilePageState createState() => _DmEditProfilePageState();
}

class _DmEditProfilePageState extends State<DmEditProfilePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isValid = false; //untuk enable button Simpan
  String picture = '';
  bool pictureExist = false;
  File pictureFile;
  bool isProcessSimpan = false;
  bool isProcessReset = false;

  @override
  void initState() {
    super.initState();
    emailController.text = widget.users.email;
    nameController.text = widget.users.name;
    picture = widget.users.profilePicture;
    pictureExist = (widget.users.profilePicture ?? '') != '';
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    context.select<ThemeBloc, ThemeData>(
        (themBloc) => ThemeData().copyWith(accentColor: dmGreyColor));
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToProfilePage());
        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(color: dmMainColor),
            SafeArea(child: Container(color: dmBgColor)),
            SafeArea(
                child: Stack(
              children: [
                HeaderBackdrop(),
                BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
                  if (userState is UserLoaded) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 22),
                            GestureDetector(
                                onTap: () {
                                  context
                                      .read<PageBloc>()
                                      .add(GoToProfilePage());
                                },
                                child: BackIcon()),
                            Center(
                              child: Container(
                                  width: 110,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                          alignment: Alignment.center,
                                          child: headerProfile()),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: GestureDetector(
                                            onTap: (pictureExist)
                                                ? () {
                                                    setState(() {
                                                      picture = '';
                                                      pictureExist = false;
                                                      isValid =
                                                          ((pictureExist &&
                                                                  pictureFile !=
                                                                      null) ||
                                                              nameController
                                                                      .text !=
                                                                  widget.users
                                                                      .name);
                                                    });
                                                  }
                                                : () async {
                                                    await getImage()
                                                        .then((file) {
                                                      setState(() {
                                                        pictureFile = file;
                                                        pictureExist = true;
                                                        isValid =
                                                            ((pictureExist &&
                                                                    pictureFile !=
                                                                        null) ||
                                                                nameController
                                                                        .text !=
                                                                    widget.users
                                                                        .name);
                                                      });
                                                    });
                                                  },
                                            child: headerIcon(
                                                color: picture == ''
                                                    ? dmMainColor
                                                    : dmRedColor,
                                                picture: picture == ''
                                                    ? 'assets/icons/ic_add_photo.png'
                                                    : 'assets/icons/ic_cancel_dm.png')),
                                      )
                                    ],
                                  )),
                            ),
                            SizedBox(height: 60),
                            buildInputField(
                                width: size.width,
                                fieldStyle: dmGreyTextFont.copyWith(
                                    fontSize: 16, color: Color(0xFF424242)),
                                controller: emailController,
                                isEnabled: false,
                                labelText: 'Email'),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: buildInputField(
                                width: size.width,
                                fieldStyle: dmWhiteTextFont.copyWith(
                                  fontSize: 16,
                                ),
                                controller: nameController,
                                labelText: 'Nama Lengkap',
                                onChange: (v) {
                                  setState(() {
                                    isValid =
                                        (pictureExist && pictureFile != null) ||
                                            v != widget.users.name;
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 30),
                            isProcessSimpan
                                ? Center(
                                    child: SpinKitFadingCircle(
                                        color: dmMainColor, size: 50))
                                : Center(
                                    child: DmDefaultButton(
                                      width: 250,
                                      height: 45,
                                      color: isValid
                                          ? dmMainColor
                                          : Color(0xFF1A1C1C),
                                      child: Center(
                                          child: Text('SIMPAN',
                                              style: dmWhiteTextFont.copyWith(
                                                  color: isValid
                                                      ? Colors.white
                                                      : Color(0xFF333636),
                                                  fontSize: 16))),
                                      onTap: () async {
                                        if (isValid) {
                                          setState(() {
                                            isProcessSimpan = true;
                                          });
                                          imageFileToUpload = pictureFile;
                                          SignInSignUpResult result =
                                              await AuthServices
                                                  .updateAuthUsers(
                                                      name: nameController.text,
                                                      selectedGenre: widget
                                                          .users.selectedGenre,
                                                      selectedLanguage: widget
                                                          .users
                                                          .selectedLanguage);
                                          if (result.users == null) {
                                            Flushbar(
                                                flushbarPosition:
                                                    FlushbarPosition.TOP,
                                                message: 'Failed Updated Data',
                                                backgroundColor: dmMainColor,
                                                duration: Duration(
                                                    milliseconds: 1500))
                                              ..show(context);
                                          } else {
                                            Flushbar(
                                                flushbarPosition:
                                                    FlushbarPosition.TOP,
                                                message: 'Updated Successfully',
                                                backgroundColor: dmMainColor,
                                                duration: Duration(
                                                    milliseconds: 1500))
                                              ..show(context).then((value) {
                                                setState(() {
                                                  isProcessSimpan = false;
                                                });
                                                context.read<UserBloc>().add(
                                                    LoadUser(
                                                        userState.users.id));
                                                context
                                                    .read<PageBloc>()
                                                    .add(GoToProfilePage());
                                              });
                                          }
                                        }
                                      },
                                    ),
                                  ),
                            SizedBox(height: 15),
                            isProcessReset
                                ? Center(
                                    child: SpinKitFadingCircle(
                                        color: dmMainColor, size: 50))
                                : Center(
                                    child: DmSecondaryButton(
                                        width: 250,
                                        height: 45,
                                        child: Center(
                                            child: Text('RESET PASSWORD',
                                                style: dmWhiteTextFont.copyWith(
                                                    fontSize: 16))),
                                        onTap: () {
                                          setState(() {
                                            isProcessReset = true;
                                          });

                                          AuthServices.resetPassword(
                                                  emailController.text)
                                              .then((value) async => Flushbar(
                                                  duration: Duration(
                                                      milliseconds: 2000),
                                                  flushbarPosition:
                                                      FlushbarPosition.TOP,
                                                  backgroundColor:
                                                      flushbarColor,
                                                  message:
                                                      'Password anda sudah dibuat ulang.\nkunjungi emal anda untuk mengetahui link yang sudah dikirim')
                                                ..show(context).then((value) =>
                                                    context.bloc<PageBloc>().add(
                                                        GoToProfilePage())));

                                          setState(() {
                                            isProcessReset = false;
                                          });
                                        })),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                })
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget buildInputField(
      {double width,
      TextStyle fieldStyle,
      TextEditingController controller,
      bool isEnabled = true,
      String labelText,
      Function onChange}) {
    return Container(
        width: width,
        height: 56,
        child: TextField(
          onChanged: onChange,
          style: fieldStyle,
          controller: controller,
          enabled: isEnabled,
          decoration: InputDecoration(
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF424242)),
                  borderRadius: BorderRadius.circular(10)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE4E4E4)),
                  borderRadius: BorderRadius.circular(10)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10)),
              labelText: labelText,
              labelStyle: dmGreyTextFont),
        ));
  }

  Widget headerProfile() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
          ),
          image: DecorationImage(
              image: (pictureFile != null)
                  ? FileImage(pictureFile)
                  : picture == ''
                      ? AssetImage('assets/images/user_pic.png')
                      : NetworkImage(widget.users.profilePicture),
              fit: BoxFit.cover)),
    );
  }

  Widget headerIcon({Color color, String picture}) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(color: Colors.white),
          image:
              DecorationImage(image: AssetImage(picture), fit: BoxFit.cover)),
    );
  }
}
