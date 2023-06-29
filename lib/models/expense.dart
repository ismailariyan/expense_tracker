import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat
    .yMd(); // here we are using the intl package to formate the date into a better way

const uuid = Uuid(); // is for generating index for the expenses

enum Category { food, travel, leisure, work }

// this is map of the category and their assosciated Icons
const categoryIcons = {
  Category.food: Icons.dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  //this is the constructor class which takes in all the info to instantiate an object of EXPENSE
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();
  // here the uuid created a new id everytime the Expense object is instatiated

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  //this  method uses the obj created from the intl package to formate the date in --> mm/day/yyyy
  String get formattedDate {
    return formatter.format(date);
  }
}

// this class is for the chart
class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });
// constructor which creates the expenses for the same  category 
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList(); // how to write atlernative consturctor to the default constructor
  
  final Category category;
  final List<Expense> expenses;


//retuns the total SUM
  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
