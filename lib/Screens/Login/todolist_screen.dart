import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:swipeable_tile/swipeable_tile.dart';


class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  

  @override
  State<TodoListScreen> createState() => _MyTodoScreenListState();
}

class Task {
  String title;
  bool taskCompleted;
  String taskID;
  Task({
    required this.title,
    required this.taskCompleted,
    required this.taskID,
  });
}

class _MyTodoScreenListState extends State<TodoListScreen> {
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
        taskID: (DateTime.now().millisecondsSinceEpoch).toString(),
      );

      todoList.add(tempTask);
    });
  }

  void _deleteTask(String taskID) {
    setState(() {
      todoList.removeWhere((item) => item.taskID == taskID);
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
            String currTaskID = todoList[index].taskID;
            return 
            SwipeableTile.swipeToTriggerCard(
                color: (todoList.firstWhere((item)=>item.taskID == currTaskID).taskCompleted
                            ? const Color.fromARGB(255, 123, 114, 114)
                            : const Color.fromARGB(
                                255, 0, 0, 0)),
                shadow: BoxShadow(
                  color: Colors.black.withOpacity(0),
                  blurRadius: 0,
                  offset: Offset(0, 0),
                ),
                horizontalPadding: 2,
                swipeThreshold:0.45,
                verticalPadding: 4,
                key: Key(currTaskID), 
                direction: SwipeDirection.horizontal,
                backgroundBuilder: (context, direction, progress) {
                  if (direction == SwipeDirection.endToStart) {
                    return 
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red, // color of the task
                          borderRadius:
                              BorderRadius.circular(20.0), //how round the task is
                        ),
                        padding: const EdgeInsets.all(16.0),
                      );
                  } else {
                    return 
                      Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 118, 105, 104), // color of the task
                            borderRadius:
                                BorderRadius.circular(20.0), //how round the task is
                          ),
                          padding: const EdgeInsets.all(16.0),
                      );
                  }
                },
                onSwiped: (direction) {
                  if (direction == SwipeDirection.endToStart) {
                    _deleteTask(currTaskID);
                  } else if (direction == SwipeDirection.startToEnd) {
                    //photo endpoint
                     _deleteTask(currTaskID);
                  }
                },
                child:
                  Padding(
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
                          children: TaskBox(todoList[index].taskID),
                        )),
                  )
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

  List<Widget> TaskBox(String taskID) {
    int tempInd = todoList.indexWhere((item) =>item.taskID == taskID);
    return [
      InkWell(
          onTap: () {
            setState(() {
              todoList[tempInd].taskCompleted = !todoList[tempInd].taskCompleted;
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
              text: todoList[tempInd].title,
              selection: TextSelection.collapsed(
                  offset: todoList[tempInd].title.length))),
          onChanged: (newTitle) {
            setState(() {
              todoList[tempInd].title = newTitle;
            });
          },
          style: TextStyle(
            color: Colors.white,
            decoration: todoList[tempInd].taskCompleted
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
