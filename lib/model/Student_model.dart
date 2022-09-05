

import 'package:hive/hive.dart';

part 'Student_model.g.dart';

@HiveType(typeId: 1)
class StudentModal extends HiveObject{

@HiveField(0)
final String name;

@HiveField(1)
final String age;

@HiveField(2)
final String email;

@HiveField(3)
final String phoneno;

StudentModal( this.name,this.age,this.email,this.phoneno);



}