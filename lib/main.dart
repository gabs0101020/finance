import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicativo de Despesas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExpenseHomePage(),
    );
  }
}

class ExpenseHomePage extends StatelessWidget {
  final List<double> monthlyExpenses = [500, 600, 750, 800, 550, 300];
  final List<String> categories = ["Aluguel", "Comida", "Transporte", "Lazer", "Saúde", "Outros"];
  final List<double> categoryExpenses = [1500, 800, 300, 400, 200, 100];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Despesas Mensais',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 300,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 1000,
                    barTouchData: BarTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (context, value) =>
                            const TextStyle(color: Colors.black, fontSize: 10),
                        margin: 16,
                        getTitles: (double value) {
                          switch (value.toInt()) {
                            case 0:
                              return 'Jan';
                            case 1:
                              return 'Fev';
                            case 2:
                              return 'Mar';
                            case 3:
                              return 'Abr';
                            case 4:
                              return 'Mai';
                            case 5:
                              return 'Jun';
                            default:
                              return '';
                          }
                        },
                      ),
                      leftTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (context, value) =>
                            const TextStyle(color: Colors.black, fontSize: 10),
                        margin: 16,
                        reservedSize: 14,
                        interval: 200,
                        getTitles: (value) {
                          return value.toInt().toString();
                        },
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: monthlyExpenses
                        .asMap()
                        .entries
                        .map((entry) => BarChartGroupData(x: entry.key, barRods: [
                              BarChartRodData(
                                y: entry.value,
                                colors: [Colors.lightBlueAccent, Colors.blueAccent],
                              )
                            ]))
                        .toList(),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Text(
                'Distribuição das Despesas por Categoria',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 300,
                child: PieChart(
                  PieChartData(
                    sections: categoryExpenses
                        .asMap()
                        .entries
                        .map((entry) => PieChartSectionData(
                              color: Colors.primaries[entry.key % Colors.primaries.length],
                              value: entry.value,
                              title: categories[entry.key],
                              radius: 100,
                              titleStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ))
                        .toList(),
                    sectionsSpace: 2,
                    centerSpaceRadius: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
