import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:student_app/db/model/model.dart';
import 'package:student_app/home/list_student.dart';

ValueNotifier<List<studentModel>>studenlistnotfier =ValueNotifier([]);



Future <void> addstud(studentModel value)async
{
  final studentDb = await Hive.openBox<studentModel>("student_db");
    await studentDb.add(value);
    getAllStud();
}

Future<void> getAllStud()async{
   final studentDb= await Hive.openBox<studentModel>("student_db");
  studenlistnotfier.value.clear();
  studenlistnotfier.value.addAll(studentDb.values);
  studenlistnotfier.notifyListeners(); 
}

Future<void> deletestud(int index)async{
  final studentDb= await Hive.openBox<studentModel>("student_db"); 
   await studentDb.deleteAt(index);
  getAllStud();
}