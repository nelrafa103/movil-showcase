import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyectofinal/models/bar_chart.dart';
import 'package:proyectofinal/models/pokemon.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StatsGraph extends StatefulWidget {
  final Color color;

  final List<Stat> stats;
  StatsGraph({super.key, required this.color, required this.stats});

  @override
  State<StatefulWidget> createState() {
    return _StatsGraph();
  }
}

class _StatsGraph extends State<StatsGraph> {
  @override
  Widget build(BuildContext context) {
    final List<BarChartModel> data = [
      BarChartModel(
        label: "HP",
        value: widget.stats.elementAt(0).baseStat,
      ),
      BarChartModel(
        label: "Attack",
        value: widget.stats.elementAt(1).baseStat,
      ),
      BarChartModel(
        label: "Defense",
        value: widget.stats.elementAt(2).baseStat,
      ),
      BarChartModel(
        label: "Special-Attack",
        value: widget.stats.elementAt(3).baseStat,
      ),
      BarChartModel(
        label: "Special-Defense",
        value: widget.stats.elementAt(4).baseStat,
      ),
      BarChartModel(
        label: "Speed",
        value: widget.stats.elementAt(5).baseStat,
      ),
    ];

    List<charts.Series<BarChartModel, String>> series = [
      charts.Series(
        id: "value",
        data: data,
        domainFn: (BarChartModel series, _) => series.label,
        measureFn: (BarChartModel series, _) => series.value,
        colorFn: (BarChartModel series, _) =>
            charts.ColorUtil.fromDartColor(widget.color),
        // Agrega el valor dentro de cada barra
        labelAccessorFn: (BarChartModel series, _) =>
        '${series.label}: ${series.value.toString()}',
        insideLabelStyleAccessorFn: (BarChartModel series, _) {
          const color = charts.MaterialPalette.white;
          return charts.TextStyleSpec(
              color: color,
              fontFamily: GoogleFonts.montserrat(fontWeight: FontWeight.w700).fontFamily,
          );
        },
      ),
    ];

    return Container(
      child: charts.BarChart(
        series,
        animate: true,
        vertical: false,
        defaultRenderer: charts.BarRendererConfig(
          cornerStrategy: const charts.ConstCornerStrategy(10),
          barRendererDecorator: charts.BarLabelDecorator(),
        ),
        domainAxis:
        const charts.OrdinalAxisSpec(renderSpec: charts.NoneRenderSpec()),
      ),
    );
  }
}