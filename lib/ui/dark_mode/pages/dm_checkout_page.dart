part of 'dm_pages.dart';

class DmCheckoutPage extends StatelessWidget {
  final Ticket ticket;
  DmCheckoutPage(this.ticket);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToSelectSeatPage(ticket));
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
              BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
                if (userState is UserLoaded) {
                  Users users = (userState).users;
                  int totalPrice = (ticket.seats.length * 25000) + 2000;
                  bool isValid = users.balance >= totalPrice;
                  return Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                            top: 22,
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: GestureDetector(
                                    onTap: () {
                                      context
                                          .read<PageBloc>()
                                          .add(GoToSelectSeatPage(ticket));
                                    },
                                    child: BackIcon()),
                              ),
                              Center(child: DmHeaderTitle('Konfirmasi Tiket')),
                            ],
                          )),
                      Container(
                          width: size.width,
                          height: 90,
                          margin: EdgeInsets.only(top: 51, left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  height: 90,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                          image: NetworkImage(imageBaseURL +
                                              'w500' +
                                              ticket.movieDetail.backdropPath),
                                          fit: BoxFit.cover))),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(ticket.movieDetail.title,
                                      style: dmWhiteTextFont.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(height: 6),
                                  Text(ticket.movieDetail.genresAndLanguage,
                                      style: dmGreyTextFont.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400)),
                                  SizedBox(height: 6),
                                  RatingStars(
                                    voteAverage: ticket.movieDetail.voteAverage,
                                    fontSize: 12,
                                    textColor: Color(0xFFADADAD),
                                  )
                                ],
                              )
                            ],
                          )),
                      Container(
                        width: size.width,
                        height: 1,
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        color: dmGreyColor,
                      ),
                      DmKonfirmasiTiketDetail(
                          width: size.width,
                          label: 'ID Order',
                          text: ticket.bookingCode),
                      SizedBox(height: 10),
                      DmKonfirmasiTiketDetail(
                          width: size.width,
                          label: 'Bioskop',
                          text: ticket.theater.name),
                      SizedBox(height: 10),
                      DmKonfirmasiTiketDetail(
                        width: size.width,
                        label: 'Tanggal/Jam',
                        text: ticket.time.shortDayName +
                            " " +
                            ticket.time.day.toString() +
                            ", " +
                            ticket.time.hour.toString() +
                            ":00",
                      ),
                      SizedBox(height: 10),
                      DmKonfirmasiTiketDetail(
                          width: size.width,
                          label: 'No. Kursi',
                          text: ticket.seatsInString),
                      SizedBox(height: 10),
                      DmKonfirmasiTiketDetail(
                          width: size.width,
                          label: 'Harga',
                          text: NumberFormat.currency(
                                decimalDigits: 0,
                                locale: 'id_ID',
                                symbol: 'Rp ',
                              ).format(25000) +
                              ' x ' +
                              ticket.seats.length.toString()),
                      SizedBox(height: 10),
                      DmKonfirmasiTiketDetail(
                          width: size.width,
                          label: 'Biaya',
                          labelColor: dmRedColor,
                          text: NumberFormat.currency(
                            decimalDigits: 0,
                            locale: 'id_ID',
                            symbol: 'Rp ',
                          ).format(2000)),
                      SizedBox(height: 10),
                      DmKonfirmasiTiketDetail(
                        width: size.width,
                        label: 'Total',
                        text: NumberFormat.currency(
                          decimalDigits: 0,
                          locale: 'id_ID',
                          symbol: 'Rp ',
                        ).format(totalPrice),
                        textStyle: dmWhiteTextFont.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          width: size.width,
                          height: 1,
                          color: dmGreyColor),
                      SizedBox(height: 20),
                      DmKonfirmasiTiketDetail(
                        width: size.width,
                        label: 'Saldo Anda',
                        text: NumberFormat.currency(
                          decimalDigits: 0,
                          locale: 'id_ID',
                          symbol: 'Rp ',
                        ).format(users.balance),
                        textStyle: dmWhiteTextFont.copyWith(
                            fontSize: 16,
                            color: dmYellowColor,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 51),
                      DmDefaultButton(
                          width: 250,
                          height: 45,
                          color: !isValid ? dmRedColor : dmMainColor,
                          onTap: () {
                            if (isValid) {
                              context.bloc<PageBloc>().add(GoToSuccessPage(
                                  ticket.copyWith(totalPrice: totalPrice),
                                  FlutixTransaction(
                                    userID: users.id,
                                    title: ticket.movieDetail.title,
                                    subtitle: ticket.theater.name,
                                    amount: -1 * totalPrice,
                                    picture: ticket.movieDetail.posterPath,
                                    time: DateTime.now(),
                                  )));
                            } else {
                              context.read<PageBloc>().add(GoToTopUpPage(
                                  GoToCheckoutPage(ticket.copyWith(
                                      totalPrice: totalPrice))));
                            }
                          },
                          child: Center(
                              child: Text(!isValid ? 'ISI SALDO' : 'BAYAR',
                                  style: dmWhiteTextFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600))))
                    ],
                  );
                } else {
                  return SizedBox();
                }
              }),
            ],
          ))
        ],
      )),
    );
  }
}
