import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  String _title;
  Timestamp _time;
  String _detail;

  DocumentReference _reference;

  DocumentReference get reference => _reference;
}
