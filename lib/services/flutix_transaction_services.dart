part of 'services.dart';

class FlutixTransactionServices {
  static CollectionReference transactionCollection =
      Firestore.instance.collection('transaction');

  static Future<void> saveTransaction(
      FlutixTransaction flutixTransaction) async {
    await transactionCollection.doc().set({
      'userId': flutixTransaction.userID,
      'title': flutixTransaction.title,
      'subtitle': flutixTransaction.subtitle,
      'time': flutixTransaction.time.millisecondsSinceEpoch,
      'amount': flutixTransaction.amount,
      'picture': flutixTransaction.picture
    });
  }

  static Future<List<FlutixTransaction>> getTransaction(String userID) async {
    QuerySnapshot snapshot = await transactionCollection.get();
    var documents =
        snapshot.docs.where((element) => element.data()['userId'] == userID);

    // var documents =
    //     snapshot.docs.where((element) => element.data()['userID'] == userID);
    print("getTransaction result : " + documents.toString());
    return documents
        .map((e) => FlutixTransaction(
            userID: e.data()['userId'],
            title: e.data()['title'],
            subtitle: e.data()['subtitle'],
            time: DateTime.fromMillisecondsSinceEpoch(e.data()['time']),
            amount: e.data()['amount'],
            picture: e.data()['picture']))
        .toList();
  }
}
