import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/subscription.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  List<dynamic> subscriptionPlans = [];

  @override
  void initState() {
    super.initState();
    loadSubscriptionPlans();
  }

  Future<void> loadSubscriptionPlans() async {
    String jsonString =
        await rootBundle.loadString('assets/data/subscriptions.json');
    setState(() {
      subscriptionPlans = json.decode(jsonString);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Choose your favorite package here",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: subscriptionPlans.length,
                itemBuilder: (context, index) {
                  var plan = subscriptionPlans[index];
                  return Subscription(
                    // context: context,
                    title: plan['title'],
                    duration: plan['duration'],
                    price: plan['price'],

                    // price: "\$${plan['price']}${plan['duration']}");
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
