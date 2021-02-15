part of 'dm_pages.dart';

class DmTopUpPage extends StatefulWidget {
  final PageEvent pageEvent;
  DmTopUpPage(this.pageEvent);
  @override
  _DmTopUpPageState createState() => _DmTopUpPageState();
}

class _DmTopUpPageState extends State<DmTopUpPage> {
  TextEditingController amountController = TextEditingController(text: 'IDR 0');
  int selectedAmount;
  bool isProcess = false;

  @override
  void initState() {
    super.initState();

    selectedAmount = 0;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    context.select<ThemeBloc, ThemeData>((theme) {
      return (ThemeData().copyWith(primaryColor: Colors.white));
    });
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(widget.pageEvent);
        return;
      },
      child: Scaffold(
          body: Stack(
        children: [
          Container(color: dmMainColor),
          SafeArea(
              child: Container(
            color: dmBgColor,
          )),
          SafeArea(
            child: HeaderBackdrop(),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 20),
                Stack(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: GestureDetector(
                        onTap: () {
                          context.read<PageBloc>().add(widget.pageEvent);
                        },
                        child: BackIcon()),
                  ),
                  Center(child: DmHeaderTitle('Isi Saldo'))
                ]),
                BlocBuilder<UserBloc, UserState>(builder: (context, userState) {
                  if (userState is UserLoaded) {
                    Users users = userState.users;
                    return DmTopUpBalanceCard(
                        users: users, selectedAmount: selectedAmount);
                  } else {
                    return Center(
                        child:
                            SpinKitFadingCircle(size: 50, color: dmMainColor));
                  }
                }),
                Container(
                    margin: EdgeInsets.fromLTRB(20, 31, 20, 15),
                    width: size.width,
                    height: 56,
                    child: TextField(
                        onChanged: (text) {
                          String temp = '';
                          for (int i = 0; i < text.length; i++) {
                            temp += text.isDigit(i) ? text[i] : '';
                          }
                          setState(() {
                            selectedAmount = int.tryParse(temp) ?? 0;
                          });

                          amountController.text = NumberFormat.currency(
                                  locale: 'id_ID',
                                  symbol: 'IDR ',
                                  decimalDigits: 0)
                              .format(selectedAmount);

                          amountController.selection =
                              TextSelection.fromPosition(TextPosition(
                                  affinity: TextAffinity.upstream,
                                  offset: amountController.text.length));
                        },
                        controller: amountController,
                        style: dmWhiteTextFont.copyWith(fontSize: 16),
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(color: Colors.white)),
                            labelText: 'Nominal',
                            labelStyle: dmWhiteTextFont))),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: DmSectionLabel('Pilih Nominal')),
                Container(
                    width: size.width,
                    //height: 250,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Wrap(
                      children: [
                        makeMoneyCard(50000),
                        makeMoneyCard(100000),
                        makeMoneyCard(150000),
                        makeMoneyCard(200000),
                        makeMoneyCard(250000),
                        makeMoneyCard(300000),
                        makeMoneyCard(500000),
                        makeMoneyCard(1000000),
                        makeMoneyCard(1500000)
                      ],
                    )),
                isProcess
                    ? Container(
                        margin: EdgeInsets.only(top: 40),
                        child: Center(
                            child: SpinKitFadingCircle(
                                color: dmMainColor, size: 30)))
                    : BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
                        if (userState is UserLoaded) {
                          return Container(
                              margin: EdgeInsets.only(top: 40),
                              width: 260,
                              height: 36,
                              decoration: BoxDecoration(
                                  color: selectedAmount > 0
                                      ? dmMainColor
                                      : Color(0xFF292929),
                                  borderRadius: BorderRadius.circular(15)),
                              child: FlatButton(
                                  onPressed: () {
                                    if (selectedAmount > 0) {
                                      setState(() {
                                        isProcess = true;
                                      });
                                      FlutixTransaction transaction =
                                          FlutixTransaction(
                                              userID: userState.users.id,
                                              title: 'Isi Saldo',
                                              amount: selectedAmount,
                                              subtitle: DateTime.now().dayName +
                                                  ', ' +
                                                  DateTime.now()
                                                      .day
                                                      .toString() +
                                                  ' ' +
                                                  DateTime.now().monthName +
                                                  ' ' +
                                                  DateTime.now()
                                                      .year
                                                      .toString(),
                                              time: DateTime.now());
                                      context.read<PageBloc>().add(
                                          GoToSuccessPage(null, transaction,
                                              pageEvent: widget.pageEvent));
                                    }
                                  },
                                  child: Center(
                                      child: Text(
                                    'TOP UP',
                                    style: dmWhiteTextFont.copyWith(
                                        color: selectedAmount > 0
                                            ? Colors.white
                                            : Color(0xFF666565),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ))));
                        } else {
                          return SizedBox();
                        }
                      })
              ],
            ),
          )
        ],
      )),
    );
  }

  Widget makeMoneyCard(int amount) {
    return DmMoneyCard(amount, onTap: () {
      setState(() {
        if (selectedAmount == amount) {
          selectedAmount = 0;
        } else {
          selectedAmount = amount;
        }
      });
      amountController.text = NumberFormat.currency(
              locale: 'id_ID', symbol: 'IDR ', decimalDigits: 0)
          .format(selectedAmount);

      amountController.selection = TextSelection.fromPosition(TextPosition(
          affinity: TextAffinity.upstream,
          offset: amountController.text.length));
    }, isSelected: (selectedAmount == amount));
  }
}
