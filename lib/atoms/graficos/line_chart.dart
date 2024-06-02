import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tg_fatec/controllers/reporte_controller.dart';

class ChartData {
  final double x;
  final double y;
  final String label;

  ChartData({required this.x, required this.y, required this.label});
}

List<ChartData> chartData({required Map<String, dynamic> result}) {
  // Converte as chaves do mapa para DateTime para ordenar corretamente
  final data = result.entries.map((e) {
    final monthYear = DateFormat('MMM/yyyy').parse(e.key);
    return MapEntry(monthYear, e.value);
  }).toList()
    ..sort((a, b) => a.key.compareTo(b.key)); // Ordena os dados

  // Mapeia os dados ordenados para ChartData
  return data.mapIndexed((index, entry) {
    final label = DateFormat('MMM/yyyy').format(entry.key);
    return ChartData(x: index.toDouble(), y: entry.value, label: label);
  }).toList();
}

class MyLineChart extends StatefulWidget {
  final List<ChartData> points;
  final List<String> labels;
  MyLineChart(this.points, this.labels, {Key? key}) : super(key: key);

  @override
  State<MyLineChart> createState() => _MyLineChartState();
}

class _MyLineChartState extends State<MyLineChart> {
  ReportController controller = ReportController();



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.only(right: 16,bottom: 16, top: 25),
        child: AspectRatio(
          aspectRatio: 3,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                    barWidth: 1,
                    gradient: LinearGradient(colors: [Colors.cyan, Colors.green, Colors.yellow]),
                    spots: widget.points.map((point) => FlSpot(point.x, point.y)).toList(),
                    dotData: FlDotData(show: true, getDotPainter: (spot, percent, bar, index) {
                      final point = widget.points[index];
                      return FlDotCirclePainter(
                        radius: 4,
                        color: Colors.cyan,
                        strokeWidth: 2,

                      );
                    })),
              ],
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  axisNameWidget: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Meses',
                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),textAlign: TextAlign.center,
                    ),
                  ),
                  axisNameSize: 16,
                  drawBelowEverything: true,
                  sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 20,
                      interval: 4,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < widget.labels.length) {
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 50,
                            // Coloca o espaço adicional entre o título e o eixo
                            child: Text(
                              widget.labels[index],
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 10),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      }),
                ),
                leftTitles: AxisTitles(
                  axisNameWidget: const Text(
                    'Valor das Vendas',
                    style: TextStyle(color: Colors.cyan, fontSize: 12, fontWeight: FontWeight.w900, ),
                  ),
                  axisNameSize: 40,
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 70,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toStringAsFixed(2).replaceAll('.', ','),
                        style: const TextStyle(color: Colors.white, fontSize: 10),
                      );
                    },
                    interval: 500,
                  ),// Ajuste conforme necessário para seus dados
                  drawBelowEverything: true,
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                  axisNameWidget: Padding(
                    padding: EdgeInsets.all(16),
                    child: Container(
                      height: Get.height * 0.04,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                      'Vendas de Produtos Mês á Mês',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                                    ),
                    ),
                  ),
                  axisNameSize: 65,

                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                  axisNameSize: 65,
                ),
              ),
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (touchedSpots){
                    return touchedSpots.map((spot) {
                      final point = widget.points[spot.spotIndex];
                      //controller.updateTouchedData(point);
                      controller.touchedLabel.value = point.label;
                      controller.touchedValue.value = point.y;
                      controller.update();

                      return LineTooltipItem(
                        '${point.label}\nR\$ ${point.y.toStringAsFixed(2).replaceAll(".", ",")}',
                        TextStyle(color: Colors.cyan),
                      );
                    }).toList();
                  },
                  showOnTopOfTheChartBoxArea: true,
                  fitInsideHorizontally: true
                )
              )
            ),
          ),
        ),
      ),
    );
  }
}
