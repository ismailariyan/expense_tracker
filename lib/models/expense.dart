import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter  = DateFormat.yMd(); // here we are using the intl package to formate the date into a better way
const uuid = Uuid();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
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
 String get formattedDate{
  return formatter.format(date);
 }
}
