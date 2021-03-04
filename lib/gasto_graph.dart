import 'package:charts_flutter/flutter.dart' as chart;
import 'package:control_gastos/gastos.dart';
import 'package:flutter/material.dart';

class GastoChart extends StatelessWidget {
  final List<Gastos> data;

  GastoChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<chart.Series<Gastos, String>> gasto = [
      chart.Series(
        id: 'Gastos',
        data: data,
        domainFn: (Gastos gastos, _) => gastos.days,
        measureFn: (Gastos gastos, _) => gastos.gasto,
        colorFn: (Gastos gastos, _) => gastos.barColor,
      ),
    ];
    return Container(
      height: 250.0,
      child: Card(
        child: chart.BarChart(gasto, animate: true,),
      ),
    );
  }
}
