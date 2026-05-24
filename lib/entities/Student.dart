abstract class Person {
  String id;
  String name;
  int age;

  Person({this.id = "", this.age = 0, this.name = ""});

  void personPrint() {
    print("id: $id, ");
  }
}

class Student extends Person {
  double gpa;

  static List<Student> students = [
    Student(id: "01", name: "HEr", age: 19),
    Student(id: "02", name: "HEr", age: 19),
    Student(id: "03", name: "HEsafr", age: 20),
  ];
  // Student.CopyTo({String? id, String? name, int? age, double? gpa}){
  //   return Student(id id??this.id, name:name ?? this.name,age: age??this.age);
  // }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'].toString() ?? "",
      name: json['name'].toString() ?? "",
      age: int.parse(json['age'] ?? 0),
      gpa: double.parse(json['gpa'] ?? 0),
    );
  }
  Student({super.id, super.name = '', super.age = 0, this.gpa = 9});

  List<Student> getGreater(int a) {
    return students.where(((s) => s.age > a)).toList();
  }

  @override
  personPrint();

  List<Student> plusAge() {
    List<Student> lsv = [];
    // for (Student s in students){
    //   lsv.add(Student(id: s.id, name: s.name, age: s.age));
    // }

    lsv = students
        .map((s) => Student(id: s.id, name: s.name, age: s.age))
        .toList();

    return lsv;
  }
}

void main() {
  Student std = Student(id: "okay");
  std.personPrint();
}
