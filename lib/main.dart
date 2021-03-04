import 'package:flutter/material.dart';
import 'package:creativework2/screen/portfolio_screen.dart';
import 'package:creativework2/screen/expense_screen.dart';
import 'package:creativework2/screen/profit_screen.dart';

void main() {
  runApp(CreativeWork2());
}

class CreativeWork2 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: PortfolioHomeScreen.routeName,
      routes: {
        PortfolioHomeScreen.routeName: (context) => PortfolioHomeScreen(),
        ViewProfitsScreen.routeName: (context) => ViewProfitsScreen(),
        ViewExpensesScreen.routeName: (context) => ViewExpensesScreen(),
      },
    );
  }
}
