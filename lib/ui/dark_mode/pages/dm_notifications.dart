part of 'dm_pages.dart';

class DmNotifications extends StatelessWidget {
  final int length;

  const DmNotifications({Key key, this.length}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Icon(
            length > 0 ? Icons.notifications_active : Icons.notifications,
            color: length > 0 ? dmYellowColor : Colors.white,
            size: 20));
  }
}
