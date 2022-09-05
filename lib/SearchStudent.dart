
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_project/model/Student_model.dart';

import 'Student_Details.dart';


class searchstudent extends StatefulWidget {
  const searchstudent({Key? key}) : super(key: key);

  @override
  State<searchstudent> createState() => _searchstudentState();
}

class _searchstudentState extends State<searchstudent> {
  List<StudentModal> studentList =
      Hive.box<StudentModal>('student_db').values.toList();
  late List<StudentModal> displayStudent = List<StudentModal>.from(studentList);

  void updateList(String value) {
    setState(() {
      displayStudent = studentList
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Students"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          TextFormField(
            onChanged: (value) {
              updateList(value);
            },
            decoration:const InputDecoration(
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              hintText: "Search here",
            ),
          ),
          Expanded(

            child: (displayStudent.isNotEmpty)
                ? Padding(
                  padding: const EdgeInsets.only(top:15.0),
                  child: ListView.separated(
                    
                      itemBuilder: (context, index) {
                        final data = displayStudent[index];
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => StudentDetail(
                                      student: data,
                                    ))));
                          },
                            leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/dummy.png')),
                            title: Text(displayStudent[index].name),
                          );
                          },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: displayStudent.length),
                )
                : Center(child: Text("The name is not found")),
          )
        ]),
      ),
    );
  }
}