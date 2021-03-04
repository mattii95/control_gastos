import 'package:control_gastos/gasto_graph.dart';
import 'package:flutter/material.dart';
import 'package:control_gastos/gastos.dart';
import 'package:charts_flutter/flutter.dart' as chart;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control de Gastos',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _controller;
  int currentPage = 9;

  @override
  void initState() {
    _controller = PageController(
      initialPage: currentPage,
      viewportFraction: 0.4,
    );
  }

  Widget _bottomAction(IconData iconData) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Icon(iconData),
      ),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8.0,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _bottomAction(FontAwesomeIcons.chartBar),
            _bottomAction(FontAwesomeIcons.chartPie),
            SizedBox(width: 32.0),
            _bottomAction(FontAwesomeIcons.wallet),
            _bottomAction(Icons.settings),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          _selector(),
          _expenses(),
          _graph(),
          Container(
            color: Colors.indigo.withOpacity(0.15),
            height: 20.0,
          ),
          _list(),
        ],
      ),
    );
  }

  Widget _pageItem(String name, int position) {
    var _aligment;

    final selected = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Colors.indigo,
    );

    final unselected = TextStyle(
      fontSize: 20.0,
      color: Colors.indigo.withOpacity(0.4),
    );

    if (position == currentPage) {
      _aligment = Alignment.center;
    } else if (position > currentPage) {
      _aligment = Alignment.centerRight;
    } else {
      _aligment = Alignment.centerLeft;
    }

    return Align(
      alignment: _aligment,
      child: Text(
        name,
        style: position == currentPage ? selected : unselected,
      ),
    );
  }

  Widget _selector() {
    return SizedBox.fromSize(
      size: Size.fromHeight(70.0),
      child: PageView(
        onPageChanged: (newPage){
          setState(() {
            currentPage = newPage;
          });
        },
        controller: _controller,
        children: <Widget>[
          _pageItem("Enero", 0),
          _pageItem("Febrero", 1),
          _pageItem("Marzo", 2),
          _pageItem("Abril", 3),
          _pageItem("Mayo", 4),
          _pageItem("Junio", 5),
          _pageItem("Julio", 6),
          _pageItem("Agosto", 7),
          _pageItem("Septiembre", 8),
          _pageItem("Octubre", 9),
          _pageItem("Noviembre", 10),
          _pageItem("Diciembre", 11),
        ],
      ),
    );
  }

  Widget _expenses() {
    return Column(
      children: <Widget>[
        Text(
          '\$3000',
          style: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Total expenses',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }

  Widget _graph() {
    final List<Gastos> data = [
      Gastos(
          days: "01",
          gasto: 500,
          barColor: chart.ColorUtil.fromDartColor(Colors.indigo)),
      Gastos(
          days: "05",
          gasto: 300,
          barColor: chart.ColorUtil.fromDartColor(Colors.indigo)),
      Gastos(
          days: "10",
          gasto: 1200,
          barColor: chart.ColorUtil.fromDartColor(Colors.indigo)),
      Gastos(
          days: "15",
          gasto: 1000,
          barColor: chart.ColorUtil.fromDartColor(Colors.indigo)),
      Gastos(
          days: "20",
          gasto: 654,
          barColor: chart.ColorUtil.fromDartColor(Colors.indigo)),
      Gastos(
          days: "25",
          gasto: 3500,
          barColor: chart.ColorUtil.fromDartColor(Colors.indigo)),
      Gastos(
          days: "30",
          gasto: 200,
          barColor: chart.ColorUtil.fromDartColor(Colors.indigo)),
    ];
    return GastoChart(
      data: data,
    );
  }

  Widget _item(IconData icon, String name, int percent, double value) {
    return ListTile(
      leading: Icon(
        icon,
        size: 32.0,
        color: Colors.indigo,
      ),
      title: Text(
        name,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        "$percent% of expenses",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.blueGrey,
        ),
      ),
      trailing: Container(
        decoration: BoxDecoration(
          color: Colors.indigo.withOpacity(0.3),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "\$$value",
            style: TextStyle(
              color: Colors.indigo,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _list() {
    return Expanded(
      child: ListView.separated(
        itemCount: 15,
        itemBuilder: (BuildContext context, int index) =>
            _item(FontAwesomeIcons.shoppingCart, 'Shopping', 14, 145.12),
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.indigo.withOpacity(0.15),
            height: 6.0,
          );
        },
      ),
    );
  }
}
