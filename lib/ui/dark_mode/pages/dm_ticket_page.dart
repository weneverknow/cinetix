part of 'dm_pages.dart';

class DmTicketPage extends StatefulWidget {
  final bool isExpiredTicket;
  DmTicketPage({this.isExpiredTicket = false});
  @override
  _DmTicketPageState createState() => _DmTicketPageState();
}

class _DmTicketPageState extends State<DmTicketPage> {
  bool isExpired;
  @override
  void initState() {
    super.initState();
    isExpired = widget.isExpiredTicket;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          color: dmMainColor,
        ),
        SafeArea(child: Container(color: dmBgColor)),
        SafeArea(
          child: Stack(children: [
            HeaderBackdrop(),
            Column(
              children: [
                Container(
                    width: size.width,
                    height: 100,
                    color: dmMainColor,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Text('Tiket Ku',
                              style: dmWhiteTextFont.copyWith(
                                  fontSize: 24, fontWeight: FontWeight.w700)),
                        ),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            child: DmTiketTopButton(
                              isExpired: isExpired,
                              color: isExpired
                                  ? Colors.transparent
                                  : Color(0xFF096143),
                              text: 'Terkini',
                              onTap: () {
                                setState(() {
                                  isExpired = false;
                                });
                              },
                              width: size.width * 0.5,
                            )),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: DmTiketTopButton(
                              isExpired: isExpired,
                              color: !isExpired
                                  ? Colors.transparent
                                  : Color(0xFF096143),
                              text: 'Riwayat',
                              onTap: () {
                                setState(() {
                                  isExpired = true;
                                });
                              },
                              width: size.width * 0.5,
                            ))
                      ],
                    )),
                Expanded(child:
                    BlocBuilder<TicketBloc, TicketState>(builder: (_, state) {
                  if (state is TicketState) {
                    List<Ticket> tickets = state.tickets
                        .where((ticket) => isExpired
                            ? ticket.time.isBefore(DateTime.now())
                            : !ticket.time.isBefore(DateTime.now()))
                        .toList();
                    var sortedTickets = tickets;
                    sortedTickets.sort((ticket1, ticket2) =>
                        ticket1.time.compareTo(ticket2.time));
                    return ListView.builder(
                        itemCount: sortedTickets.length,
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                context
                                    .read<PageBloc>()
                                    .add(GoToTicketDetailPage(tickets[index]));
                              },
                              child: DmTiketCard(
                                index: index,
                                width: size.width,
                                sortedTickets: sortedTickets,
                              ),
                            ));
                  } else {
                    return Center(
                        child:
                            SpinKitFadingCircle(color: dmMainColor, size: 50));
                  }
                }))
              ],
            )
          ]),
        )
      ],
    ));
  }
}
