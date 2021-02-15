part of 'dm_pages.dart';

class DmTicketDetailPage extends StatelessWidget {
  final Ticket ticket;
  final PageEvent pageEvent;

  DmTicketDetailPage(this.ticket, {this.pageEvent});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    int lebarDash = ((size.width - 80) / 12).toInt();
    return WillPopScope(
      onWillPop: () async {
        context
            .read<PageBloc>()
            .add(pageEvent ?? GoToMainPage(bottomNavBarIndex: 2));
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
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: GestureDetector(
                            onTap: () {
                              context.read<PageBloc>().add(pageEvent ??
                                  GoToMainPage(bottomNavBarIndex: 2));
                            },
                            child: BackIcon()),
                      ),
                      Container(
                        width: size.width,
                        margin: EdgeInsets.only(top: 20),
                        alignment: Alignment.center,
                        child: DmHeaderTitle('Detil Tiket'),
                      )
                    ],
                  ),
                  SizedBox(height: 32),
                  Container(
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 170,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)),
                          image: DecorationImage(
                              image: NetworkImage(imageBaseURL +
                                  'w500' +
                                  ticket.movieDetail.backdropPath),
                              fit: BoxFit.fitWidth))),
                  ClipPath(
                    clipper: TicketTopClipper(),
                    child: ticketDetailTopContainer(size),
                  ),
                  Wrap(
                    children: List.generate(
                        lebarDash,
                        (index) => Container(
                            width: 12,
                            height: 1,
                            child: Divider(
                              indent: 3,
                              endIndent: 3,
                              thickness: 1.5,
                              color: Colors.white,
                            ))),
                  ),
                  ClipPath(
                    clipper: TicketBottomClipper(),
                    child: ticketDetailBottomContainer(size),
                  )
                ],
              )
            ],
          ))
        ],
      )),
    );
  }

  Widget ticketDetailBottomContainer(Size size) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
        width: size.width,
        height: 130,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Nama',
                    style: dmGreyTextFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w500)),
                Text(ticket.name,
                    style: dmWhiteTextFont.copyWith(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
                Text('Total',
                    style: dmGreyTextFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w500)),
                Text(
                    NumberFormat.currency(
                            locale: 'id_ID', decimalDigits: 0, symbol: 'Rp  ')
                        .format(ticket.totalPrice),
                    style: dmWhiteTextFont.copyWith(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500))
              ],
            ),
            Container(
                width: 100,
                height: 100,
                child: QrImage(
                  data: ticket.bookingCode,
                  backgroundColor: Colors.white,
                  version: QrVersions.auto,
                ))
          ],
        ));
  }

  Widget ticketDetailTopContainer(Size size) {
    return Container(
        width: size.width,
        height: 260,
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 16, 20, 6),
              width: double.infinity,
              child: Text(ticket.movieDetail.title,
                  style: dmWhiteTextFont.copyWith(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.clip),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 6),
              child: Text(
                ticket.movieDetail.genresAndLanguage,
                style: dmGreyTextFont.copyWith(
                    fontSize: 12, fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.clip,
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 16),
                child: RatingStars(
                  voteAverage: ticket.movieDetail.voteAverage,
                  starSize: 16,
                  fontSize: 11,
                  textColor: dmGreyColor,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bioskop',
                        style: dmGreyTextFont.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    Container(
                        width: size.width - 40 - 150,
                        child: Text(ticket.theater.name,
                            textAlign: TextAlign.end,
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                            style: dmWhiteTextFont.copyWith(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)))
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tanggal/Jam',
                        style: dmGreyTextFont.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    Container(
                        width: size.width - 40 - 150,
                        child: Text(
                            ticket.time.shortDayName +
                                ' ' +
                                ticket.time.day.toString() +
                                ', ' +
                                ticket.time.hour.toString() +
                                ':00',
                            textAlign: TextAlign.end,
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                            style: dmWhiteTextFont.copyWith(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)))
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('No. Kursi',
                        style: dmGreyTextFont.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    Container(
                        width: size.width - 40 - 150,
                        child: Text(ticket.seatsInString,
                            textAlign: TextAlign.end,
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                            style: dmWhiteTextFont.copyWith(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)))
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ID Transaksi',
                        style: dmGreyTextFont.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    Container(
                        width: size.width - 40 - 150,
                        child: Text(ticket.bookingCode,
                            textAlign: TextAlign.end,
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                            style: dmWhiteTextFont.copyWith(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)))
                  ]),
            )
          ],
        ));
  }
}

class TicketBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width * 0.1, 0);
    path.quadraticBezierTo(size.width * 0.09, size.height - (size.height - 29),
        0, size.height - (size.height - 30));
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height - (size.height - 30));
    path.quadraticBezierTo(size.width * 0.92, size.height - (size.height - 30),
        size.width * 0.9, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TicketTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(
        size.width * 0.09, size.height - 29, size.width * 0.1, size.height);
    path.lineTo(size.width * 0.9, size.height);
    path.quadraticBezierTo(
        size.width * 0.92, size.height - 29, size.width, size.height - 30);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
