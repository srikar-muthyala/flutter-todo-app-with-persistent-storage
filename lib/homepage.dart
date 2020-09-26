import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:todo_app/database_helper.dart';
import 'package:todo_app/task_page.dart';
import 'package:todo_app/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper _dbHelper = DatabaseHelper();
  int tasks_count;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.lightBlue, Colors.lightBlue[100]],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 60, 0, 30),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 40,
                                  child: Icon(
                                    Icons.account_circle,
                                    color: Colors.lightBlueAccent,
                                    size: 50,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                            child: Text(
                              'Hello, there!',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                            child: Text(
                              'You have ${tasks_count.toString()} ongoing task categories.',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder(
                        initialData: [],
                        future: _dbHelper.getTasks(),
                        builder: (context, snapshot) {
                          // return SingleChildScrollView(
                          //   child: Container(
                          //     height: 300,
                          //     child: ScrollConfiguration(
                          //       behavior: NoGlowBehaviour(),
                          //       child: ListView.builder(
                          //         shrinkWrap: true,
                          //         scrollDirection: Axis.horizontal,
                          //         itemCount: snapshot.data.length,
                          //         itemBuilder: (context, index) {
                          //           tasks_count = snapshot.data.length;
                          //           return GestureDetector(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                     builder: (context) => TaskPage(
                          //                         task: snapshot.data[index]))),
                          //             child: TextContainer(
                          //               title: snapshot.data[index].title,
                          //             ),
                          //           );
                          //         },
                          //       ),
                          //     ),
                          //   ),
                          // );

                          return Container(
                            height: 300,
                            child: PageView.builder(
                              itemCount: snapshot.data.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                tasks_count = snapshot.data.length;
                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TaskPage(
                                              task: snapshot.data[index]))),
                                  child: TextContainer(
                                    title: snapshot.data[index].title,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 24,
                right: 24,
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TaskPage(
                              task: null,
                            )),
                  ).then((value) {
                    setState(() {});
                  }),
                  child: MinimalButton(
                    image_location: "assets/images/add_icon.png",
                    color_code: 0xff7349fe,
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
