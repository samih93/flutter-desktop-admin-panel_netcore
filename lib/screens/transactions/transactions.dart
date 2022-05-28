import 'package:admin/controllers/studentController.dart';
import 'package:admin/models/student.dart';
import 'package:admin/screens/dashboard/components/recent_files.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:admin/screens/transactions/components/RecentStudent.dart';
import 'package:admin/shared/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  // void initState() {
  //   // TODO: implement initState
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _loadData().then((value) => null);
  //   });

  //   super.initState();
  // }

  // Future<void> _loadData() async {
  //   context.read<StudentController>()..getallStudent();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: context.read<StudentController>().isloadingSearchStudent == true
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: Consumer<StudentController>(
                  builder: (context, studentcontroller, child) => RecentStudent(
                    listofstudent: studentcontroller.list_of_student,
                  ),
                ),
              ));
  }
}
