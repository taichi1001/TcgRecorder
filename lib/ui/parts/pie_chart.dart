import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatelessWidget {
  const PieChart({
    @required this.series,
    this.radius = 10,
    this.width = 400,
    this.height = 280,
    this.title = '',
    this.titleAlignment = ChartAlignment.near,
    this.titleStyle,
    this.legendIsVisible = true,
    this.legendPosition = LegendPosition.right,
    this.legendOverFlowMode = LegendItemOverflowMode.wrap,
    this.tooltipBehavior = true,
    key,
  }) : super(key: key);

  final List<CircularSeries<dynamic, dynamic>> series;
  final double radius;
  final double width;
  final double height;
  final String title;
  final ChartAlignment titleAlignment;
  final TextStyle titleStyle;
  final bool legendIsVisible;
  final LegendPosition legendPosition;
  final LegendItemOverflowMode legendOverFlowMode;
  final bool tooltipBehavior;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      child: Container(
        width: width.w,
        height: height.h,
        child: SfCircularChart(
          title: ChartTitle(
            text: title,
            alignment: titleAlignment,
            textStyle: titleStyle ??
                const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
          ),
          legend: Legend(
            isVisible: legendIsVisible,
            position: legendPosition,
            overflowMode: legendOverFlowMode,
            width: '40%',
          ),
          tooltipBehavior: TooltipBehavior(
            enable: tooltipBehavior,
            format: 'point.y%',
          ),
          series: series,
        ),
      ),
    );
  }
}
