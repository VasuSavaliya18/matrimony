class Student {
  int? id;
  String fname;
  String lname;
  String email;
  String department;
  int age;

  Student({
    this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.department,
    required this.age,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fname': fname,
      'lname': lname,
      'email': email,
      'department': department,
      'age': age,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      fname: map['fname'],
      lname: map['lname'],
      email: map['email'],
      department: map['department'],
      age: map['age'],
    );
  }
}