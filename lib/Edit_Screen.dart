import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:hive_project/View_Students.dart';
import 'package:hive_project/model/Student_model.dart';


class EditStudent extends StatefulWidget {
  EditStudent({Key? key, required this.student}) : super(key: key);

StudentModal student;

  @override
  State<EditStudent> createState() => _EditStudentState();
  
}

class _EditStudentState extends State<EditStudent> {

final student_db = Hive.box<StudentModal>('Student_db');
 final _formKey=GlobalKey<FormState>();
  TextEditingController? _nameController ;
  TextEditingController? _ageController;
  TextEditingController? _emailController;
  TextEditingController? _phonenoController;



  @override
  void initState() {
    _nameController= TextEditingController(text: widget.student.name);
    _ageController = TextEditingController(text:widget.student.age);
    _emailController=TextEditingController(text: widget.student.email);
    _phonenoController=TextEditingController(text: widget.student.phoneno);
  
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(' Edit Students '),
          backgroundColor: Colors.blue,
          leading: (IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back))),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
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
              functiontextformfield(_nameController!, 'Name',),
              const SizedBox(
                height: 20,
              ),
              functiontextformfield(_ageController!, 'Age'),
              const SizedBox(
                height: 20,
              ),
              functiontextformfield(_emailController!, 'Email'),
              const SizedBox(
                height: 20,
              ),
              functiontextformfield(_phonenoController!, 'Phone No'),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    editstudent(context,widget.student);
                  },
                  child: const Text(' Submit ')),
            ],
          ),
        ));
  }

  Widget functiontextformfield(
      TextEditingController incontroller, String text) {
    return TextFormField(

      
      controller: incontroller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        labelText: text,
      ),
    );
  }

  void showEditedAlertBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            title: Column(
              children: const [
                Text("Student Edited"),
                Divider(),
              ],
            ),
            content: const Text("Student edited successfully to the database"),
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

  Future<void> editstudent(
    BuildContext context,
      StudentModal Student,
  ) async {

    final finalname = _nameController!.text.trim();
    final finalage = _ageController!.text.trim();
    final finalemail = _emailController!.text.trim();
    final finalphoneno = _phonenoController!.text.trim();

    if (finalname.isEmpty ||
        finalage.isEmpty ||
        finalemail.isEmpty ||
        finalphoneno.isEmpty) {
      return;
    }

    final _student = StudentModal(finalname, finalage, finalemail, finalphoneno);
    
  await student_db.put(widget.student.key, _student);
  showEditedAlertBox(context);

  }
}
