part of 'dm_pages.dart';

class DmMyWalletPage extends StatelessWidget {
  final PageEvent pageEvent;
  DmMyWalletPage(this.pageEvent);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(pageEvent);
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
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: GestureDetector(
                        onTap: () {
                          context.read<PageBloc>().add(pageEvent);
                        },
                        child: BackIcon()),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [DmHeaderTitle('Saldo-Ku')],
                      ))
                ],
              ),
              BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
                if (userState is UserLoaded) {
                  Users users = userState.users;
                  return SizedBox(
                      width: size.width,
                      child: Column(
                        //scrollDirection: Axis.vertical,
                        children: [
                          SizedBox(
                            height: 60,
                          ),
                          DmRiwayatBalanceCard(users),
                          SizedBox(height: 30),
                          DmSectionLabel('Riwayat Transaksi'),
                          Expanded(
                              child: FutureBuilder(
                                  future:
                                      FlutixTransactionServices.getTransaction(
                                          users.id),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.hasData) {
                                        List<FlutixTransaction> data =
                                            snapshot.data;
                                        var sortedData = data;
                                        sortedData.sort((data1, data2) =>
                                            data2.time.compareTo(data1.time));
                                        return ListView.builder(
                                            itemCount: sortedData.length,
                                            itemBuilder: (context, index) {
                                              return DmRiwayatTransactionsCard(
                                                  sortedData: sortedData,
                                                  size: size,
                                                  index: index);
                                            });
                                      } else {
                                        return Center(
                                            child: SpinKitFadingCircle(
                                                color: dmMainColor, size: 50));
                                      }
                                    } else {
                                      return Center(
                                          child: SpinKitFadingCircle(
                                        color: dmMainColor,
                                        size: 50,
                                      ));
                                    }
                                  })),
                        ],
                      ));
                } else {
                  return Center(
                      child: SpinKitFadingCircle(color: dmMainColor, size: 50));
                }
              })
            ],
          )),
        ],
      )),
    );
  }
}
