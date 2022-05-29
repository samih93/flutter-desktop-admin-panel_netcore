import 'package:admin/controllers/product_controller.dart';
import 'package:admin/models/prdouct.dart';
import 'package:admin/shared/remote/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProductDataSource extends DataGridSource {
  List<Product> _products = [];
  BuildContext _context;

  ProductDataSource(this._context, this._products) {
    dataGridRows = _products
        .map<DataGridRow>((product) => getDataGridRow(product))
        .toList();
  }

  DataGridRow getDataGridRow(Product product) {
    return DataGridRow(cells: <DataGridCell>[
      DataGridCell<String>(columnName: 'id', value: product.id),
      DataGridCell<String>(columnName: 'name', value: product.name),
      DataGridCell<double>(columnName: 'price', value: product.price),
    ]);
  }

  List<DataGridRow> _productData = [];

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  /// Helps to hold the new value of all editable widget.
  /// Based on the new value we will commit the new value into the corresponding
  /// DataGridCell on onCellSubmit method.
  dynamic newCellValue;

  /// Help to control the editable text in [TextField] widget.
  TextEditingController editingController = TextEditingController();

  @override
  void onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    final dynamic oldValue = dataGridRow
            .getCells()
            .firstWhere((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            .value ??
        '';

    final int dataRowIndex = dataGridRows.indexOf(dataGridRow);

    if (newCellValue == null || oldValue == newCellValue) {
      return;
    }
// if (column.columnName == 'id') {
//       dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
//           DataGridCell<int>(columnName: 'id', value: newCellValue);
//       _products[dataRowIndex].id = newCellValue;
    // } else
    if (column.columnName == 'name') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'name', value: newCellValue);
      _products[dataRowIndex].name = newCellValue.toString();
    } else if (column.columnName == 'price') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'price', value: newCellValue);
      _products[dataRowIndex].price = double.parse(newCellValue.toString());
    }
  }

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    // Text going to display on editable widget
    final String displayText = dataGridRow
            .getCells()
            .firstWhere((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            .value
            ?.toString() ??
        '';

    // The new cell value must be reset.
    // To avoid committing the [DataGridCell] value that was previously edited
    // into the current non-modified [DataGridCell].
    newCellValue = null;

    bool isfirstColumn = column.columnName == "id";

    final int dataRowIndex = dataGridRows.indexOf(dataGridRow);

    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.centerLeft,
      child: TextField(
        autofocus: true,
        enabled: isfirstColumn ? false : true,
        controller: editingController..text = displayText,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
            suffixIcon: isfirstColumn
                ? SizedBox()
                : IconButton(
                    icon: Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      submitCell();
                      Product p = new Product();
                      // name
                      if (rowColumnIndex.columnIndex == 1)
                        p = new Product(
                            id: _products[dataRowIndex].id,
                            name: editingController.text,
                            price: _products[dataRowIndex].price);
                      // price
                      if (rowColumnIndex.columnIndex == 2)
                        p = new Product(
                            id: _products[dataRowIndex].id,
                            name: _products[dataRowIndex].name,
                            price: double.parse(editingController.text));
                      _context
                          .read<ProductController>()
                          .updateProduct(p)
                          .then((value) {
                        print('updated');
                      });
                    },
                  )),
        keyboardType: TextInputType.text,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            newCellValue = value;
          } else {
            newCellValue = null;
          }
        },
        onSubmitted: (String value) {
          print('test');
          // String name = rowColumnIndex.columnIndex == 1 ? value : '';
          // double price =
          //     rowColumnIndex.columnIndex == 1- ? double.parse(value) : 0;
          // Product p = new Product("2", name, price);
          // print("data row index $dataRowIndex");
          // print("columnIndex ${rowColumnIndex.columnIndex}");
          // DioHelper.dio!.put(
          //   "products",
          //   queryParameters: {"name": value, "price": value},
          // );
          // In Mobile Platform.
          // Call [CellSubmit] callback to fire the canSubmitCell and
          // onCellSubmit to commit the new value in single place.
          // submitCell();
        },
      ),
    );
  }

  RegExp _getRegExp(bool isNumericKeyBoard, String columnName) {
    return isNumericKeyBoard ? RegExp('[0-9]') : RegExp('[a-zA-Z ]');
  }
}
