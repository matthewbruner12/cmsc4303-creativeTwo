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
    Transaction(title: 'Doordash', amount: 40, category: true),
    Transaction(title: 'Groceries', amount: 25, category: false),
  ];
}
