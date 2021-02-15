import 'dart:io';
import 'dart:ui';
import 'package:flutix/shared/theme.dart';
import 'package:flutix/ui/dark_mode/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/Helpers/Helpers.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutix/bloc/bloc.dart';
import 'package:flutix/models/models.dart';
import 'package:flutix/services/services.dart';
import 'package:flutix/shared/shared.dart';
import 'package:flutix/ui/widgets/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_string/random_string.dart';
import 'package:flutix/extensions/extensions.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

part 'dm_splash_page.dart';
part 'dm_sign_in_page.dart';
part 'dm_main_page.dart';
part 'dm_movie_page.dart';
part 'dm_movie_detail_page.dart';
part 'dm_select_schedule_page.dart';
part 'dm_select_seat_page.dart';
part 'dm_checkout_page.dart';
part 'dm_success_page.dart';
part 'dm_profile_page.dart';
part 'dm_edit_profile_page.dart';
part 'dm_top_up_page.dart';
part 'dm_riwayat_page.dart';
part 'dm_ticket_page.dart';
part 'dm_ticket_detail_page.dart';
part 'dm_sign_up_page.dart';
part 'dm_preference_page.dart';
part 'dm_account_confirmation_page.dart';
part 'dm_coming_soon_detail_page.dart';
part 'dm_my_wallet_page.dart';
part 'dm_wrapper.dart';
part 'dm_notifications.dart';
part 'dm_ticket_today.dart';

void savePref() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setBool('alreadyUse', true);
}

Future<bool> getPref() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getBool('alreadyUse') ?? false;
}
