import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../../widgets/custom_app_bar.dart';
import '../../widgets/paymentoption.dart';

class PaymentScreen extends StatefulWidget {
  final String selectedPlan;
  final double price;

  const PaymentScreen({
    super.key,
    required this.selectedPlan,
    required this.price,
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<dynamic> paymentOptions = [];

  @override
  void initState() {
    super.initState();
    loadPaymentOptions();
  }

  Future<void> loadPaymentOptions() async {
    String jsonString =
        await rootBundle.loadString('assets/data/payment_options.json');
    setState(() {
      paymentOptions = json.decode(jsonString);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(title: "Choose Payment"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            paymentOptions.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.red))
              : Column(
                  children: paymentOptions.map((option) {
                    return Paymentoption(
                        title: option["name"],
                        subtitle: option["subtitle"],
                        price: "\$${widget.price.toStringAsFixed(2)}",
                        assetPath: option["image"]);
                  }).toList(),
                ),
          ],
        ),
      ),
    );
  }
}
