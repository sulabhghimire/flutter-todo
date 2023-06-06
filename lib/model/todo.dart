import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

enum Category { urgent, normal, low }

class Todo {
  final String title;
  final DateTime deadline;
  final Category category;

  const Todo({
    required this.title,
    required this.deadline,
    required this.category,
  });

  String get formattedDate {
    return formatter.format(deadline);
  }
}
