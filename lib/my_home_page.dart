import 'package:flutter/material.dart';

class TodoItem {
  String title;
  bool isDone;

  TodoItem({required this.title, this.isDone = false});
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String inputValue = '';
  List<TodoItem> todos = [];

  void _addTodo() {
    if (inputValue.trim().isEmpty) return;

    setState(() {
      todos.add(TodoItem(title: inputValue));
      inputValue = '';
    });
  }

  void _toggleTodo(int index) {
    setState(() {
      todos[index].isDone = !todos[index].isDone;
    });
  }

  void setInputValue(value) {
    setState(() {
      inputValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'TODOを入力して下さい',
                    ),
                    onChanged: (value) => setInputValue(value),
                    controller: TextEditingController(text: inputValue),
                  ),
                ),
                IconButton(
                  onPressed: _addTodo,
                  icon: Icon(Icons.check_circle_outline),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Checkbox(
                      value: todos[index].isDone,
                      onChanged: (_) => _toggleTodo(index),
                    ),
                    title: Text(
                      todos[index].title,
                      style: TextStyle(
                        decoration:
                            todos[index].isDone
                                ? TextDecoration.lineThrough
                                : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
