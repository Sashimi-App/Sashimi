import 'package:flutter/material.dart';


class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});



  @override
  State<TodoScreen> createState() => _MyTodoScreenState();
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

class _MyTodoScreenState extends State<TodoScreen> {
  List<Task> todoList = [];
  List<Task> completed = [];

  void _addTask() {
    setState(() {
      Task tempTask = Task(
        title: "",
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
            todoList.sort((a, b) => (a.taskCompleted ? 1 : 0).compareTo(b.taskCompleted ? 1 : 0));
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
                    children: TaskBox(todoList[index].taskID),
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

  List<Widget> TaskBox(String taskID) {
    int tempInd = todoList.indexWhere((item)=>item.taskID == taskID);
    return [
      InkWell(
          onTap: () {
            setState(() {
              todoList[tempInd].taskCompleted = 
              !todoList[tempInd].taskCompleted;
            });
          },
          child: 
            Container(
              width: 10.0,
              height: 10.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            )
      ),
      Expanded (
          child: 
            Container(
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
            )
        ),
        InkWell(
          onTap: () {
            setState(() {
              todoList.removeWhere((item)=>item.taskID== taskID);
              print(todoList.length);
            });
          },
          child: 
            Container(
              width: 10.0,
              height: 10.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
            )
        ),
    ];
  }
}