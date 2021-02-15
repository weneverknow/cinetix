part of 'widgets.dart';

class DmHeaderTitle extends StatelessWidget {
  final String text;
  DmHeaderTitle(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: dmWhiteTextFont.copyWith(
            fontSize: 18, fontWeight: FontWeight.w500));
  }
}
