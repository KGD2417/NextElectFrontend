class Election {
  final String id;
  final String name;
  final List<String> candidates;
  final DateTime endTime;
  final bool isEnded;

  Election({
    required this.id,
    required this.name,
    required this.candidates,
    required this.endTime,
    required this.isEnded,
  });

  factory Election.fromJson(Map<String, dynamic> json) {
    return Election(
      id: json['_id'] ?? "0",
      name: json['name'] ?? "Unknown Election",
      candidates: json['candidates'] != null
          ? List<String>.from(json['candidates'])
          : [],
      endTime: json['endTime'] != null
          ? DateTime.parse(json['endTime'])
          : DateTime.now(),
      isEnded: json['isEnded'] ?? false,
    );
  }
}