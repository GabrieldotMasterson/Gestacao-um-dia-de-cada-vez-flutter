import 'package:flutter/material.dart';

enum ReminderCategory {
  water,
  exercise,
  vitamins,
  rest,
  custom;

  String get emoji {
    switch (this) {
      case water: return '💧';
      case exercise: return '🚶‍♀️';
      case vitamins: return '💊';
      case rest: return '😴';
      case custom: return '✨';
    }
  }

  String get label {
    switch (this) {
      case water: return 'Água';
      case exercise: return 'Exercício';
      case vitamins: return 'Vitaminas';
      case rest: return 'Descanso';
      case custom: return 'Personalizado';
    }
  }

  Color get color {
    switch (this) {
      case water: return const Color(0xFF64B5F6);
      case exercise: return const Color(0xFF81C784);
      case vitamins: return const Color(0xFFE8849C);
      case rest: return const Color(0xFFBA68C8);
      case custom: return const Color(0xFFFFB74D);
    }
  }
}

class Reminder {
  final String id;
  final String title;
  final ReminderCategory category;
  final TimeOfDay time;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? completedAt;

  Reminder({
    required this.id,
    required this.title,
    required this.category,
    required this.time,
    this.isCompleted = false,
    required this.createdAt,
    this.completedAt,
  });

  Reminder copyWith({
    String? id,
    String? title,
    ReminderCategory? category,
    TimeOfDay? time,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return Reminder(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      time: time ?? this.time,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category.index,
      'timeHour': time.hour,
      'timeMinute': time.minute,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      id: map['id'],
      title: map['title'],
      category: ReminderCategory.values[map['category']],
      time: TimeOfDay(hour: map['timeHour'], minute: map['timeMinute']),
      isCompleted: map['isCompleted'],
      createdAt: DateTime.parse(map['createdAt']),
      completedAt: map['completedAt'] != null ? DateTime.parse(map['completedAt']) : null,
    );
  }
}
