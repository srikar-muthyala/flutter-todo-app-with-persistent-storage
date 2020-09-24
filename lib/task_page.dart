import 'package:flutter/material.dart';
import 'package:todo_app/database_helper.dart';

import 'models/task.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 0, 0),
              child: TextField(
                onSubmitted: (value) async {
                  print(value);

                  if (value != "") {
                    DatabaseHelper _dbHelper = DatabaseHelper();

                    Task newTask = Task(title: value);

                    await _dbHelper.insertTask(newTask);

                    print('new task has been inserted into database');
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Enter task title',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
