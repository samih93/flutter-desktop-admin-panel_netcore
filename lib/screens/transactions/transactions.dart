import 'package:admin/models/student.dart';
import 'package:admin/screens/dashboard/components/recent_files.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:admin/screens/transactions/components/RecentStudent.dart';
import 'package:admin/shared/remote/dio_helper.dart';
import 'package:flutter/material.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  List<Student> list_of_student = [];
  bool isloading = false;
  void initState() {
    // TODO: implement initState
    _loadData().then((value) => null);
    super.initState();
  }

  Future<void> _loadData() async {
    setState(() {
      isloading = true;
    });
    DioHelper.dio!.get("students").then((value) {
      value.data.forEach((element) {
        list_of_student.add((Student.fromJson(element)));
      });

      list_of_student.forEach((element) {
        print(element.toJson());
      });
      isloading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isloading == true
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: RecentStudent(
                listofstudent: list_of_student,
              ),
            ),
    );
  }
}
