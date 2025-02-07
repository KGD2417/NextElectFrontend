import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("📊 Election Results (Future Scope Details are Stored in the blockchain)", style: TextStyle(fontSize: 24)),
    );
  }
}
