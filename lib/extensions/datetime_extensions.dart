import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String get formatted =>
      DateFormat('yyyy-MM-dd – kk:mm').format(this);

  String get onlyDate => DateFormat('yyyy-MM-dd').format(this);

  String get relativeTime {
    final Duration diff = DateTime.now().difference(this);
    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return onlyDate;
  }
}
