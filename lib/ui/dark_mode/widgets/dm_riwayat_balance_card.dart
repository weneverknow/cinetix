part of 'widgets.dart';

class DmRiwayatBalanceCard extends StatelessWidget {
  final Users users;
  DmRiwayatBalanceCard(this.users);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 317,
      height: 210,
      child: Stack(
        children: [
          Positioned(
              right: 2,
              top: 2,
              child: Container(
                  width: 300,
                  height: 185,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        blurRadius: 6,
                        spreadRadius: -1,
                        color: Color(0xFF6E6E6E),
                        offset: Offset(0, 0))
                  ]))),
          Positioned(
            right: 2,
            top: 2,
            child: Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                    child: Container(
                      width: 300,
                      height: 185,
                      decoration: BoxDecoration(
                        color: Color(0xFFDAD8D8).withOpacity(0.1),
                      ),
                    ),
                  )),
            ),
          ),
          Positioned(
              right: 13,
              top: 13,
              child: Container(
                  width: 300,
                  height: 185,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 3,
                            spreadRadius: 1,
                            color: Color(0xFF4B4B4B),
                            offset: Offset(0, 0))
                      ],
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            dmMainColor.withOpacity(0.5),
                            dmYellowColor.withOpacity(0.4),
                          ])),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 25, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 60,
                                height: 35,
                                child: Row(
                                  children: [
                                    Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: dmRedColor)),
                                    SizedBox(width: 5),
                                    Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: dmYellowColor))
                                  ],
                                )),
                            Text('CineCard',
                                style: dmWhiteTextFont.copyWith(
                                    fontSize: 18, fontWeight: FontWeight.w300))
                          ],
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 35, left: 20),
                          width: 270,
                          child: Text(
                              NumberFormat.currency(
                                      locale: 'id_ID',
                                      symbol: 'IDR ',
                                      decimalDigits: 0)
                                  .format((users.balance)),
                              style: dmGreyTextFont.copyWith(
                                  fontSize: 24, fontWeight: FontWeight.w500))),
                      Container(
                          margin: EdgeInsets.only(left: 20, top: 15),
                          width: 120,
                          alignment: Alignment.centerRight,
                          child: Text(users.id.substring(0, 8).toUpperCase(),
                              textAlign: TextAlign.end,
                              style: dmGreyTextFont.copyWith(
                                  fontSize: 10, fontWeight: FontWeight.w300))),
                      Container(
                          margin: EdgeInsets.only(left: 20, top: 2),
                          width: 120,
                          alignment: Alignment.centerRight,
                          child: Text(users.name.toUpperCase(),
                              style: dmWhiteTextFont.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                              maxLines: 2,
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.clip))
                    ],
                  )))
        ],
      ),
    );
  }
}
