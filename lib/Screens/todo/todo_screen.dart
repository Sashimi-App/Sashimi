import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Task {
  String title;
  bool taskCompleted;
  Task({
    required this.title,
    required this.taskCompleted,
  });
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController controller;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
    focusNode = FocusNode();
    focusNode.requestFocus();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  List<Task> todoList = [];
  List<Task> completed = [];
  String taskName = '';

  Future<String?> openDialog() => showDialog(
        barrierColor: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.black,
          insetPadding: EdgeInsets.all(25),
          content: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.05,
              child: TextFormField(
                enableSuggestions: false,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: 'Name your task',
                    hintStyle: TextStyle(color: Colors.white)),
                controller: controller,
                focusNode: focusNode,
                autofocus: true,
                onEditingComplete: () => submit(),
              ),
            ),
          ),
        ),
      );

  void submit() {
    Navigator.of(context).pop(controller.text);
    controller.clear();
  }

  void _addTask() {
    setState(() {
      Task tempTask = Task(
        title: taskName,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final taskName = await openDialog();

          if (taskName == null || taskName.isEmpty) return;

          setState(() {
            this.taskName = taskName;
          });
          _addTask();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
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
