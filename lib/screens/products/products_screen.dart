import 'package:admin/models/student.dart';
import 'package:admin/screens/dashboard/components/recent_files.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:admin/screens/transactions/components/RecentStudent.dart';
import 'package:admin/shared/remote/dio_helper.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: RecentFiles());
  }
}
