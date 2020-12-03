import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class DataGrid extends StatelessWidget {
  const DataGrid({
    @required this.source,
    @required this.columns,
    this.radius = 10,
    this.width = 400,
    this.height = 350,
    this.gridLineStrokeWidth = 0.5,
    this.headerBGColor,
    this.headerTextStyle,
    this.footerFrozenRowsCount = 1,
    this.cellBuilder,
    key,
  }) : super(key: key);

  final DataGridSource<Object> source;
  final List<GridColumn> columns;
  final double radius;
  final double width;
  final double height;
  final double gridLineStrokeWidth;
  final Color headerBGColor;
  final TextStyle headerTextStyle;
  final int footerFrozenRowsCount;
  final Widget Function(BuildContext, GridColumn, int) cellBuilder;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        child: Container(
          height: height,
          // width: width,
          child: SfDataGridTheme(
            data: SfDataGridThemeData(
              gridLineStrokeWidth: gridLineStrokeWidth,
              headerStyle: DataGridHeaderCellStyle(
                backgroundColor: headerBGColor ?? Theme.of(context).buttonColor,
                textStyle: headerTextStyle ??
                    const TextStyle(
                      color: Colors.white,
                    ),
              ),
            ),
            child: SfDataGrid(
              source: source,
              cellBuilder: cellBuilder,
              footerFrozenRowsCount: footerFrozenRowsCount,
              columns: columns,
            ),
          ),
        ),
      ),
    );
  }
}
