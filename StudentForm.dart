import 'package:flutter/material.dart';

import 'DbHelper.dart';
import 'Student.dart';
import 'StudentList.dart';


class StudentForm extends StatefulWidget {

  final Student? student;

  const StudentForm({
    super.key,
    this.student,
  });

  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {

  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController age = TextEditingController();

  Dbhelper db = Dbhelper();

  @override
  void initState() {

    super.initState();


    if (widget.student != null) {

      fname.text = widget.student!.fname;
      lname.text = widget.student!.lname;
      email.text = widget.student!.email;
      department.text = widget.student!.department;
      age.text = widget.student!.age.toString();

    }
  }

  Future<void> saveStudent() async {

    Student student = Student(

      id: widget.student?.id,

      fname: fname.text,
      lname: lname.text,
      email: email.text,
      department: department.text,
      age: int.parse(age.text),

    );

    // Add Student
    if (widget.student == null) {

      await db.addStudent(student);

    }

    // Update Student
    else {

      await db.updateStudent(student);

    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(
          widget.student == null
              ? "Registration Form"
              : "Update Student",
        ),
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            TextField(
              controller: fname,

              decoration: const InputDecoration(
                labelText: "First Name",
              ),
            ),

            TextField(
              controller: lname,

              decoration: const InputDecoration(
                labelText: "Last Name",
              ),
            ),

            TextField(
              controller: email,

              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),

            TextField(
              controller: department,

              decoration: const InputDecoration(
                labelText: "Department",
              ),
            ),

            TextField(
              controller: age,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(
                labelText: "Age",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(

              onPressed: () {

                saveStudent();
                Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentList()));

              },

              child: Text(
                widget.student == null
                    ? "Register Student"
                    : "Update Student",
              ),
            ),
          ],
        ),
      ),
    );
  }
}