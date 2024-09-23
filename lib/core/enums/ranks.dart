import 'package:flutter/material.dart';

/// [Ranks] is an enum class to represent the ranks of the user.
/// The ranks are used to determine the user's renting frequency level.
///
/// Rank contains [label] that is the name of the rank,
/// [minimumLevel] shows the minimum level of the rank, and
/// [color] that is the color of the rank.
enum Ranks {
  rookie("Rookie", 0, Colors.brown),
  veteran("Veteran", 5, Colors.grey),
  expert("Expert", 20, Colors.blue),
  master("Master", 30, Colors.green),
  legend("Legend", 50, Colors.red);

  /// [label] is the name of the rank.
  final String label;

  /// [minimumLevel] is the minimum level of the rank.
  final int minimumLevel;

  /// [color] is the color of the rank.
  final Color color;

  const Ranks(this.label, this.minimumLevel, this.color);
}
