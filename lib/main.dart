



import 'package:flutter/material.dart';
import 'package:student_app/db/model/model.dart';
import 'package:student_app/home/list_student.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async{
 await Hive.initFlutter();
 if(!Hive.isAdapterRegistered(studentModelAdapter().typeId))
 {
  Hive.registerAdapter(studentModelAdapter());
 }
  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),),
      debugShowCheckedModeBanner: false,
      home:ListStudent(),
    );
  }
}