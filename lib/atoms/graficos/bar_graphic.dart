import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartGraphic extends StatelessWidget {
  final List<double> barValues;
  final double y;

  const BarChartGraphic({super.key, required this.barValues, required this.y});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: y + 500,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      getTooltipColor: (group) => Colors.transparent,
      tooltipPadding: EdgeInsets.zero,
      tooltipMargin: 4,
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,

          ) {
        return BarTooltipItem(
          "R\$${rod.toY.round().toStringAsFixed(2).replaceAll(".", ",")}",
          const TextStyle(
            color: Colors.cyan,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Max';
        break;
      case 1:
        text = 'Min';
        break;
      case 2:
        text = 'Média';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: getTitles,
      ),
    ),
    leftTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );

  FlBorderData get borderData => FlBorderData(
    show: true,
    border: Border.all(
      color: Colors.white, // Set the border color here
      width: 2, // Set the border width here
    ),
  );

  LinearGradient get _barsGradient => LinearGradient(
    colors: [
      Colors.yellow,
      Colors.cyan,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  List<BarChartGroupData> get barGroups {
    return List.generate(barValues.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: barValues[index],
            gradient: _barsGradient,
            width: 15
          )
        ],
        showingTooltipIndicators: [0],
      );
    });
  }
}

class BarChartSample3 extends StatefulWidget {
  final Map<String, dynamic> result;

  BarChartSample3({Key? key, required this.result}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    // Example: extract bar values from the result map
    List<double> barValues = [widget.result["maxPrice"], widget.result["minPrice"], widget.result["median"]] ?? [0.0,0.0,0.0] ;
    double y = widget.result["maxPrice"];
    return AspectRatio(
      aspectRatio: 1.6,
      child: BarChartGraphic(barValues: barValues, y: y,),
    );
  }
}