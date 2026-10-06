import 'package:flutter/material.dart';

import 'StudentForm.dart';
import 'StudentList.dart';

class Dashboard extends StatelessWidget {

  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Student Dashboard"),
      ),

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            // Add Student Button
            SizedBox(
              width: 250,
              height: 50,

              child: ElevatedButton(
                onPressed: () {

                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (context) => StudentForm(),
                    ),
                  );

                },

                child: const Text(
                  "Add Student",
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Student List Button
            SizedBox(
              width: 250,
              height: 50,

              child: ElevatedButton(
                onPressed: () {

                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (context) =>
                      const StudentList(),
                    ),
                  );

                },

                child: const Text(
                  "Student List",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}