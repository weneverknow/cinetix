import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const double defaultMargin = 24;

Color mainColor = Color(0xFF503E9D);
Color accentColor1 = Color(0xFF2C1F63);
Color accentColor2 = Color(0xFFFBD460);
Color accentColor3 = Color(0xFFADADAD);
Color bgColor = Color(0xFFF6F7F9);
Color flushbarColor = Color(0xFFFF5C83);

Color dmMainColor = Color(0xFF01B075);
Color dmYellowColor = Color(0xFFFBD460);
Color dmRedColor = Color(0xFFFE737E);
Color dmBgColor = Color(0xFF101313);
Color dmGreyColor = Color(0xFFADADAD);

TextStyle blackTextFont = GoogleFonts.raleway()
    .copyWith(color: Colors.black, fontWeight: FontWeight.w500);
TextStyle whiteTextFont = GoogleFonts.raleway()
    .copyWith(color: Colors.white, fontWeight: FontWeight.w500);
TextStyle purpleTextFont = GoogleFonts.raleway()
    .copyWith(color: accentColor1, fontWeight: FontWeight.w500);
TextStyle greyTextFont = GoogleFonts.raleway()
    .copyWith(color: accentColor3, fontWeight: FontWeight.w500);

TextStyle blackSplashTextFont = GoogleFonts.montserrat()
    .copyWith(color: Colors.black, fontWeight: FontWeight.w500);
TextStyle dmWhiteTextFont = GoogleFonts.roboto()
    .copyWith(color: Colors.white, fontWeight: FontWeight.w500);
TextStyle dmGreyTextFont = GoogleFonts.roboto()
    .copyWith(color: Color(0xFFADADAD), fontWeight: FontWeight.w500);
TextStyle dmRedTextFont = GoogleFonts.roboto().copyWith(
  color: Color(0xFFFE737E),
  fontWeight: FontWeight.w500,
);
TextStyle dmBlueTextFont = GoogleFonts.roboto()
    .copyWith(color: Color(0xFF0177FB), fontWeight: FontWeight.w500);

TextStyle whiteNumberFont =
    GoogleFonts.openSans().copyWith(color: Colors.white);
TextStyle yellowNumberFont =
    GoogleFonts.openSans().copyWith(color: accentColor2);
