import 'package:flutter/material.dart';
import 'package:next_elect/providers/election_provider.dart';
import 'package:next_elect/screens/election_detail_screen.dart';
import 'package:next_elect/widgets/election_card.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchElections();
  }

  Future<void> _fetchElections() async {
    final electionProvider = Provider.of<ElectionProvider>(context, listen: false);
    await electionProvider.fetchElections();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final electionProvider = Provider.of<ElectionProvider>(context);

    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : electionProvider.elections.isEmpty
        ? const Center(child: Text("No elections found"))
        : SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (electionProvider.elections.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("No elections found"),
              ),
            )
          else
            Column(
              children: electionProvider.elections.map((election) {
                return ElectionCard(
                  election: election,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ElectionDetailScreen(election: election),
                    ),
                  ),
                );
              }).toList(),
            ),
          Container(
            margin: EdgeInsets.fromLTRB(30,10,30,10),
            child: const Text(
              "Guidelines to Vote",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Static text below the elections list
          const SizedBox(height: 16),
          const VotingStep(
            step: 1,
            title: "Login or Register",
            description:
            "To get started, log in or create an account by providing your details. Ensure your identity is verified with your Voter ID and Aadhaar ID for secure access.",
          ),
          const VotingStep(
            step: 2,
            title: "Access Voting Page",
            description:
            "Once logged in, click the 'Vote Now' button on the home page to be redirected to the voting page where you can cast your vote.",
          ),
          const VotingStep(
            step: 3,
            title: "Select Your Candidate",
            description:
            "On the voting page, choose your preferred candidate and click on the 'Submit Vote' button to register your vote.",
          ),
          const VotingStep(
            step: 4,
            title: "Confirmation of Vote",
            description:
            "After submitting your vote, you will be redirected to a confirmation page to review your submission.",
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
