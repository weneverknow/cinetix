part of 'widgets.dart';

class BackIcon extends StatelessWidget {
  final Color color;
  final double size;
  final IconData icon;
  final Function onTap;
  BackIcon(
      {this.color = Colors.white,
      this.size = 18,
      this.onTap,
      this.icon = Icons.arrow_back_ios_outlined});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        Icons.arrow_back_ios_outlined,
        color: color,
        size: size,
      ),
    );
  }
}
