import 'package:admin/models/student.dart';
import 'package:admin/shared/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';

class StudentController extends ChangeNotifier {
  //Get all student
  bool isloadingGetStudent = false;
  List<Student> list_of_student = [];

  Future<void> getallStudent() async {
    list_of_student = [];
    isloadingGetStudent = true;
    notifyListeners();
    DioHelper.dio!.get("students").then((value) {
      value.data.forEach((element) {
        list_of_student.add((Student.fromJson(element)));
      });

      isloadingGetStudent = false;

      notifyListeners();
    });
  }

  Future<void> searchStudent(String name) async {}
}
