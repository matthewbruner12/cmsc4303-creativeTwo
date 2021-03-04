import 'package:flutter/material.dart';
import 'package:creativework2/model/transactions.dart';

class ViewExpensesScreen extends StatefulWidget {
  static const routeName = '/viewExpensesScreen';

  @override
  State<StatefulWidget> createState() {
    return _ViewExpensesState();
  }
}

class _ViewExpensesState extends State<ViewExpensesScreen> {
  _Controller con;
  double expenseTotal = 0;

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    List<Transaction> expenseTransactions = ModalRoute.of(context).settings.arguments;
    con.getTotal();
    return Scaffold(
      appBar: AppBar(
        title: Text("All Expenses"),
      ),
      body: Column(children: <Widget>[
        SizedBox(
          height: 15.0,
        ),
        Text(
          r"Balance $" + "$expenseTotal",
          style: TextStyle(color: Colors.red, fontSize: 40),
        ),
        SizedBox(
          height: 20.0,
        ),
        Expanded(
          child: Container(
            child: ListView.builder(
              itemCount: expenseTransactions.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  key: Key(expenseTransactions[index].toString()),
                  child: Card(
                    child: ListTile(
                      tileColor:
                          expenseTransactions[index].category ? Colors.green : Colors.red,
                      title: Text(
                        expenseTransactions[index].title,
                        style: TextStyle(fontSize: 24),
                      ),
                      trailing: Text(
                        expenseTransactions[index].amount.toString(),
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ]),
    );
  }
}

class _Controller {
  _ViewExpensesState state;
  _Controller(this.state);

  // controller functions
  // controller functions
  double getTotal() {
    double tot = 0;
    List<Transaction> expenseTransactions =
        ModalRoute.of(state.context).settings.arguments;
    for (var i = 0; i < expenseTransactions.length; i++) {
      tot += expenseTransactions[i].amount;
      state.expenseTotal = tot;
    }
    return tot;
  }
}
