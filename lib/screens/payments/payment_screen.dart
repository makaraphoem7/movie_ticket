import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../../widgets/paymentoption.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

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
      appBar: AppBar(
        title: Text(
          "Choose Payment",
          style: TextStyle(
            color: Color(0xFFFAFAFA),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true, // Add this line to center the title
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Center(
            //   child: Text(
            //     "Choose Payment",
            //     style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 18,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),
            const SizedBox(height: 20),
            paymentOptions.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.red))
                : Column(
                    children: paymentOptions.map((option) {
                      return Paymentoption(
                          title: option["name"],
                          subtitle: option["subtitle"],
                          price: option["price"],
                          assetPath: option["image"]);
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }
}
