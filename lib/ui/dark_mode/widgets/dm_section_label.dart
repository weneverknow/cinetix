part of 'widgets.dart';

class DmSectionLabel extends StatelessWidget {
  final String label;
  final double leftPadding;
  DmSectionLabel(this.label, {this.leftPadding = 24});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding, bottom: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(label,
            style: dmWhiteTextFont.copyWith(
                fontWeight: FontWeight.w700, fontSize: 14)),
      ),
    );
  }
}
