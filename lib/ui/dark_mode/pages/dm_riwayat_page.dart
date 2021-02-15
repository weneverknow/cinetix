part of 'dm_pages.dart';

class DmRiwayatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () async {
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
                      Users users = userState.users;
                      return SizedBox(
                          width: size.width,
                          child: Column(
                            //scrollDirection: Axis.vertical,
                            children: [
                              SizedBox(
                                height: 40,
                              ),
                              Center(child: DmRiwayatBalanceCard(users)),
                              SizedBox(height: 30),
                              DmSectionLabel('Riwayat Transaksi'),
                              Expanded(
                                  child: FutureBuilder(
                                      future: FlutixTransactionServices
                                          .getTransaction(users.id),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          if (snapshot.hasData) {
                                            List<FlutixTransaction> data =
                                                snapshot.data;
                                            var sortedData = data;
                                            sortedData.sort((data1, data2) =>
                                                data2.time
                                                    .compareTo(data1.time));
                                            return ListView.builder(
                                                itemCount: sortedData.length,
                                                itemBuilder: (context, index) {
                                                  return DmRiwayatTransactionsCard(
                                                    index: index,
                                                    size: size,
                                                    sortedData: sortedData,
                                                  );
                                                });
                                          } else {
                                            return Center(
                                                child: SpinKitFadingCircle(
                                                    color: dmMainColor,
                                                    size: 50));
                                          }
                                        } else {
                                          return Center(
                                              child: SpinKitFadingCircle(
                                            color: dmMainColor,
                                            size: 50,
                                          ));
                                        }
                                      })),
                              SizedBox(height: 55)
                            ],
                          ));
                    } else {
                      return Center(
                          child: SpinKitFadingCircle(
                              color: dmMainColor, size: 50));
                    }
                  }),
                ],
              )),
              SafeArea(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          width: size.width,
                          height: 120,
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              context.read<PageBloc>().add(GoToTopUpPage(
                                  GoToMainPage(bottomNavBarIndex: 1)));
                            },
                            child: Container(
                                margin: EdgeInsets.only(right: 10),
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: dmMainColor.withOpacity(0.8)),
                                child: Icon(Icons.play_for_work_outlined,
                                    color: Colors.black.withOpacity(0.54),
                                    size: 25)),
                          ))))
            ],
          ),
        ));
  }
}
