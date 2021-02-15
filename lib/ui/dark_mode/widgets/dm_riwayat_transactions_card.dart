part of 'widgets.dart';

class DmRiwayatTransactionsCard extends StatelessWidget {
  final int index;
  final List<FlutixTransaction> sortedData;
  final Size size;

  const DmRiwayatTransactionsCard(
      {Key key, this.sortedData, this.size, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size.width,
        height: 90,
        margin: EdgeInsets.only(left: 20, right: 20, top: 15),
        child: Row(
          children: [
            Container(
                width: 70,
                height: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: (sortedData[index].picture ?? '') == ''
                            ? AssetImage('assets/images/bg_topup_dm.png')
                            : NetworkImage(imageBaseURL +
                                'w500' +
                                sortedData[index].picture),
                        fit: BoxFit.cover))),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(sortedData[index].title,
                    style: dmWhiteTextFont.copyWith(
                        fontSize: 18, fontWeight: FontWeight.w600)),
                Text(
                    NumberFormat.currency(
                            locale: 'id_ID', symbol: 'IDR ', decimalDigits: 0)
                        .format(sortedData[index].amount < 0
                            ? (sortedData[index].amount * -1)
                            : sortedData[index].amount),
                    style: dmWhiteTextFont.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: sortedData[index].amount < 0
                            ? dmRedColor
                            : dmMainColor)),
                Text(
                  sortedData[index].subtitle,
                  style: dmGreyTextFont.copyWith(
                      fontSize: 12, fontWeight: FontWeight.w500),
                )
              ],
            )
          ],
        ));
  }
}
