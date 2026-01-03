import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/signal_card.dart';
import 'whales_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Map<String, dynamic>? ai;

  @override
  void initState() {
    super.initState();
    ApiService.getAIPrediction().then((data) {
      setState(() => ai = data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("لوحة التحليل"),
        actions: [
          IconButton(
            icon: const Icon(Icons.water_drop),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WhalesScreen()),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ai == null
            ? const Center(child: CircularProgressIndicator())
            : SignalCard(ai: ai!),
      ),
    );
  }
}
