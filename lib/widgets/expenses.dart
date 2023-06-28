import 'expenses_list/expenses_list.dart';
import 'new_expense.dart';
import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 19.99,
        date: DateTime.now(), // to get the time we use the intls package
        category: Category.work),
    Expense(
        title: 'Movie nanme jame meme',
        amount: 15.99,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  // this is modal sheet where we input the values
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true, // this makes sure we are in the safeare of all the devices
        isScrollControlled: true, // this helps to prevent overlap with the keyborad
        context: context,
        builder: (ctx) => NewExpense(onAddExpense: _addExpense));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  /// This function removes an expense from a list and displays a snackbar with an undo option.
  ///
  /// Args:
  ///   expense (Expense): an object of the Expense class that needs to be removed from the list of
  /// registered expenses.
  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars(); // clearing any previous snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  /// This function builds the main content of an expense tracker app, including an expenses list and a
  /// chart, and allows users to add new expenses.
  ///
  /// Args:
  ///   context (BuildContext): The BuildContext is a handle to the location of a widget in the widget
  /// tree. It is used by the framework to locate and update the widget. It is passed as a parameter to
  /// the build() method of a widget.
  ///
  /// Returns:
  ///   A `Scaffold` widget with an `AppBar` and a `Column` as its body. The `AppBar` contains an
  /// `IconButton` to open an overlay for adding expenses and a `Text` widget as its title. The `Column`
  /// contains a `Chart` widget and an `Expanded` widget with either a `Center` widget displaying a
  /// message or an `ExpensesList` widget
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;// MediaQuery give us access the device parameters
    print(MediaQuery.of(context).size.height);
    Widget mainContent = const Center(
      child: Text('No expense found. Start adding some!'),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
          expenses: _registeredExpenses, onRemoveExpense: _removeExpense);
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
        title: const Text('Expense Tracker'),
      ),
      body: width < 600 // for making the app responsive
          ? Column( // redering widget conditionally
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(child: mainContent)
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(child: mainContent)
              ],
            ),
    );
  }
}
