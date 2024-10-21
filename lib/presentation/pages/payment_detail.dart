import 'package:courtly/presentation/widgets/backable_centered_app_bar.dart';
import 'package:flutter/material.dart';

/// [PaymentDetail] is a page to show payment details.
class PaymentDetail extends StatelessWidget {
  const PaymentDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BackableCenteredAppBar(title: "Payment Detail"),
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          
        ),
      )),
    );
  }
}
