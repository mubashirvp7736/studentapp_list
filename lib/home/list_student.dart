import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_app/db/functions/functions.dart';
import 'package:student_app/db/model/model.dart';
import 'package:student_app/home/add_student.dart';
import 'package:student_app/home/edit.dart';
import 'package:student_app/home/screen.dart';

class ListStudent extends StatefulWidget {
  const ListStudent({Key? key}) : super(key: key);

  @override
  _ListStudentState createState() => _ListStudentState();
}

class _ListStudentState extends State<ListStudent> {
  TextEditingController searchController = TextEditingController();
  List<studentModel> studentList = [];
  List<studentModel> filteredStudentList = [];

  bool isSearching = false;

  @override
  void initState() {
    super.initState();
  
    getAllStud();
  }

  void filterStudents(String search) {
    if (search.isEmpty) {
      setState(() {
        filteredStudentList = List.from(studentList);
      });
    } else {
      setState(() {
        filteredStudentList = studentList
            .where((student) =>
                student.name.toLowerCase().contains(search.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: isSearching ? buildSearchField() : Text("Student List"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                  if (!isSearching) {
                    searchController.clear();
                    filteredStudentList = List.from(studentList);
                  }
                });
              },
              icon: Icon(isSearching ? Icons.cancel : Icons.search),
            ),
          ],
        ),
        body: Center(
          child: isSearching
              ? filteredStudentList.isNotEmpty
                  ? ListView.separated(
                      itemBuilder: (ctx, index) {
                        final data = filteredStudentList[index];
                        return buildStudentCard(data, index);
                      },
                      separatorBuilder: (ctx, index) {
                        return const Divider();
                      },
                      itemCount: filteredStudentList.length,
                    )
                  : Center(
                      child: Text("No results found."),
                    )
              : buildStudentList(),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.amber,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => addstuds(),
              ),
            );
          },
          icon: Icon(Icons.add),
          label: Text("Add Student"),
        ),
        backgroundColor: const Color.fromARGB(255, 148, 148, 148),
      ),
    );
  }

  Widget buildSearchField() {
    return TextField(
      controller: searchController,
      onChanged: (query) {
        filterStudents(query);
      },
      autofocus: true,
      style: TextStyle(
        color: Colors.white, 
      ),
      decoration: InputDecoration(
        hintText: "Search students...",
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.7), 
        ),
        border: InputBorder.none,
      ),
    );
  }

  Widget buildStudentCard(studentModel data, int index) {
    return Card(
      child: ListTile(
        onTap: (){
         Navigator.push(context, MaterialPageRoute(builder: (context) => ViewStudentScreen(name: data.name, coures: data.coures, age: data.age, numb: data.numb, image: data.image),));
        },
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          backgroundImage: FileImage(File(data.image)),
        ),
        title: Text(
          data.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          data.age,
        ),
        trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditScreen(
                        index: index,
                        name: data.name,
                        age: data.age,
                        course: data.coures,
                        phoneNumber: data.numb,
                        image: data.image,
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.edit),
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              IconButton(
                onPressed: () {
                  deletestud(index);
                },
                icon: Icon(Icons.delete),
                color: Colors.red[300],
              ),
            ],
          ),
        ),
      );
  
  }

  Widget buildStudentList() {
    return ValueListenableBuilder(
      valueListenable: studenlistnotfier,
      builder: (BuildContext ctx, List<studentModel> studentlist, Widget? child) {
        studentList = studentlist;
        filteredStudentList = List.from(studentList);

        return ListView.separated(
          itemBuilder: (ctx, index) {
            final data = studentList[index];
            return buildStudentCard(data, index);
          },
          separatorBuilder: (ctx, index) {
            return const Divider();
          },
          itemCount: studentList.length,
        );
      },
    );
  }
}