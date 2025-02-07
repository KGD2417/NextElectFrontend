import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:next_elect/models/election.dart';

import '../screens/auth/login_screen.dart';
import '../screens/election_detail_screen.dart';

class ElectionCard extends StatelessWidget {
  final Election election;
  final VoidCallback onTap;

  const ElectionCard({super.key, required this.election, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            election.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Participate in the 2025 Lok Sabha Election and make your voice count. Vote for your preferred candidates securely and ensure your choice is part of the democratic process.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 20, color: Colors.grey),
              SizedBox(width: 8),
              Text(
                'Ends: ${DateFormat.yMMMd().add_jm().format(election.endTime)}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(Icons.access_time, size: 20, color: Colors.grey),
              SizedBox(width: 8),
              Text(
                "9:00 AM to 6:00 PM",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GradientButton(
            text: "VOTE NOW",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ElectionDetailScreen(election: election),
                ),
              );
            },
          ),
        ],
      ),
    );

  }
}