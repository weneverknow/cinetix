part of 'services.dart';

class TicketServices {
  static CollectionReference ticketCollection =
      Firestore.instance.collection("tickets");

  static Future<void> saveTicket(String id, Ticket ticket) async {
    await ticketCollection.doc().set({
      'movieID': ticket.movieDetail.id ?? '',
      'userID': id ?? '',
      'theaterName': ticket.theater.name ?? 0,
      'time': ticket.time.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
      'bookingCode': ticket.bookingCode,
      'seats': ticket.seatsInString,
      'name': ticket.name,
      'totalPrice': ticket.totalPrice
    });
  }

  //get tickets untuk notifications
  static Future<bool> isHasTicketToday(String userId) async {
    QuerySnapshot snapshot = await ticketCollection.get();
    var documents = snapshot.docs
        .where((element) => (element.data()['userID'] == userId))
        .any((element) {
      return ((DateTime.fromMillisecondsSinceEpoch(element.data()['time'])
                  .difference(DateTime.now()) >=
              Duration(hours: 10)) &&
          (DateTime.fromMillisecondsSinceEpoch(element.data()['time'])
                  .difference(DateTime.now()) <
              Duration(hours: 20)));
    });
    print("documents " + documents.toString());

    return documents;
  }

  static Future<List<Ticket>> getTicketsNotifications(String userId) async {
    QuerySnapshot snapshot = await ticketCollection.get();
    var documents =
        snapshot.docs.where((element) => (element.data()['userID'] == userId));

    List<Ticket> tickets = [];
    for (var doc in documents) {
      MovieDetail movieDetail =
          await MovieServices.getDetails(null, movieID: doc.data()['movieID']);
      tickets.add(Ticket(
          movieDetail,
          Theater(doc.data()['theaterName']),
          DateTime.fromMillisecondsSinceEpoch(doc.data()['time']),
          doc.data()['bookingCode'],
          doc.data()['seats'].toString().split(','),
          doc.data()['name'],
          doc.data()['totalPrice']));
    }
    //print("getTicketsNotifications : " + tickets.toString());
    return tickets;
  }

  //get ticket untuk history ticket apa aja yg sudah dibeli
  static Future<List<Ticket>> getTickets(String userId) async {
    QuerySnapshot snapshot = await ticketCollection.get();
    var documents =
        snapshot.docs.where((element) => element.data()['userID'] == userId);
    List<Ticket> tickets = [];
    for (var document in documents) {
      MovieDetail movieDetail = await MovieServices.getDetails(null,
          movieID: document.data()['movieID']);
      tickets.add(Ticket(
          movieDetail,
          Theater(document.data()['theaterName']),
          DateTime.fromMillisecondsSinceEpoch(document.data()['time']),
          document.data()['bookingCode'],
          document.data()['seats'].toString().split(','),
          document.data()['name'],
          document.data()['totalPrice']));
    }

    return tickets;
  }
}
