import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:next_elect/providers/election_provider.dart';
import 'package:next_elect/widgets/candidate_button.dart';

import '../models/election.dart';

class ElectionDetailScreen extends StatelessWidget {
  final Election election;

  const ElectionDetailScreen({super.key, required this.election});

  @override
  Widget build(BuildContext context) {
    final electionProvider = Provider.of<ElectionProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(election.name)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Candidates:', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 10),
            ...election.candidates.map((candidate) => CandidateButton(
              candidate: candidate,
                onPressed: () async {
                  try {
                    print("it is working");
                    await electionProvider.castVote(election.id, candidate);
                    if (context.mounted) {  // Ensure the widget is still active
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Vote casted successfully!')),
                      );
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    if (context.mounted) {  // Ensure the widget is still active
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                  }
                },
            )),
          ],
        ),
      ),
    );
  }
}