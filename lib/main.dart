import 'package:flutter/material.dart';
import 'package:schedule_tracker/screens/task_list.dart';
import 'package:schedule_tracker/screens/task_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Schedule Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.deepPurple
      ),
      home: TaskList(),
    );
  }
}