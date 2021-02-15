part of 'dm_pages.dart';

class DmSelectSeatPage extends StatefulWidget {
  final Ticket ticket;
  DmSelectSeatPage(this.ticket);
  @override
  _DmSelectSeatPageState createState() => _DmSelectSeatPageState();
}

class _DmSelectSeatPageState extends State<DmSelectSeatPage> {
  List<String> selectedSeat = [];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .read<PageBloc>()
            .add(GoToSelectSchedulePage(widget.ticket.movieDetail));
        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(color: dmMainColor),
            SafeArea(
              child: Container(color: dmBgColor),
            ),
            SafeArea(
                child: Stack(
              children: [
                HeaderBackdrop(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  context.read<PageBloc>().add(
                                      GoToSelectSchedulePage(
                                          widget.ticket.movieDetail));
                                },
                                child: BackIcon()),
                            SizedBox(
                              width: 200,
                              height: 62,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      height: 62,
                                      width: 130,
                                      child: Text(
                                        widget.ticket.movieDetail.title,
                                        style: dmWhiteTextFont.copyWith(
                                          fontSize: 20,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.end,
                                      )),
                                  Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                              image: NetworkImage(imageBaseURL +
                                                  'w154' +
                                                  widget.ticket.movieDetail
                                                      .backdropPath),
                                              fit: BoxFit.cover)))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 84,
                          width: 277,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/screen.png'),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      SizedBox(height: 7),
                      generateSeats(),
                      SizedBox(height: 30),
                      FloatingActionButton(
                          onPressed: () {
                            context.read<PageBloc>().add(GoToCheckoutPage(
                                widget.ticket.copyWith(seats: selectedSeat)));
                          },
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          child: DmDefaultCircleButton(
                            boxColor: (selectedSeat.length > 0)
                                ? dmMainColor
                                : Colors.transparent,
                            borderColor: (selectedSeat.length > 0)
                                ? Colors.transparent
                                : Color(0xFF292929),
                            iconColor: (selectedSeat.length > 0)
                                ? Colors.white
                                : Color(0xFF292929),
                          )),
                      SizedBox(height: 20),
                    ],
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  Column generateSeats() {
    List<int> numberOfSeats = [3, 5, 5, 5, 5];
    List alphaSeat = ["A", "B", "C", "D", "E"];
    List numberSeat = [
      "1",
      "2",
      "3",
      "4",
      "5",
    ];

    List<Widget> widgets = [];
    for (int i = 0; i < numberOfSeats.length; i++) {
      widgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            numberOfSeats[i],
            (index) => Padding(
                  padding: EdgeInsets.only(
                      right: (index < numberOfSeats[i] - 1) ? 16 : 0,
                      bottom: 16),
                  child: Seat(
                    "${alphaSeat[i]}${index + 1}",
                    (selectedSeat == null)
                        ? false
                        : selectedSeat.contains("${alphaSeat[i]}${index + 1}"),
                    () {
                      String seatNumber = "${alphaSeat[i]}${index + 1}";
                      setState(() {
                        if (selectedSeat.length > 0) {
                          if (selectedSeat.contains(seatNumber)) {
                            selectedSeat.remove(seatNumber);
                          } else {
                            if (index != 0) {
                              selectedSeat.add(seatNumber);
                            }
                          }
                        } else {
                          selectedSeat.add(seatNumber);
                        }
                      });
                    },
                    (index != 0),
                  ),
                )),
      ));
    }
    return Column(
      children: widgets,
    );
  }
}
