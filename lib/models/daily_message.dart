class DailyMessage {
  final String id;
  final String message;
  final String category;    // e.g. "motivational", "health", "baby"
  final String emoji;
  final DateTime date;

  DailyMessage({
    required this.id,
    required this.message,
    required this.category,
    required this.emoji,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'category': category,
      'emoji': emoji,
      'date': date.toIso8601String(),
    };
  }

  factory DailyMessage.fromMap(Map<String, dynamic> map) {
    return DailyMessage(
      id: map['id'],
      message: map['message'],
      category: map['category'],
      emoji: map['emoji'],
      date: DateTime.parse(map['date']),
    );
  }
}
