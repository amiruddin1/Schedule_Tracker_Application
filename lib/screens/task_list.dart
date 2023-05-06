import 'package:flutter/material.dart';
import 'package:schedule_tracker/screens/task_details.dart';

class TaskList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TaskListState();
  }
}

class TaskListState extends State<TaskList> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: getTaskListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TaskDetail("Add New Task")));
        },
        tooltip: 'Add New Task',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getTaskListView() {
    TextStyle? titleStyle = Theme.of(context).textTheme.bodyMedium;

    return ListView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getColorByPriority("High"),
              child: Icon(Icons.keyboard_arrow_right),
            ),
            title: Text(
              'Dummy Title',
              style: titleStyle,
            ),
            subtitle: Text('Dummy Date'),
            trailing: GestureDetector(
              child: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                  )),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text(
                            "Are You Sure Want to Mark this Task As Completed?"),
                        actions: [
                          GestureDetector(
                            child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text("Yes")),
                            onTap: () {},
                          ),
                          GestureDetector(
                            child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text("No")),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    });
              },
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TaskDetail("Edit Task")));
            },
          ),
        );
      },
    );
  }

  Color getColorByPriority(String priority) {
    if (priority == "High") {
      return Colors.red;
    } else {
      return Colors.yellow;
    }
  }
}
