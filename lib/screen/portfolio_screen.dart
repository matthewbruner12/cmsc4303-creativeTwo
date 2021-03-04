import 'package:creativework2/screen/expense_screen.dart';
import 'package:creativework2/screen/profit_screen.dart';
import 'package:flutter/material.dart';
import 'package:creativework2/model/transactions.dart';

class PortfolioHomeScreen extends StatefulWidget {
  static const routeName = '/portfolioHomeScreen';

  @override
  State<StatefulWidget> createState() {
    return _PortfolioHomeState();
  }
}

class _PortfolioHomeState extends State<PortfolioHomeScreen> {
  _Controller con;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  double total = 0;

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Money Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: con.viewProfits,
          ),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: con.viewExpenses,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "New Transaction",
                                    style: Theme.of(context).textTheme.headline6,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Title',
                                      style: Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: TextFormField(
                                      validator: con.validateTitle,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Amount',
                                      style: Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: TextFormField(
                                      validator: con.validateAmount,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Category',
                                      style: Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: TextFormField(
                                      validator: con.validateCategory,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              RaisedButton(
                                onPressed: con.addTransaction,
                                child: Text(
                                  'Add',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Column(children: <Widget>[
        SizedBox(
          height: 15.0,
        ),
        con.getTotal() > 0
            ? Text(
                r"Balance $" + "${total.abs()}",
                style: TextStyle(color: Colors.green, fontSize: 40),
              )
            : Text(
                r"Balance $" + "${total.abs()}",
                style: TextStyle(color: Colors.red, fontSize: 40),
              ),
        SizedBox(
          height: 20.0,
        ),
        Expanded(
          child: Container(
            child: ListView.builder(
              itemCount: Transaction.fakeDB.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(Transaction.fakeDB[index].toString()),
                  child: Card(
                    child: ListTile(
                      tileColor:
                          Transaction.fakeDB[index].category ? Colors.green : Colors.red,
                      title: Text(
                        Transaction.fakeDB[index].title,
                        style: TextStyle(fontSize: 24),
                      ),
                      trailing: Text(
                        Transaction.fakeDB[index].amount.toString(),
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      total -= Transaction.fakeDB[index].amount;
                      Transaction.fakeDB.removeAt(index);
                    });
                  },
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
  _PortfolioHomeState state;
  _Controller(this.state);

  // controller functions
  String title;
  double amount;
  bool category;

  void addTransaction() {
    if (!state.formKey.currentState.validate()) return;

    state.formKey.currentState.save();
    Transaction.fakeDB.add(Transaction(
      title: title,
      amount: amount,
      category: category,
    ));

    Navigator.of(state.context).pop();
    FocusScope.of(state.context).unfocus();
  }

  String validateTitle(String value) {
    if (value.length < 2) {
      return 'min 2 chars';
    } else {
      title = value;
      return null;
    }
  }

  String validateAmount(String value) {
    try {
      double total = double.parse(value);
      if (total >= 0) {
        amount = total;
        return null;
      } else
        return 'Value cannot be negative';
    } catch (e) {
      return 'Not valid amount';
    }
  }

  String validateCategory(String value) {
    try {
      String charCategory = value.toLowerCase();
      charCategory = value.trim();
      if (charCategory == "p") {
        category = true;
        return null;
      } else if (charCategory == "e") {
        category = false;
        return null;
      } else
        return 'Enter P for Profit / E for expenses';
    } catch (e) {
      return 'Not valid category';
    }
  }

  double getTotal() {
    double tot = 0;
    for (var i = 0; i < Transaction.fakeDB.length; i++) {
      if (Transaction.fakeDB[i].category)
        tot += Transaction.fakeDB[i].amount;
      else
        tot -= Transaction.fakeDB[i].amount;
      state.total = tot;
    }
    return tot;
  }

  void viewProfits() async {
    List<Transaction> transactions = [];
    for (int i = 0; i < Transaction.fakeDB.length; i++) {
      if (Transaction.fakeDB[i].category) {
        transactions.add(Transaction.fakeDB[i]);
      }
    }
    await Navigator.pushNamed(state.context, ViewProfitsScreen.routeName,
        arguments: transactions);
  }

  void viewExpenses() async {
    List<Transaction> transactions = [];
    for (int i = 0; i < Transaction.fakeDB.length; i++) {
      if (!Transaction.fakeDB[i].category) {
        transactions.add(Transaction.fakeDB[i]);
      }
    }
    await Navigator.pushNamed(state.context, ViewExpensesScreen.routeName,
        arguments: transactions);
  }
}
