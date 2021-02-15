part of 'dm_pages.dart';

class DmTicketToday extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToMainPage());
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 20),
                      child: GestureDetector(
                          onTap: () {
                            context.read<PageBloc>().add(GoToMainPage());
                          },
                          child: BackIcon()),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 20),
                        child:
                            Center(child: DmHeaderTitle('Tiket Anda Hari Ini')))
                  ]),
                  SizedBox(height: 20),
                  Expanded(child: BlocBuilder<UserBloc, UserState>(
                      builder: (context, userState) {
                    if (userState is UserLoaded) {
                      return FutureBuilder(
                          future: TicketServices.getTicketsNotifications(
                              userState.users.id),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                List<Ticket> tickets = snapshot.data;
                                var filteredTickets = tickets.where((ticket) {
                                  return (ticket.time
                                              .difference(DateTime.now()) >=
                                          Duration(hours: 10)) &&
                                      (ticket.time.difference(DateTime.now()) <
                                          Duration(hours: 20));
                                }).toList();
                                //filteredTickets.
                                return ListView.builder(
                                    itemCount: filteredTickets.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          context.read<PageBloc>().add(
                                              GoToTicketDetailPage(
                                                  filteredTickets[index],
                                                  pageEvent:
                                                      GoToTicketToday()));
                                        },
                                        child: DmTiketCard(
                                            width: size.width,
                                            index: index,
                                            sortedTickets: filteredTickets),
                                      );
                                    });
                              } else {
                                return Padding(
                                    padding: EdgeInsets.only(
                                      top: 30,
                                      left: 20,
                                    ),
                                    child: Text(
                                        'Anda tidak membeli tiket untuk jadwal hari ini',
                                        style: dmRedTextFont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)));
                              }
                            } else {
                              return Container(
                                  width: size.width,
                                  height: 60,
                                  child: Center(
                                      child: SpinKitFadingCircle(
                                          size: 50, color: dmMainColor)));
                            }
                          });
                    } else {
                      return SizedBox();
                    }
                  }))
                ],
              ),
            ],
          ))
        ],
      )),
    );
  }
}
