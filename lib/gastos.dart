import 'package:charts_flutter/flutter.dart' as chart;
import 'package:flutter/cupertino.dart';

class Gastos {
  final String days;
  final int gasto;
  final chart.Color barColor;

  Gastos({
    @required this.days,
    @required this.gasto,
    @required this.barColor,
  });
}
