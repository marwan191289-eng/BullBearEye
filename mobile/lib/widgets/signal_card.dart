import 'package:flutter/material.dart';

class SignalCard extends StatelessWidget {
  final Map<String, dynamic> ai;
  const SignalCard({super.key, required this.ai});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("🧠 حالة السوق",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(
              ai["prediction"],
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal),
            ),
            const SizedBox(height: 8),
            Text("الثقة: "+((ai["confidence"] * 100).round().toString())+"%"),
          ],
        ),
      ),
    );
  }
}
