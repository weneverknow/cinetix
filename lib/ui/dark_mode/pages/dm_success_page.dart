part of 'dm_pages.dart';

class DmSuccessPage extends StatelessWidget {
  final Ticket ticket;
  final FlutixTransaction transaction;
  final PageEvent pageEvent;
  DmSuccessPage(this.ticket, this.transaction, {this.pageEvent});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
          future: ticket == null
              ? processTopUp(context)
              : processBuyTicket(context),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SizedBox(
                  width: size.width,
                  child: Stack(
                    children: [
                      Container(
                        color: dmMainColor,
                      ),
                      SafeArea(child: Container(color: dmBgColor)),
                      SafeArea(
                          child: Stack(
                        children: [
                          HeaderBackdrop(),
                          SizedBox(
                              width: size.width,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(ticket == null
                                                    ? 'assets/images/ill_top_up_dm.png'
                                                    : 'assets/images/ill_tickets.png'),
                                                fit: BoxFit.cover))),
                                    SizedBox(height: 78),
                                    Text('Selamat',
                                        style: dmWhiteTextFont.copyWith(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(height: 11),
                                    Text(
                                        ticket == null
                                            ? 'Top Up Saldo Anda Berhasil'
                                            : 'Pembelian Tiket Anda Berhasil',
                                        style: dmGreyTextFont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300)),
                                    SizedBox(height: 62),
                                    ticket == null
                                        ? DmDefaultButton(
                                            width: 250,
                                            height: 45,
                                            color: dmMainColor,
                                            onTap: () {
                                              context.read<PageBloc>().add(
                                                  GoToWalletPage(pageEvent));
                                            },
                                            child: Center(
                                                child: Text('SALDO KU',
                                                    style: dmWhiteTextFont
                                                        .copyWith(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500))),
                                          )
                                        : DmDefaultButton(
                                            width: 250,
                                            height: 45,
                                            color: dmMainColor,
                                            onTap: () {
                                              context.read<PageBloc>().add(
                                                  GoToMainPage(
                                                      bottomNavBarIndex: 2,
                                                      isExpired: false));
                                            },
                                            child: Center(
                                                child: Text('TIKET KU',
                                                    style: dmWhiteTextFont
                                                        .copyWith(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500))),
                                          ),
                                    SizedBox(height: 15),
                                    DmSecondaryButton(
                                      width: 250,
                                      height: 45,
                                      onTap: () {
                                        context
                                            .read<PageBloc>()
                                            .add(pageEvent ?? GoToMainPage());
                                      },
                                      child: Center(
                                          child: Text('BERANDA',
                                              style: dmWhiteTextFont.copyWith(
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.w500))),
                                    ),
                                  ]))
                        ],
                      ))
                    ],
                  ));
            } else {
              return Stack(
                children: [
                  Container(color: dmMainColor),
                  SafeArea(child: Container(color: dmBgColor)),
                  SafeArea(
                      child: Stack(
                    children: [
                      HeaderBackdrop(),
                      Center(
                          child: SpinKitFadingCircle(
                              size: 100, color: dmMainColor))
                    ],
                  ))
                ],
              );
            }
          }),
    );
  }

  Future<void> processTopUp(BuildContext context) async {
    context.bloc<UserBloc>().add(TopUp(transaction.amount));
    await FlutixTransactionServices.saveTransaction(transaction);
  }

  Future<void> processBuyTicket(BuildContext context) async {
    context.bloc<UserBloc>().add(Purchase(ticket.totalPrice));
    context.bloc<TicketBloc>().add(BuyTicket(ticket, transaction.userID));

    await FlutixTransactionServices.saveTransaction(transaction);
  }
}
