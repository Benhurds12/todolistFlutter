import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToDoListScreen(),
    );
  }
}

class ToDoListScreen extends StatefulWidget {
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  List<TodoItem> todoItems = [];

  void addTodoItem(String item) {
    setState(() {
      todoItems.add(TodoItem(title: item, isCompleted: false));
    });
  }

  void toggleTodoItem(int index) {
    setState(() {
      todoItems[index].isCompleted = !todoItems[index].isCompleted;
    });
  }

  void removeTodoItem(int index) {
    setState(() {
      todoItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List'),
      ),
      body: ListView.builder(
        itemCount: todoItems.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            value: todoItems[index].isCompleted,
            title: Text(todoItems[index].title),
            onChanged: (value) {
              toggleTodoItem(index);
            },
            secondary: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                removeTodoItem(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String newTodoItem = '';
              return AlertDialog(
                title: Text('Add ToDo Item'),
                content: TextField(
                  onChanged: (value) {
                    newTodoItem = value;
                  },
                ),
                actions: [
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Add'),
                    onPressed: () {
                      addTodoItem(newTodoItem);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class TodoItem {
  String title;
  bool isCompleted;

  TodoItem({required this.title, required this.isCompleted});
}
