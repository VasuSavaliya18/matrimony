import 'package:flutter/material.dart';

import 'DbHelper.dart';
import 'Student.dart';
import 'StudentForm.dart';

class StudentList extends StatefulWidget {

  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {

  Dbhelper db = Dbhelper();

  // Get Students
  Future<List<Student>> getStudents() async {

    return await db.getAllStudent();
  }

  // Delete Student
  Future<void> deleteStudent(Student student) async {

    await db.deleteStudent(student);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:  Text("Student List"),
        actions: [Icon(Icons.arrow_back)],
      ),

      body: FutureBuilder<List<Student>>(
        future: getStudents(),

        builder: (context, snapshot) {


          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return  Center(
              child: CircularProgressIndicator(),
            );
          }


          if (snapshot.hasError) {

            return Center(
              child: Text(
                "Error: ${snapshot.error}",
              ),
            );
          }


          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {

            return const Center(
              child: Text(
                "No Student Found",
              ),
            );
          }

          List<Student> students = snapshot.data!;

          return ListView.builder(

            itemCount: students.length,

            itemBuilder: (context, index) {

              Student student = students[index];

              return Card(

                margin:  EdgeInsets.all(10),

                child: ListTile(

                  leading: CircleAvatar(
                    child: Text(
                      student.fname[0].toUpperCase(),
                    ),
                  ),

                  title: Text(
                    "${student.fname} ${student.lname}",
                  ),

                  subtitle: Text(
                    "${student.email}\n"
                        "${student.department} | Age: ${student.age}",
                  ),

                  isThreeLine: true,

                  trailing: Row(

                    mainAxisSize: MainAxisSize.min,

                    children: [


                      IconButton(
                        onPressed: () {

                          Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder: (context) => StudentForm(
                                student: student,
                              ),
                            ),
                          ).then((value) {

                            setState(() {});

                          });

                        },

                        icon: const Icon(
                          Icons.edit,
                        ),
                      ),

                      IconButton(
                        onPressed: () {

                          deleteStudent(student);

                        },

                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}