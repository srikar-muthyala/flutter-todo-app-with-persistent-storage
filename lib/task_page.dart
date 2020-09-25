import 'package:flutter/material.dart';
import 'package:todo_app/database_helper.dart';
import 'package:todo_app/widgets.dart';

import 'models/task.dart';
import 'models/todo.dart';

class TaskPage extends StatefulWidget {
  final Task task;
  TaskPage({@required this.task});
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  DatabaseHelper _dbHelper = DatabaseHelper();
  String _taskTitle = "";
  int _taskID = 0;
  @override
  void initState() {
    if (widget.task != null) {
      _taskTitle = widget.task.title;
      _taskID = widget.task.id;
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 6),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Image(
                              image: AssetImage(
                                  "assets/images/back_arrow_icon.png"),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            onSubmitted: (value) async {
                              print(value);

                              if (value != "") {
                                if (widget.task == null) {
                                  DatabaseHelper _dbHelper = DatabaseHelper();

                                  Task newTask = Task(title: value);

                                  await _dbHelper.insertTask(newTask);
                                } else {
                                  print("Update the existing task");
                                }
                              }
                            },
                            controller: TextEditingController()
                              ..text = _taskTitle,
                            decoration: InputDecoration(
                              hintText: 'Enter task title',
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff211551),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder(
                    initialData: [],
                    future: _dbHelper.getTodos(_taskID),
                    builder: (context, snapshot) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return TodoWidget(
                              isDone: snapshot.data[index].isDone == 0
                                  ? false
                                  : true,
                              text: snapshot.data[index].title,
                            );
                          },
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          margin: EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Color(0xff868290),
                            ),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Image(
                            image: AssetImage("assets/images/check_icon.png"),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            onSubmitted: (value) async {
                              print(value);

                              if (value != "") {
                                if (widget.task != null) {
                                  DatabaseHelper _dbHelper = DatabaseHelper();

                                  Todo newTodo = Todo(
                                      title: value,
                                      isDone: 0,
                                      taskID: widget.task.id);

                                  await _dbHelper.insertTodo(newTodo);
                                  setState(() {});
                                }
                                print('creating new todo');
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "enter first todo item.",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 24,
                right: 24,
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TaskPage()),
                  ).then((value) {
                    setState(() {});
                  }),
                  child: MinimalButton(
                    image_location: "assets/images/delete_icon.png",
                    color_code: 0xfffe3577,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
