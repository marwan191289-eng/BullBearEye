import 'package:flutter/material.dart';
import '../services/api_service.dart';

class WhalesScreen extends StatefulWidget {
  const WhalesScreen({super.key});

  @override
  State<WhalesScreen> createState() => _WhalesScreenState();
}

class _WhalesScreenState extends State<WhalesScreen> {
  List whales = [];

  @override
  void initState() {
    super.initState();
    ApiService.getWhales().then((data) {
      setState(() => whales = data["whale_trades"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🐋 تحركات الحيتان")),
      body: ListView.builder(
        itemCount: whales.length,
        itemBuilder: (_, i) {
          final w = whales[i];
          return ListTile(
            title: Text("${w["side"]} - \\$${w["value"]}"),
            subtitle: Text("السعر: ${w["price"]}"),
            trailing: Icon(
              w["side"] == "BUY"
                  ? Icons.arrow_upward
                  : Icons.arrow_downward,
              color: w["side"] == "BUY" ? Colors.green : Colors.red,
            ),
          );
        },
      ),
    );
  }
}
