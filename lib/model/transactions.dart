class Transaction {
  String title;
  double amount;
  bool category;

  Transaction({
    this.title = "",
    this.amount = 0,
    this.category = true,
  });

  @override
  String toString() {
    return 'Transaction[title=$title amount=$amount]';
  }

  static List<Transaction> fakeDB = [
    Transaction(title: 'Paycheck', amount: 1000, category: true),
    Transaction(title: 'Groceries', amount: 75, category: false),
    Transaction(title: 'Food', amount: 15, category: false),
    Transaction(title: 'Custom', amount: 150, category: true),
    Transaction(title: 'Lottery', amount: 500, category: true),
    Transaction(title: 'Bills', amount: 200, category: false),
  ];
}
