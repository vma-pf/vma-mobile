import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GrowthMetrics extends StatelessWidget {
  final double maxWeight;
  final List<int> months;
  final List<(double, double)> weightPoints;
  final List<(double, double)> heightPoints;
  final List<(double, double)> widthPoints;
  const GrowthMetrics({
    super.key,
    required this.maxWeight,
    required this.months,
    required this.weightPoints,
    required this.heightPoints,
    required this.widthPoints,
  });

  Widget _buildLineChart() {
    return LineChart(
      lineChartData,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get lineChartData => LineChartData(
        lineTouchData: lineTouchData,
        gridData: gridData,
        titlesData: titlesData,
        borderData: borderData,
        lineBarsData: lineBarsData,
        minX: 0,
        minY: 0,
        maxX: months.length.toDouble(),
        maxY: maxWeight,
      );

  LineTouchData get lineTouchData => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => Colors.blueGrey.withOpacity(0.6),
        ),
      );

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.black, width: 2),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  List<LineChartBarData> get lineBarsData => [
        _createLineChartBarData(weightPoints, Colors.red),
        _createLineChartBarData(heightPoints, Colors.green),
        _createLineChartBarData(widthPoints, Colors.blue),
      ];

  LineChartBarData _createLineChartBarData(
    List<(double, double)> points,
    Color color,
  ) {
    return LineChartBarData(
      isCurved: true,
      color: color,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: [
        const FlSpot(0, 0),
        ...points.map((point) => FlSpot(point.$1, point.$2)),
      ],
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: rightTitles,
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles,
        ),
      );

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    final valueIsZero = value == 0;
    final text = valueIsZero ? '' : value.toInt().toString();
    Widget textWidget = Text(
      text,
      style: style,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: textWidget,
    );
  }

  SideTitles get leftTitles => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: maxWeight / 5,
        reservedSize: 50,
      );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    final valueIsZero = value == 0;
    final text = valueIsZero ? '' : '${value.toInt().toString()} kg';

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles get rightTitles => SideTitles(
        getTitlesWidget: rightTitleWidgets,
        showTitles: true,
        interval: 200 / 5, // 200cm is the max height
        reservedSize: 50,
      );

  Widget rightTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    final valueIsZero = value == 0;
    final text = valueIsZero ? '' : '${value.toInt().toString()} cm';

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  Widget _buildDescriptionItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          color: color,
        ),
        Container(
          width: 10,
        ),
        Text(text),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.1,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 25,
              ),
              Text(
                'Chỉ số tăng trưởng',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 25,
              ),
              Expanded(
                child: _buildLineChart(),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Column(
                  children: [
                    _buildDescriptionItem(Colors.red, 'Cân nặng'),
                    _buildDescriptionItem(Colors.green, 'Chiều cao'),
                    _buildDescriptionItem(Colors.blue, 'Chiều rộng'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
