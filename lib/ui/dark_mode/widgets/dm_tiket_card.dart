part of 'widgets.dart';

class DmTiketCard extends StatelessWidget {
  final int index;
  final double width;
  final List<Ticket> sortedTickets;

  const DmTiketCard({Key key, this.index, this.width, this.sortedTickets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
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
                        image: (sortedTickets[index].movieDetail.posterPath ??
                                    '') ==
                                ''
                            ? AssetImage('assets/images/bg_topup_dm.png')
                            : NetworkImage(imageBaseURL +
                                'w500' +
                                sortedTickets[index].movieDetail.posterPath),
                        fit: BoxFit.cover))),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(sortedTickets[index].movieDetail.title,
                    style: dmWhiteTextFont.copyWith(
                        fontSize: 18, fontWeight: FontWeight.w600)),
                Text(
                    NumberFormat.currency(
                            locale: 'id_ID', symbol: 'IDR ', decimalDigits: 0)
                        .format((sortedTickets[index].totalPrice)),
                    style: dmWhiteTextFont.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: dmRedColor)),
                Text(
                  sortedTickets[index].theater.name,
                  style: dmGreyTextFont.copyWith(
                      fontSize: 12, fontWeight: FontWeight.w500),
                )
              ],
            )
          ],
        ));
  }
}
