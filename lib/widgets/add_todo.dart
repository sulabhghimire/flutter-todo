import 'package:flutter/material.dart';
import 'package:todo/model/todo.dart';

class NewToDo extends StatefulWidget {
  const NewToDo({required this.toDoHandler, super.key});

  final void Function(Todo) toDoHandler;

  @override
  State<NewToDo> createState() => _NewToDoState();
}

class _NewToDoState extends State<NewToDo> {
  final _titleController = TextEditingController();
  var _selectedCatageory = Category.urgent;
  DateTime? _selectedDate;

  void _validateSubmission() {
    final title = _titleController.text.trim();
    if (title.isEmpty || _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Invalid Input!'),
              content: const Text(
                  'Make sure that correct title and date was inserted.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          });
      return;
    }
    widget.toDoHandler(Todo(
      title: title,
      deadline: _selectedDate!,
      category: _selectedCatageory,
    ));
    Navigator.pop(context);
  }

  void _showCalander() async {
    final initialDate = DateTime.now();
    final lastDate = DateTime(2030);
    final picked_date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate,
      lastDate: lastDate,
    );

    setState(() {
      _selectedDate = picked_date;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
            maxLength: 35,
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              DropdownButton(
                value: _selectedCatageory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCatageory = value;
                  });
                },
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    _selectedDate == null
                        ? 'No date selected'
                        : formatter.format(_selectedDate!),
                  ),
                  IconButton(
                      onPressed: _showCalander,
                      icon: const Icon(Icons.calendar_month))
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _validateSubmission,
                child: const Text('Submit'),
              )
            ],
          )
        ],
      ),
    );
  }
}
