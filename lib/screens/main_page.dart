import 'package:flutter/material.dart';
import 'package:test_case/screens/auth_page.dart';
import 'package:test_case/screens/calculator_page.dart';
import 'package:test_case/screens/weather_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: const Text('Test case app')),
        bottomNavigationBar: const TabBar(
          tabs: <Widget>[
            Tab(icon: Icon(Icons.account_circle)),
            Tab(icon: Icon(Icons.calculate)),
            Tab(icon: Icon(Icons.cloud)),
          ],
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(child: AuthPage()),
            Center(child: CalculatorPage()),
            Center(child: WeatherPage()),
          ],
        ),
      ),
    );
  }
}
