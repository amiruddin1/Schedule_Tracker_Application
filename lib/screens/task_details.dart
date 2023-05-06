import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskDetail extends StatefulWidget {
  String? title;
  TaskDetail(String value){
    this.title = value;
  }

  @override
  State<StatefulWidget> createState() {
    return TaskDetailState(title.toString());
  }
}

class TaskDetailState extends State<TaskDetail> {
  static var _priorities = ['High', 'Low'];
  var selectedvalue = "Low";
  String? title;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController tec = TextEditingController();

  TaskDetailState(String value){
    this.title = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title.toString()),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            // First element
            ListTile(
              title: DropdownButton(
                  items: _priorities.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),
                  value: selectedvalue,
                  onChanged: (valueSelectedByUser) {
                    setState(() {
                      this.selectedvalue = valueSelectedByUser.toString();
                    });
                  }),
            ),

            // Second Element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: titleController,
                onChanged: (value) {
                  debugPrint('Something changed in Title Text Field');
                },
                decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),

            // Third Element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: descriptionController,
                onChanged: (value) {
                  debugPrint('Something changed in Description Text Field');
                },
                decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                  controller: tec,
                  decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      labelText: "Select Date",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),

                  readOnly: true,

                  //--------------------------------------------------------
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime
                            .now(),
                        lastDate: DateTime(2025));

                    if (pickedDate != null) {
                      debugPrint(pickedDate
                          .toString());
                      String formattedDate = DateFormat('dd-MM-yyyy').format(
                          pickedDate);
                      print(
                          formattedDate);

                      tec.text =
                          formattedDate;

                      SnackBar snackBar = SnackBar(
                        content: Text(formattedDate),
                        duration: const Duration(seconds: 5),
                        backgroundColor: Colors.black,
                        action: SnackBarAction(
                          label: 'clear',
                          onPressed: () {
                                tec.text = "";
                          },
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      debugPrint("Date is not selected");
                    }
                  }),
            ),

            // Fourth Element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          if(titleController.text =="" || descriptionController.text =="" || tec.text ==""){
                            SnackBar snackBar = SnackBar(
                              content: Text("All The Data Mandatory to Fill"),
                              duration: const Duration(seconds: 3),
                              backgroundColor: Colors.deepPurple,
                            );

                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        });
                      },
                    ),
                  ),
                  Container(
                    width: 5.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      child: Text(
                        'Delete',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text(
                                      "Are You Sure Want to Delete This Task?"),
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
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
