import 'package:courtly/presentation/widgets/backable_centered_app_bar.dart';
import 'package:flutter/material.dart';

/// [WriteReviewPage] is a widget that is used to display the write review
/// page of the application.
class WriteReviewPage extends StatelessWidget {
  const WriteReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BackableCenteredAppBar(title: 'Write a Review'),
      body: Center(
        child: Text('Write a Review'),
      ),
    );
  }
}
