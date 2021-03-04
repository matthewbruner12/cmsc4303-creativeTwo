import 'package:flutter/material.dart';
import 'package:creativework2/model/transactions.dart';

class ViewProfitsScreen extends StatefulWidget {
  static const routeName = '/viewProfitsScreen';

  @override
  State<StatefulWidget> createState() {
    return _ViewProfitsState();
  }
}

class _ViewProfitsState extends State<ViewProfitsScreen> {
  _Controller con;
  double profitTotal = 0;
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
    List<Transaction> profitTransactions = ModalRoute.of(context).settings.arguments;
    con.getTotal();

    return Scaffold(
      appBar: AppBar(
        title: Text("All Profits"),
      ),
      body: Column(children: <Widget>[
        SizedBox(
          height: 15.0,
        ),
        Text(
          r"Balance $" + "$profitTotal",
          style: TextStyle(color: Colors.green, fontSize: 40),
        ),
        SizedBox(
          height: 20.0,
        ),
        Expanded(
          child: Container(
            child: ListView.builder(
              itemCount: profitTransactions.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  key: Key(profitTransactions[index].toString()),
                  child: Card(
                    child: ListTile(
                      tileColor:
                          profitTransactions[index].category ? Colors.green : Colors.red,
                      title: Text(
                        profitTransactions[index].title,
                        style: TextStyle(fontSize: 24),
                      ),
                      trailing: Text(
                        profitTransactions[index].amount.toString(),
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
  _ViewProfitsState state;
  _Controller(this.state);

  // controller functions
  void getTotal() {
    double tot = 0;
    List<Transaction> profitTransactions =
        ModalRoute.of(state.context).settings.arguments;
    for (var i = 0; i < profitTransactions.length; i++) {
      tot += profitTransactions[i].amount;
      state.profitTotal = tot;
    }
  }
}
