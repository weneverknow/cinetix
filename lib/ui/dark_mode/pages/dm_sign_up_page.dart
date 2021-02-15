part of 'dm_pages.dart';

class DmSignUpPage extends StatefulWidget {
  final RegistrationData registrationData;
  DmSignUpPage({this.registrationData});
  @override
  _DmSignUpPageState createState() => _DmSignUpPageState();
}

class _DmSignUpPageState extends State<DmSignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isValid = false;
  bool isError = false;
  String errMessage = "";
  File picture;
  bool passwordOpen = true;
  bool confirmPasswordOpen = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToLoginPage());
        return;
      },
      child: Scaffold(
          backgroundColor: dmBgColor,
          body: Stack(children: [
            Container(color: dmMainColor),
            SafeArea(child: Container(color: dmBgColor)),
            SafeArea(
                child: Stack(children: [
              HeaderBackdrop(),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: GestureDetector(
                              onTap: () {
                                context.read<PageBloc>().add(GoToLoginPage());
                              },
                              child: BackIcon()),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            width: size.width,
                            child: Center(
                                child: Text('Buat Akun Baru',
                                    style: dmWhiteTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500))))
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      height: 98,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                                width: 85,
                                height: 85,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: picture != null
                                            ? FileImage(picture)
                                            : AssetImage(
                                                'assets/images/user_pic.png'),
                                        fit: BoxFit.cover))),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: picture == null
                                  ? () async {
                                      getImage().then((value) {
                                        setState(() {
                                          picture = value;
                                          isValid = (nameController.text !=
                                                  '' &&
                                              emailController.text != '' &&
                                              passwordController.text.length >=
                                                  6 &&
                                              picture != null);
                                        });
                                      });
                                    }
                                  : () {
                                      setState(() {
                                        picture = null;
                                        isValid = (nameController.text != '' &&
                                            emailController.text != '' &&
                                            passwordController.text.length >=
                                                6 &&
                                            picture != null);
                                      });
                                    },
                              child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: picture == null
                                          ? dmMainColor
                                          : dmRedColor,
                                      image: DecorationImage(
                                          image: AssetImage(picture != null
                                              ? 'assets/icons/ic_cancel_dm.png'
                                              : 'assets/icons/ic_add_photo.png'),
                                          fit: BoxFit.cover))),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                    isError
                        ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 27),
                            alignment: Alignment.bottomLeft,
                            child: Text(errMessage,
                                style: dmRedTextFont.copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 12)))
                        : SizedBox(),
                    SizedBox(height: 16),
                    Container(
                        height: 56,
                        width: size.width,
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Color(0xFFE4E4E4)))),
                        child: TextField(
                          onChanged: (text) {
                            setState(() {
                              isValid = (text != '' &&
                                  emailController.text != '' &&
                                  passwordController.text.length >= 6 &&
                                  picture != null);
                            });
                          },
                          controller: nameController,
                          style: dmWhiteTextFont.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                              labelText: 'Nama Lengkap',
                              labelStyle: dmWhiteTextFont.copyWith(
                                  color: Color(0xFFBEBEBE), fontSize: 14),
                              focusedBorder: InputBorder.none),
                        )),
                    SizedBox(height: 16),
                    Container(
                        height: 56,
                        width: size.width,
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Color(0xFFE4E4E4)))),
                        child: TextField(
                          onChanged: (text) {
                            setState(() {
                              isValid = (text != '' &&
                                  nameController.text != '' &&
                                  passwordController.text.length >= 6 &&
                                  picture != null);
                            });
                          },
                          controller: emailController,
                          style: dmWhiteTextFont.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: dmWhiteTextFont.copyWith(
                                color: Color(0xFFBEBEBE), fontSize: 14),
                            focusedBorder: InputBorder.none,
                          ),
                        )),
                    SizedBox(height: 16),
                    Container(
                        height: 56,
                        width: size.width,
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Color(0xFFE4E4E4)))),
                        child: TextField(
                          obscureText: passwordOpen,
                          onChanged: (text) {
                            setState(() {
                              isValid = (text.length >= 6 &&
                                  emailController.text != '' &&
                                  nameController.text != '' &&
                                  picture != null);
                            });
                          },
                          controller: passwordController,
                          style: dmWhiteTextFont.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            suffix: GestureDetector(
                              onTap: () {
                                setState(() {
                                  passwordOpen = !passwordOpen;
                                });
                              },
                              child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  width: 25,
                                  height: 19,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(passwordOpen
                                              ? 'assets/icons/ic_close_eye.png'
                                              : 'assets/icons/ic_open_eye.png'),
                                          fit: BoxFit.fitWidth))),
                            ),
                            labelText: 'Password',
                            labelStyle: dmWhiteTextFont.copyWith(
                                color: Color(0xFFBEBEBE), fontSize: 14),
                            focusedBorder: InputBorder.none,
                          ),
                        )),
                    SizedBox(height: 16),
                    Container(
                        height: 56,
                        width: size.width,
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Color(0xFFE4E4E4)))),
                        child: TextField(
                          obscureText: confirmPasswordOpen,
                          controller: confirmPasswordController,
                          style: dmWhiteTextFont.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            suffix: GestureDetector(
                              onTap: () {
                                setState(() {
                                  confirmPasswordOpen = !confirmPasswordOpen;
                                });
                              },
                              child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  width: 25,
                                  height: 19,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(confirmPasswordOpen
                                              ? 'assets/icons/ic_close_eye.png'
                                              : 'assets/icons/ic_open_eye.png'),
                                          fit: BoxFit.fitWidth))),
                            ),
                            labelText: 'Konfirmasi Password',
                            labelStyle: dmWhiteTextFont.copyWith(
                                color: Color(0xFFBEBEBE), fontSize: 14),
                            focusedBorder: InputBorder.none,
                          ),
                        )),
                    SizedBox(height: 42),
                    Center(
                        child: GestureDetector(
                      onTap: () {
                        if (isValid) {
                          if (!EmailValidator.validate(emailController.text)) {
                            errMessage = "Format email anda salah!";
                            isError = true;
                          } else if (passwordController.text !=
                              confirmPasswordController.text) {
                            isError = true;
                            errMessage = "Password anda tidak sama!";
                          } else {
                            errMessage = '';
                            isError = false;
                            context.read<PageBloc>().add(GoToPreferencePage(
                                RegistrationData(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    profileImage: picture)));
                          }
                          setState(() {});
                        }
                      },
                      child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: isValid ? dmMainColor : Colors.transparent,
                              border: Border.all(
                                  color: isValid
                                      ? dmMainColor
                                      : Color(0xFF292929)),
                              shape: BoxShape.circle),
                          child: Center(
                              child: Icon(Icons.arrow_forward_ios_outlined,
                                  color: isValid
                                      ? Colors.white
                                      : Color(0xFF292929),
                                  size: 18))),
                    ))
                  ],
                ),
              )
            ]))
          ])),
    );
  }
}
