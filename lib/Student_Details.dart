import 'package:flutter/material.dart';
import 'package:hive_project/model/Student_model.dart';

class StudentDetail extends StatelessWidget {
  StudentDetail({Key? key, required this.student}) : super(key: key);
  StudentModal student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Student Details '),
        backgroundColor: Colors.blue,
        leading: (IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back))),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/dummy.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text('Name : ${student.name}'),
            const SizedBox(
              height: 20,
            ),
            Text('Age : ${student.age}'),
            const SizedBox(
              height: 20,
            ),
            Text('Email: ${student.email}'),
            const SizedBox(
              height: 20,
            ),
            Text('Phone No: ${student.phoneno}'),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
