
import 'package:intl/intl.dart';

String convertCount(int count) {
  if (count < 10000) {
    return "已售$count笔";
  } else {
    return "已售${(count / 10000).toStringAsFixed(1)}万笔";
  }
}

String convertDate(int timestamp) {
  if ("$timestamp".length == 10) timestamp = timestamp * 1000;
  var now = new DateTime.now();
  var format = new DateFormat('yyyy-MM-dd HH:mm');
  var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
  var diff = date.difference(now);
  var time = format.format(date);

//  if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
//    time = format.format(date); // Doesn't get called when it should be
//  } else {
//    time = diff.inDays.toString() + 'DAYS AGO'; // Gets call and it's wrong date
//  }

  return time;
}
