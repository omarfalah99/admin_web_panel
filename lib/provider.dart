import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirebaseProvider with ChangeNotifier {
  List _myDataList = [];

  Future<void> getDataList() async {
    final CollectionReference myCollection =
        FirebaseFirestore.instance.collection('admin_cart');
    final QuerySnapshot querySnapshot = await myCollection.get();
    final List<QueryDocumentSnapshot> queryDocumentSnapshotList =
        querySnapshot.docs;
    final List<Object?> dataMapList =
        queryDocumentSnapshotList.map((doc) => doc.data()).toList();
    _myDataList.add(dataMapList);
    notifyListeners();
  }

  List get myDataList => _myDataList;
}
