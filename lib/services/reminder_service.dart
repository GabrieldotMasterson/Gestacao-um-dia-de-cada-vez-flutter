import 'dart:convert';
import 'package:gestacao/models/reminder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReminderService {
  static const String _key = 'reminders_list';

  Future<List<Reminder>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    try {
      final list = json.decode(raw) as List<dynamic>;
      return list.map((e) => Reminder.fromMap(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> save(List<Reminder> reminders) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = json.encode(reminders.map((r) => r.toMap()).toList());
    await prefs.setString(_key, encoded);
  }

  Future<void> add(Reminder reminder) async {
    final list = await getAll();
    list.add(reminder);
    await save(list);
  }

  Future<void> update(Reminder reminder) async {
    final list = await getAll();
    final idx = list.indexWhere((r) => r.id == reminder.id);
    if (idx >= 0) {
      list[idx] = reminder;
      await save(list);
    }
  }

  Future<void> delete(String id) async {
    final list = await getAll();
    list.removeWhere((r) => r.id == id);
    await save(list);
  }

  /// Reset completion status for all reminders every new day
  Future<void> resetDailyCompletions() async {
    final list = await getAll();
    final today = DateTime.now();
    bool changed = false;
    for (int i = 0; i < list.length; i++) {
      final r = list[i];
      if (r.isCompleted && r.completedAt != null) {
        final completed = r.completedAt!;
        if (completed.year != today.year || completed.month != today.month || completed.day != today.day) {
          list[i] = r.copyWith(isCompleted: false, completedAt: null);
          changed = true;
        }
      }
    }
    if (changed) await save(list);
  }
}
