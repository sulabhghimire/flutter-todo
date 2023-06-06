import 'package:flutter/material.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/widgets/add_todo.dart';
import 'package:todo/widgets/todo_item.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({required this.title, super.key});

  final String title;

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  void _openAddToDoOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewToDo(toDoHandler: _saveToDo),
    );
  }

  void _removeToDoHandler(Todo todo) {
    setState(() {
      _todos.remove(todo);
    });
  }

  void _saveToDo(Todo todo) {
    setState(() {
      _todos.add(todo);
    });
    return;
  }

  final List<Todo> _todos = [
    Todo(
      title: 'Complete Course',
      deadline: DateTime.now(),
      category: Category.urgent,
    ),
    Todo(
      title: 'Revise Django',
      deadline: DateTime.now(),
      category: Category.normal,
    ),
    Todo(
      title: 'Get a Life',
      deadline: DateTime.now(),
      category: Category.low,
    ),
  ];

  var _order = 'asc';

  List<Todo> _sortList() {
    var sortedList = List.of(_todos);
    sortedList.sort((a, b) {
      final bcomesAfterA = a.title.compareTo(b.title);
      return _order == 'asc' ? bcomesAfterA : -bcomesAfterA;
    });
    return sortedList;
  }

  void _changeOrder() {
    setState(() {
      _order = _order == 'asc' ? 'dsc' : 'asc';
    });
  }

  @override
  Widget build(BuildContext context) {
    var list = _sortList();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: _openAddToDoOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Spacer(),
                TextButton.icon(
                  onPressed: _changeOrder,
                  icon: _order == 'asc'
                      ? const Icon(Icons.arrow_downward)
                      : const Icon(Icons.arrow_upward),
                  label: _order == 'asc'
                      ? const Text('Sort by Descending')
                      : const Text('Sort by Ascending'),
                ),
              ],
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: _sortList().length,
            //     itemBuilder: ((BuildContext context, int index) {
            //       return ToDoItem(
            //         key: ObjectKey(list[index]),
            //         todo: list[index].title,
            //         priority: list[index].category,
            //         date: list[index].formattedDate,
            //       );
            //     }),
            //   ),
            // ),
            for (var todo in list)
              Dismissible(
                key: ObjectKey(todo),
                onDismissed: (direction) => _removeToDoHandler(todo),
                background: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Text(
                      'Delete',
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
                child: ToDoItem(
                  key: ObjectKey(todo),
                  todo: todo.title,
                  priority: todo.category,
                  date: todo.formattedDate,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
