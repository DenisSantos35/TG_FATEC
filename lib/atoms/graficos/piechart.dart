import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartGraphic extends StatefulWidget {
  Map<String, dynamic> result;

  PieChartGraphic({Key? key, required this.result}) : super(key: key);

  @override
  State<PieChartGraphic> createState() => _PieChartGraphicState(result: result);
}

class _PieChartGraphicState extends State<PieChartGraphic> {
  Map<String, dynamic> result;
  _PieChartGraphicState({required this.result});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
                title:
                "R\$ ${result["countVista"].toStringAsFixed(0)}",
                titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900),
                titlePositionPercentageOffset:
                BorderSide.strokeAlignOutside,
                value: result["countVista"],
                color: Color(0xff79EB3B)),
            PieChartSectionData(
                title:
                "R\$${result["countPrazo"].toStringAsFixed(0)}",
                titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                titlePositionPercentageOffset:
                BorderSide.strokeAlignOutside,
                badgePositionPercentageOffset: 10,
                value: result["countPrazo"],
                color: Colors.cyan),
          ],
          startDegreeOffset: -50,
          sectionsSpace: 2,
          centerSpaceRadius: 60,
        ),
        swapAnimationDuration:
        const Duration(milliseconds: 750),
        swapAnimationCurve: Easing.linear,
      ),
    );
  }
}
