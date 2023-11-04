import 'package:flutter/material.dart';

//
class TodoList extends StatefulWidget {
  const TodoList({super.key, required this.title});

  final String title;

  @override
  State<TodoList> createState() => _MyHomePageState();
}

class Task {
  String title;
  bool taskCompleted;
  Task({
    required this.title,
    required this.taskCompleted,
  });
}

class _MyHomePageState extends State<TodoList> {
  List<Task> todoList = [];
  List<Task> completed = [];

  void _addTask() {
    setState(() {
      Task tempTask = Task(
        title: "",
        taskCompleted: false,
      );

      todoList.add(tempTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        width: MediaQuery.of(context).size.width * 0.90, //90% screen width
        height:
            MediaQuery.of(context).size.height * 0.8, // 80% of screen height
        padding: const EdgeInsets.all(0.0),
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            todoList.sort((a, b) =>
                (a.taskCompleted ? 1 : 0).compareTo(b.taskCompleted ? 1 : 0));
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                  decoration: BoxDecoration(
                    color: (todoList[index].taskCompleted
                        ? const Color.fromARGB(255, 123, 114, 114)
                        : const Color.fromARGB(
                            255, 0, 0, 0)), // color of the task
                    borderRadius:
                        BorderRadius.circular(20.0), //how round the task is
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: completeTask(index),
                  )),
            );
          },
        ),
      )),
      floatingActionButton: addTaskButton(),
    );
  }

  FloatingActionButton addTaskButton() {
    return FloatingActionButton(
      onPressed: _addTask,
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }

  List<Widget> completeTask(int index) {
    return [
      InkWell(
          onTap: () {
            setState(() {
              todoList[index].taskCompleted = !todoList[index].taskCompleted;
            });
          },
          child: Container(
            width: 10.0,
            height: 10.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          )),
      Expanded(
          child: Container(
        padding: const EdgeInsets.only(left: 10),
        child: TextField(
          controller: TextEditingController.fromValue(TextEditingValue(
              text: todoList[index].title,
              selection: TextSelection.collapsed(
                  offset: todoList[index].title.length))),
          onChanged: (newTitle) {
            setState(() {
              todoList[index].title = newTitle;
            });
          },
          style: TextStyle(
            color: Colors.white,
            decoration: todoList[index].taskCompleted
                ? TextDecoration.lineThrough
                : null,
          ),
          textDirection: TextDirection.ltr,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ))
    ];
  }
}
