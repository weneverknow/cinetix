part of 'shared.dart';

String apikey = 'df53ada9d05333b32cf6891317be787a';
String imageBaseURL = 'https://image.tmdb.org/t/p/';
PageEvent prevPageEvent;
File imageFileToUpload;
List<Map<String, dynamic>> menuProfile = [
  {"id": "1", "menu": "Edit Profile", "icon": "ic_account_circle.png"},
  {"id": "2", "menu": "My Wallet", "icon": "ic_account_balance.png"},
  {"id": "3", "menu": "Change Language", "icon": "ic_translate.png"},
  {"id": "4", "menu": "Help Centre", "icon": "ic_verified_user.png"},
  {"id": "5", "menu": "Rate Flutix App", "icon": "ic_thumb_up.png"},
  {"id": "6", "menu": "Sign Out", "icon": "ic_logout.png"}
];
