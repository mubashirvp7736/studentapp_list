import 'package:flutter/material.dart'; 
import 'package:hive/hive.dart';
part 'model.g.dart';

 @HiveType(typeId: 1)
 class  studentModel{
  
@HiveField(0)
   int? index;

  @HiveField(1)
  late final String name;
  @HiveField(2)
  late final String coures;
  @HiveField(3)
  late final String age;
  @HiveField(4)
  late final String numb;
  @HiveField(5)
  late final String image;
  studentModel({required this.name,required this.coures,required this.age,required this.numb,this.index,required this.image});
  
}