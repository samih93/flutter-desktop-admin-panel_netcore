import 'package:admin/screens/dashboard/components/recent_files.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:flutter/material.dart';

class TransactionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: RecentFiles(),
      ),
    );
  }
}
