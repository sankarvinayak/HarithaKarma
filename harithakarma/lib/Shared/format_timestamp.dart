import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatTimestamp(Timestamp timestamp) {
  var format = new DateFormat('y-MM-d');
  return format.format(timestamp.toDate());
}
