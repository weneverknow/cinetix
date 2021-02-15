part of 'dm_pages.dart';

class DmPreferencePage extends StatefulWidget {
  final RegistrationData registrationData;
  DmPreferencePage({this.registrationData});
  @override
  _DmPreferencePageState createState() => _DmPreferencePageState();
}

class _DmPreferencePageState extends State<DmPreferencePage> {
  List genres = ["Horror", "Music", "Action", "Drama", "War", "Crime"];
  List languages = ["Bahasa", "English", "Japanese", "Korean"];
  List<String> selectedGenre = [];
  String selectedLanguage = "";
  bool isValid = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        context
            .read<PageBloc>()
            .add(GoToRegistrationPage(widget.registrationData));
        return;
      },
      child: Scaffold(
          body: Stack(children: [
        Container(color: dmMainColor),
        SafeArea(child: Container(color: dmBgColor)),
        SafeArea(
            child: Stack(
          children: [
            HeaderBackdrop(),
            ListView(
              scrollDirection: Axis.vertical,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: GestureDetector(
                          onTap: () {
                            context.read<PageBloc>().add(
                                GoToRegistrationPage(widget.registrationData));
                          },
                          child: BackIcon()),
                    )
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(left: 20, top: 20),
                    child: Text('Pilih Jenis\nFilm Favorit Anda',
                        style: dmWhiteTextFont.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w500))),
                Container(
                    margin: EdgeInsets.only(left: 20, top: 3, bottom: 8),
                    child: Text('*maksimal 4 pilihan',
                        style: dmRedTextFont.copyWith(
                            fontSize: 10, fontWeight: FontWeight.w400))),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Wrap(
                      children: List.generate(
                          genres.length,
                          (index) => GestureDetector(
                                onTap: () {
                                  if (selectedGenre.contains(genres[index])) {
                                    selectedGenre.remove(genres[index]);
                                  } else {
                                    if (selectedGenre.length < 4) {
                                      selectedGenre.add(genres[index]);
                                    }
                                  }
                                  isValid = (selectedGenre.length > 0 &&
                                      selectedLanguage != "");
                                  setState(() {});
                                },
                                child: Container(
                                    margin: EdgeInsets.only(
                                        right: index.isEven ? 24 : 0,
                                        bottom: 24),
                                    width: (size.width - 64) / 2,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        color: (selectedGenre
                                                .contains(genres[index]))
                                            ? dmYellowColor
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                            color: Color(0xFFEAEAEA))),
                                    child: Center(
                                        child: Text(genres[index],
                                            style: dmWhiteTextFont.copyWith(
                                                color: (selectedGenre.contains(
                                                        genres[index]))
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400)))),
                              ))),
                ),
                Container(
                    margin: EdgeInsets.only(left: 20, top: 6, bottom: 8),
                    child: Text('Pilih Bahasa',
                        style: dmWhiteTextFont.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w500))),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Wrap(
                      children: List.generate(
                          languages.length,
                          (index) => GestureDetector(
                                onTap: () {
                                  if (selectedLanguage == languages[index]) {
                                    selectedLanguage = "";
                                  } else {
                                    selectedLanguage = languages[index];
                                  }
                                  isValid = (selectedGenre.length > 0 &&
                                      selectedLanguage != "");
                                  setState(() {});
                                },
                                child: Container(
                                    margin: EdgeInsets.only(
                                        right: index.isEven ? 24 : 0,
                                        bottom: 24),
                                    width: (size.width - 64) / 2,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        color: (selectedLanguage ==
                                                languages[index])
                                            ? dmYellowColor
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                            color: Color(0xFFEAEAEA))),
                                    child: Center(
                                        child: Text(languages[index],
                                            style: dmWhiteTextFont.copyWith(
                                                color: (selectedLanguage ==
                                                        languages[index])
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400)))),
                              ))),
                ),
                SizedBox(height: 20),
                Center(
                    child: GestureDetector(
                  onTap: () {
                    context.read<PageBloc>().add(GoToAccountConfirmationPage(
                        RegistrationData(
                            name: widget.registrationData.name,
                            email: widget.registrationData.email,
                            password: widget.registrationData.password,
                            selectedGenre: selectedGenre,
                            selectedLang: selectedLanguage,
                            profileImage:
                                widget.registrationData.profileImage)));
                  },
                  child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isValid ? dmMainColor : Colors.transparent,
                          border: Border.all(
                              color:
                                  isValid ? dmMainColor : Color(0xFF292929))),
                      child: Center(
                          child: Icon(Icons.arrow_forward_ios_outlined,
                              size: 20,
                              color:
                                  isValid ? Colors.white : Color(0xFF292929)))),
                ))
              ],
            )
          ],
        ))
      ])),
    );
  }
}
