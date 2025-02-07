import 'package:flutter/material.dart';
import 'package:next_elect/models/election.dart';
import 'package:next_elect/services/api_service.dart';

class ElectionProvider with ChangeNotifier {
  List<Election> _elections = [];
  List<Election> get elections => _elections;

  // Fetch all elections
  Future<void> fetchElections() async {
    try {
      final response = await ApiService.get('api/elections/fetch');

      if (response.containsKey('data') && response['data'] != null) {
        _elections = (response['data'] as List).map((e) {
          return Election.fromJson({
            "_id": e['id'].toString(),  // Ensure it’s a string
            "name": e['name'] ?? "Unknown Election",
            "candidates": List<String>.from(e['candidates']),
            // Convert the 'endTime' from timestamp to string (ISO 8601 format)
            "endTime": DateTime.fromMillisecondsSinceEpoch(e['endTime']).toIso8601String(),
            "isEnded": e['isEnded'] ?? false,
          });
        }).toList();
      } else {
        throw Exception("Invalid response format");
      }

      notifyListeners();
    } catch (e) {
      print('Error fetching elections: $e');
      throw Exception('Failed to fetch elections: $e');
    }
  }



  // Create a new election
  Future<void> createElection(String name, List<String> candidates, int duration) async {
    try {
      await ApiService.post('api/elections/create', {
        'name': name,
        'candidates': candidates,
        'durationInMinutes': duration,
      });
      await fetchElections();
    } catch (e) {
      throw Exception('Failed to create election: $e');
    }
  }

  // Cast a vote in an election
  Future<void> castVote(String electionId, String candidate) async {
    try {
      print("It is working");
      await ApiService.post('api/elections/vote', {
        'electionId': electionId,
        'candidate': candidate,
      });

    } catch (e) {
      throw Exception('Failed to cast vote: $e');
    }
  }

  // End an election
  Future<void> endElection(String electionId) async {
    try {
      await ApiService.post('elections/end', {
        'electionId': electionId,
      });
      await fetchElections();
    } catch (e) {
      throw Exception('Failed to end election: $e');
    }
  }

  // Get election results
  Future<Map<String, dynamic>> getResults(String electionId) async {
    try {
      final response = await ApiService.get('elections/results/$electionId');
      return response;
    } catch (e) {
      throw Exception('Failed to fetch results: $e');
    }
  }
}