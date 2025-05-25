// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
//
// class ArabicLineChart extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           color: Colors.white,
//         ),
//         height: 250,
//         child: LineChart(
//           LineChartData(
//             minY: 0,
//             titlesData: FlTitlesData(
//               bottomTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   interval: 1,
//                   getTitlesWidget: (value, meta) {
//                     final labels = {
//                       0: '١٠ صباحاً',
//                       1: '١١ صباحاً',
//                       2: '١٢ مساءً',
//                       3: '١ مساءً',
//                       4: '٢ مساءً',
//                       5: '٣ مساءً',
//                       6: '٤ مساءً',
//                     };
//                     return Text(labels[value.toInt()] ?? '');
//                   },
//                 ),
//               ),
//               leftTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   getTitlesWidget: (value, meta) {
//                     return Text(['س', 'ص', 'ع', 'ف', 'ق'][value.toInt()] ?? '');
//                   },
//                   interval: 1,
//                 ),
//               ),
//               topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//               rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//             ),
//             gridData: FlGridData(show: false),
//             borderData: FlBorderData(show: false),
//             lineBarsData: [
//               LineChartBarData(
//                 isCurved: true,
//                 spots: [
//                   FlSpot(0, 4),
//                   FlSpot(1, 2),
//                   FlSpot(2, 3.5),
//                   FlSpot(3, 1.8),
//                   FlSpot(4, 3),
//                   FlSpot(5, 2),
//                   FlSpot(6, 1),
//                 ],
//                 barWidth: 3,
//                 isStrokeCapRound: true,
//                 belowBarData: BarAreaData(
//                   show: true,
//                   gradient: LinearGradient(
//                     colors: [
//                       Colors.purple.withOpacity(0.3),
//                       Colors.purple.withOpacity(0.0),
//                     ],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                 ),
//                 dotData: FlDotData(show: true),
//               ),
//             ],
//             lineTouchData: LineTouchData(
//               touchTooltipData: LineTouchTooltipData(
//                 // tooltipBgColor: Colors.purple,
//                 getTooltipItems: (touchedSpots) {
//                   return touchedSpots.map((spot) {
//                     return LineTooltipItem(
//                       '${spot.y.toInt()} رس',
//                       TextStyle(color: Colors.white),
//                     );
//                   }).toList();
//                 },
//               ),
//               handleBuiltInTouches: true,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
