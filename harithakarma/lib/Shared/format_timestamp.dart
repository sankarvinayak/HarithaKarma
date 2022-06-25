import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatTimestamp(Timestamp timestamp) {
  var format = new DateFormat('y-MM-d'); // <- use skeleton here
  return format.format(timestamp.toDate());
}
