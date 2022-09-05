import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_project/View_Students.dart';
import 'package:hive_project/model/Student_model.dart';
import 'main.dart';
import 'dart:io';

class AddStudent extends StatefulWidget {
  AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
  
}

class _AddStudentState extends State<AddStudent> {

  Box<StudentModal>? studentBox;

  final _name = TextEditingController();

  final _age = TextEditingController();

  final _email = TextEditingController();

  final _phoneno = TextEditingController();

  @override
  void initState() {

    // TODO: implement initState

    Hive.openBox<StudentModal>('Student_db');
      
    studentBox = Hive.box<StudentModal>('Student_db');

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(' Add Students '),
          backgroundColor: Colors.blue,
          leading: (IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back))),
        ),
        body: ListView(
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
            functiontextformfield(_name, 'Name'),
            const SizedBox(
              height: 20,
            ),
            functiontextformfield(_age, 'Age'),
            const SizedBox(
              height: 20,
            ),
            functiontextformfield(_email, 'Email'),
            const SizedBox(
              height: 20,
            ),
            functiontextformfield(_phoneno, 'Phone No'),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  addstudent(context);
                },
                child: const Text(' Submit ')),
          ],
        ));
  }

  Widget functiontextformfield(
      TextEditingController incontroller, String text) {
    return TextFormField(
      validator: (value) {
        if (value == null || value == value.isEmpty) {
          return 'Field is empty';
        }
      },
      controller: incontroller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        labelText: text,
      ),
    );
  }

  void showAddedAlertBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            title: Column(
              children: const [
                Text("Student Added"),
                Divider(),
              ],
            ),
            content: const Text("Student added successfully to the database"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      ctx,
                      MaterialPageRoute(
                          builder: (context) => const ViewStudents()),
                      (route) => false);
                  // Navigator.pop(ctx);
                },
                child: const Text('Ok'),
              ),
            ],
          );
        });
        
  }

  Future<void> addstudent(
    BuildContext context,
    //  Box<StudentModal> Student,
  ) async {

    final finalname = _name.text;
    final finalage = _age.text;
    final finalemail = _email.text;
    final finalphoneno = _phoneno.text;

    if (finalname.isEmpty ||
        finalage.isEmpty ||
        finalemail.isEmpty ||
        finalphoneno.isEmpty) {
      return;
    }

    final student = StudentModal(finalname, finalage, finalemail, finalphoneno);
    await studentBox!.add(student);
    print(student.name);
    showAddedAlertBox(context);
  }
}
