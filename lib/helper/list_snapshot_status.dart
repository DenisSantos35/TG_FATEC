

import 'package:get/get.dart';

class ListSnapshotStatus{
  ListSnapshotStatus();

  List data(List snapshot, bool status) {
    List _dataSnapshot = [].obs;
    snapshot.forEach((element) {
      if (element["status"] == status) {
        _dataSnapshot.add(element);
      }
    });
    return _dataSnapshot.obs;
  }
}