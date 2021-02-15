part of 'dm_pages.dart';

class DmSelectSchedulePage extends StatefulWidget {
  final MovieDetail movieDetail;
  DmSelectSchedulePage(this.movieDetail);
  @override
  _DmSelectSchedulePageState createState() => _DmSelectSchedulePageState();
}

class _DmSelectSchedulePageState extends State<DmSelectSchedulePage> {
  List<DateTime> dates;
  DateTime selectedDate;
  int selectedTime;
  Theater selectedTheater;

  @override
  void initState() {
    super.initState();
    dates =
        List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
    selectedDate = dates[0];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToMovieDetailPage(widget.movieDetail));
        return;
      },
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            color: dmMainColor,
          ),
          SafeArea(child: Container(color: dmBgColor)),
          SafeArea(
              child: Stack(
            children: [
              HeaderBackdrop(),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: GestureDetector(
                            onTap: () {
                              context.read<PageBloc>().add(
                                  GoToSelectSchedulePage(widget.movieDetail));
                            },
                            child: BackIcon())),
                    DmSectionLabel('Pilih Tanggal'),
                    SizedBox(height: 15),
                    SizedBox(
                        height: 90,
                        child: ListView.builder(
                            itemCount: dates.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.only(
                                      left: index == 0 ? 20 : 16,
                                      right:
                                          index == dates.length - 1 ? 20 : 0),
                                  child: DmSelectTableBox(
                                    isSelected: (dates[index] == selectedDate),
                                    width: 70,
                                    height: 90,
                                    text: dates[index].shortDayName +
                                        '\n' +
                                        dates[index].day.toString(),
                                    textStyle: dmWhiteTextFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        selectedDate = dates[index];
                                      });
                                    },
                                  ),
                                ))),
                    Padding(
                        padding: EdgeInsets.only(bottom: 20, top: 30),
                        child: generateTimeTheater()),
                    SizedBox(
                      height: 50,
                      child: BlocBuilder<UserBloc, UserState>(
                        builder: (_, userState) {
                          return Center(
                            child: GestureDetector(
                                onTap: () {
                                  context.read<PageBloc>().add(
                                      GoToSelectSeatPage(Ticket(
                                          widget.movieDetail,
                                          selectedTheater,
                                          DateTime(
                                              selectedDate.year,
                                              selectedDate.month,
                                              selectedDate.day,
                                              selectedTime),
                                          randomAlphaNumeric(12).toUpperCase(),
                                          null,
                                          (userState as UserLoaded).users.name,
                                          null)));
                                },
                                child: DmDefaultCircleButton(
                                  boxColor: (selectedDate != null &&
                                          selectedTime != null)
                                      ? dmMainColor
                                      : Colors.transparent,
                                  borderColor: (selectedDate != null &&
                                          selectedTime != null)
                                      ? Colors.transparent
                                      : Color(0xFF292929),
                                  iconColor: (selectedDate != null &&
                                          selectedTime != null)
                                      ? Colors.white
                                      : Color(0xFF292929),
                                )),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 40)
                  ],
                ),
              )
            ],
          ))
        ],
      )),
    );
  }

  Widget generateTimeTheater() {
    List<int> times = List.generate(5, (index) => 12 + (index * 2));

    List<Widget> widgets = [];

    for (var theater in dummyTheater) {
      widgets.add(Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: DmSectionLabel(theater.name, leftPadding: 20),
      ));
      widgets.add(Container(
          margin: EdgeInsets.only(bottom: 30),
          height: 50,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: times.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      left: index == 0 ? 20 : 16,
                      right: index == times.length - 1 ? 20 : 0),
                  child: DmSelectTableBox(
                    isSelected: (selectedTime == times[index] &&
                        selectedTheater == theater),
                    width: 90,
                    height: 50,
                    text: '${times[index]}:00',
                    isEnabled: (times[index] > DateTime.now().hour) ||
                        (selectedDate.day != DateTime.now().day),
                    textStyle: dmWhiteTextFont.copyWith(fontSize: 16),
                    onTap: () {
                      if ((times[index] > DateTime.now().hour) ||
                          (selectedDate.day != DateTime.now().day)) {
                        setState(() {
                          selectedTime = times[index];
                          selectedTheater = theater;
                        });
                      }
                    },
                  ),
                );
              })));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
