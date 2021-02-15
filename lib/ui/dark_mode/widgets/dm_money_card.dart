part of 'widgets.dart';

class DmMoneyCard extends StatelessWidget {
  final int money;
  final Function onTap;
  final bool isSelected;
  DmMoneyCard(this.money, {this.onTap, this.isSelected});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: EdgeInsets.all(15),
          width: 90,
          height: 60,
          decoration: BoxDecoration(
              color: isSelected ? dmYellowColor : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: dmGreyColor)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('IDR',
                    style: isSelected
                        ? dmWhiteTextFont.copyWith(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)
                        : dmGreyTextFont.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                Text(
                    NumberFormat.currency(
                            locale: 'id_ID', symbol: '', decimalDigits: 0)
                        .format(money),
                    style: isSelected
                        ? dmWhiteTextFont.copyWith(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)
                        : dmWhiteTextFont.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w500))
              ])),
    );
  }
}
