import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChart extends StatelessWidget {
  const LineChart({
    @required this.series,
    this.radius = 10,
    this.width = 400,
    this.height = 200,
    this.title = '',
    this.titleAlignment = ChartAlignment.near,
    this.titleStyle,
    this.fontSize = 13,
    this.fontWeight = FontWeight.bold,
    this.palette,
    this.tooltipBehavior = true,
    this.trackballBehavior,
    this.xElements = 10,
    this.xInterval = 1,
    this.zoomPanBehavior,
    key,
  }) : super(key: key);

  final List<ChartSeries<dynamic, dynamic>> series;
  final double radius;
  final double width;
  final double height;
  final String title;
  final ChartAlignment titleAlignment;
  final TextStyle titleStyle;
  final double fontSize;
  final FontWeight fontWeight;
  final List<Color> palette;
  final bool tooltipBehavior;
  final TrackballBehavior trackballBehavior;
  final double xElements;
  final double xInterval;
  final ZoomPanBehavior zoomPanBehavior;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      child: Container(
        width: width,
        height: height,
        child: SfCartesianChart(
          title: ChartTitle(
            text: title,
            alignment: titleAlignment,
            textStyle: titleStyle ??
                TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
          ),
          palette: palette ?? [Theme.of(context).accentColor],
          tooltipBehavior: TooltipBehavior(enable: tooltipBehavior),
          trackballBehavior: trackballBehavior ??
              TrackballBehavior(
                enable: true,
                tooltipSettings: InteractiveTooltip(
                  format: 'point.y%',
                ),
              ),
          primaryYAxis: NumericAxis(
            maximum: 100,
            minimum: 0,
          ),
          onAxisLabelRender: (args) {
            if (args.axisName == 'primaryXAxis') {
              args.text = args.value.floor().toString();
              final a = args.axis.interval;
            }
          },
          primaryXAxis: NumericAxis(
            maximumLabels: xElements.toInt(),
            visibleMaximum: series.first.dataSource.length.toDouble() < xElements
                ? xElements
                : series.first.dataSource.length.toDouble(),
            visibleMinimum: series.first.dataSource.length.toDouble() - xElements < 1
                ? 1
                : series.first.dataSource.length.toDouble() - xElements - 1,
            interval: xInterval,
          ),
          zoomPanBehavior: zoomPanBehavior ??
              ZoomPanBehavior(
                enablePanning: series.first.dataSource.length.toDouble() < xElements ? false : true,
              ),
          series: series,
        ),
      ),
    );
  }
}
