import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChart extends StatelessWidget {
  const LineChart({
    @required this.series,
    this.radius = 10,
    this.width = 400,
    this.height = 280,
    this.title = '',
    this.titleAlignment = ChartAlignment.near,
    this.titleStyle,
    this.fontSize = 14,
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
  final int xElements;
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
                tooltipSettings: InteractiveTooltip(),
              ),
          primaryYAxis: NumericAxis(
            maximum: 100,
            minimum: 0,
          ),
          onAxisLabelRender: (args) {
            if (args.axisName == 'primaryXAxis') {
              args.text = args.value.floor().toString();
            }
          },
          onLegendItemRender: (LegendRenderArgs args) {
            args.text = '${args.text}%';
          },
          primaryXAxis: NumericAxis(
            visibleMaximum:
                series.length.toDouble() < xElements ? xElements : series.length.toDouble(),
            visibleMinimum:
                series.length.toDouble() - xElements < 0 ? 0 : series.length.toDouble() - xElements,
            interval: xInterval,
          ),
          zoomPanBehavior: zoomPanBehavior ??
              ZoomPanBehavior(
                enablePanning: true,
              ),
          series: series,
        ),
      ),
    );
  }
}
