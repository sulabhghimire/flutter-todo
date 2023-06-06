import 'package:flutter/material.dart';
import 'package:todo/model/todo.dart';

class ToDoItem extends StatefulWidget {
  const ToDoItem({
    required this.todo,
    required this.priority,
    required this.date,
    super.key,
  });

  final String todo;
  final Category priority;
  final String date;

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  var _done = false;

  void _updateCheckBox(bool? isChecked) {
    setState(() {
      _done = isChecked ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var icon = Icons.low_priority;

    if (widget.priority == Category.urgent) {
      icon = Icons.notifications_active;
    }
    if (widget.priority == Category.normal) {
      icon = Icons.list;
    }

    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(value: _done, onChanged: _updateCheckBox),
              const SizedBox(
                width: 8.0,
              ),
              Icon(icon),
              const SizedBox(
                width: 6.0,
              ),
              Text(
                widget.todo,
                style: const TextStyle(fontSize: 18.0),
              ),
              const Spacer(),
              const Icon(
                Icons.keyboard_double_arrow_left_sharp,
                color: Colors.red,
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(right: 12.0),
            child: Row(
              children: [
                const Spacer(),
                Text('Deadline : ${widget.date}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
