import 'package:fl_chart/fl_chart.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:navigation_dashboard/ui/widgets/web/card_analytic/analytic_cards.dart';
import 'package:navigation_design/tokens/colors.dart';

class DashboardContentScreen extends StatelessWidget {
  
  const DashboardContentScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: const[
              Expanded(
                flex: 5,
                child: AnalyticCards()
              ),
            ],
          ),
          //const BarChartUsers(),

        ],
      ),
    );
  }
}

class BarChartUsers extends StatelessWidget {
  const BarChartUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 400,
      child: BarChart(
        BarChartData(
          borderData: FlBorderData(border: Border.all(width: 0)),
          groupsSpace: 15,
          titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles : SideTitles(
                  showTitles: true,
                  getTitlesWidget: (double value, a) {
                    if (value == 2) {
                      return const Text('jan 6', style : TextStyle(
                        color: grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ));
                    } if (value == 4) {
                      return const Text('jan 8', style : TextStyle(
                        color: grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ));
                    } else {
                      return const Text('');
                    }
                  }),  
              ),
          ),
          barGroups: [
            BarChartGroupData(x: 1, barRods: [
              BarChartRodData(
                toY: 10,
                width: 20,
                color: primaryColor,
                borderRadius: BorderRadius.circular(5),
              )
            ]),
            BarChartGroupData(x: 2, barRods: [
              BarChartRodData(
                  toY: 10,
                  width: 20,
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5)
              )
            ]),
            BarChartGroupData(x: 3, barRods: [
              BarChartRodData(
                  toY: 10,
                  width: 20,
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5)
              )
            ]),
            BarChartGroupData(x: 4, barRods: [
              BarChartRodData(
                  toY: 8,
                  width: 20,
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5)
              )
            ]),
            BarChartGroupData(x: 5, barRods: [
              BarChartRodData(
                  toY: 6,
                  width: 20,
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5)
              )
            ]),
            BarChartGroupData(x: 6, barRods: [
              BarChartRodData(
                  toY: 10,
                  width: 20,
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5)
              )
            ]),
            BarChartGroupData(x: 7, barRods: [
              BarChartRodData(
                  toY: 16,
                  width: 20,
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5)
              )
            ]),
            BarChartGroupData(x: 8, barRods: [
              BarChartRodData(
                  toY: 6,
                  width: 20,
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5)
              )
            ]),
            BarChartGroupData(x: 9, barRods: [
              BarChartRodData(
                  toY: 4,
                  width: 20,
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5)
              )
            ]),
            BarChartGroupData(x: 10, barRods: [
              BarChartRodData(
                  toY: 9,
                  width: 20,
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5)
              )
            ]),
            BarChartGroupData(x: 11, barRods: [
              BarChartRodData(
                  toY: 12,
                  width: 20,
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5)
              )
            ]),
            BarChartGroupData(x: 12, barRods: [
              BarChartRodData(
                  toY: 2,
                  width: 20,
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5)
              )
            ]),
          ])),
    );
  }
}