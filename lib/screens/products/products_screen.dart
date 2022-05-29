import 'package:admin/controllers/product_controller.dart';
import 'package:admin/models/prdouct.dart';
import 'package:admin/models/student.dart';
import 'package:admin/screens/dashboard/components/recent_files.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:admin/screens/products/components/product_data_source.dart';
import 'package:admin/screens/transactions/components/RecentStudent.dart';
import 'package:admin/shared/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProductScreen extends StatefulWidget {
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product> products = <Product>[];
  ProductDataSource? productDataSource;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getProductData().then((value) {});
    });
  }

  Future<void> getProductData() async {
    context.read<ProductController>()..getallProduct();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: context.watch<ProductController>().isloadingGetProduct == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SfDataGrid(
              selectionMode: SelectionMode.single,
              allowEditing: true,
              source: ProductDataSource(
                  products: context.watch<ProductController>().list_of_product),
              columnWidthMode: ColumnWidthMode.fill,
              columns: <GridColumn>[
                GridColumn(
                    columnName: 'id',
                    label: Container(
                        padding: EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: Text(
                          'ID',
                        ))),
                GridColumn(
                    columnName: 'name',
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text('Name'))),
                GridColumn(
                    columnName: 'Price',
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          'Price',
                          overflow: TextOverflow.ellipsis,
                        ))),
              ],
            ),
    );
  }
}
