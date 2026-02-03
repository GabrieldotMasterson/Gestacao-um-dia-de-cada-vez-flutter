import 'package:flutter/material.dart';
import 'package:gestacao/commons/theme.dart';
import 'package:gestacao/models/reminder.dart';
import 'package:gestacao/services/reminder_service.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});
  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  List<Reminder> _reminders = [];
  bool _loading = true;
  final ReminderService _service = ReminderService();

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  Future<void> _loadReminders() async {
    await _service.resetDailyCompletions();
    final list = await _service.getAll();
    if (mounted) {
      setState(() {
        _reminders = list;
        _loading = false;
      });
    }
  }

  Future<void> _toggleCompletion(Reminder r) async {
    final updated = r.copyWith(
      isCompleted: !r.isCompleted,
      completedAt: !r.isCompleted ? DateTime.now() : null,
    );
    await _service.update(updated);
    await _loadReminders();
  }

  Future<void> _deleteReminder(Reminder r) async {
    await _service.delete(r.id);
    await _loadReminders();
  }

  @override
  Widget build(BuildContext context) {
    final completedCount = _reminders.where((r) => r.isCompleted).length;
    final totalCount = _reminders.length;
    final progressPercent = totalCount > 0 ? completedCount / totalCount : 0.0;

    return Scaffold(
      backgroundColor: kSurface,
      body: Stack(
        children: [
          Positioned(top: -40, left: -30, child: _blob(160, kAccent.withValues(alpha: 0.2))),
          Positioned(bottom: -50, right: -35, child: _blob(180, kPrimaryLight.withValues(alpha: 0.35))),

          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Lembretes',
                              style: Theme.of(context).textTheme.displaySmall?.copyWith(color: kTextDark)),
                          Text('Cuide de você hoje',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      // Add button
                      GestureDetector(
                        onTap: () => _openAddDialog(),
                        child: Container(
                          width: 42, height: 42,
                          decoration: BoxDecoration(
                            color: kPrimary,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: kPrimary.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))],
                          ),
                          child: const Icon(Icons.add, color: Colors.white, size: 22),
                        ),
                      ),
                    ],
                  ),
                ),

                // Progress bar
                if (totalCount > 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _buildProgressBar(progressPercent, completedCount, totalCount),
                  ),

                const SizedBox(height: 16),

                // List
                Expanded(
                  child: _loading
                      ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(kPrimary)))
                      : _reminders.isEmpty
                          ? _buildEmptyState()
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              itemCount: _reminders.length,
                              itemBuilder: (ctx, i) => _buildReminderCard(_reminders[i]),
                            ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _blob(double size, Color color) => Container(
    width: size, height: size,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );

  Widget _buildProgressBar(double progress, int done, int total) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: kPrimary.withValues(alpha: 0.08), blurRadius: 10, offset: const Offset(0, 3))],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Progresso de Hoje', style: TextStyle(fontSize: 14, color: kTextDark, fontWeight: FontWeight.w600)),
              Text('$done/$total', style: TextStyle(fontSize: 13, color: kPrimary, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: kPrimaryLight,
              valueColor: AlwaysStoppedAnimation<Color>(progress >= 1.0 ? const Color(0xFF81C784) : kPrimary),
            ),
          ),
          if (progress >= 1.0) ...[
            const SizedBox(height: 8),
            Text('🎉 Parabéns! Você completou todos os lembretes hoje!',
                style: TextStyle(fontSize: 12, color: const Color(0xFF4CAF50), fontWeight: FontWeight.w600)),
          ],
        ],
      ),
    );
  }

  Widget _buildReminderCard(Reminder r) {
    return Dismissible(
      key: ValueKey(r.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => _deleteReminder(r),
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFE06060),
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Align(
          alignment: Alignment.centerRight,
          child: Icon(Icons.delete_outline, color: Colors.white),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: r.isCompleted ? r.category.color.withValues(alpha: 0.08) : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: r.isCompleted ? r.category.color.withValues(alpha: 0.3) : Colors.transparent,
              width: 1.5,
            ),
            boxShadow: r.isCompleted ? [] : [BoxShadow(color: kPrimary.withValues(alpha: 0.07), blurRadius: 8, offset: const Offset(0, 3))],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Category emoji badge
                Container(
                  width: 46, height: 46,
                  decoration: BoxDecoration(
                    color: r.category.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(child: Text(r.category.emoji, style: const TextStyle(fontSize: 22))),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(r.title, style: TextStyle(
                        fontSize: 15, color: r.isCompleted ? kTextLight : kTextDark, fontWeight: FontWeight.w600,
                        decoration: r.isCompleted ? TextDecoration.lineThrough : null,
                      )),
                      Text('${r.time.format(context)} · ${r.category.label}',
                          style: TextStyle(fontSize: 12, color: kTextLight)),
                    ],
                  ),
                ),
                // Checkbox
                GestureDetector(
                  onTap: () => _toggleCompletion(r),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    width: 26, height: 26,
                    decoration: BoxDecoration(
                      color: r.isCompleted ? r.category.color : Colors.transparent,
                      border: Border.all(color: r.isCompleted ? r.category.color : kTextLight, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: r.isCompleted
                        ? const Icon(Icons.check, color: Colors.white, size: 16)
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96, height: 96,
              decoration: BoxDecoration(
                color: kPrimaryLight.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: const Center(child: Text('📝', style: TextStyle(fontSize: 42))),
            ),
            const SizedBox(height: 20),
            Text('Sem lembretes ainda', style: TextStyle(fontSize: 18, color: kTextDark, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text('Adicione lembretes para cuidar melhor de você durante a gestação',
                style: TextStyle(fontSize: 14, color: kTextMid), textAlign: TextAlign.center),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _openAddDialog(),
              child: const Text('+ Adicionar Lembrete'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openAddDialog() async {
    final result = await showModalBottomSheet<Reminder>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const _AddReminderSheet(),
    );
    if (result != null) {
      await _service.add(result);
      await _loadReminders();
    }
  }
}

// ─── Add Reminder Bottom Sheet ────────────────────────────────
class _AddReminderSheet extends StatefulWidget {
  const _AddReminderSheet();
  @override
  State<_AddReminderSheet> createState() => _AddReminderSheetState();
}

class _AddReminderSheetState extends State<_AddReminderSheet> {
  final TextEditingController _titleController = TextEditingController();
  ReminderCategory _selectedCategory = ReminderCategory.water;
  TimeOfDay _selectedTime = const TimeOfDay(hour: 8, minute: 0);

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)),
      ),
      padding: EdgeInsets.fromLTRB(24, 16, 24, MediaQuery.of(context).viewInsets.bottom + 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Center(
            child: Container(width: 40, height: 4, decoration: BoxDecoration(color: kPrimaryLight, borderRadius: BorderRadius.circular(2))),
          ),
          const SizedBox(height: 20),
          Text('Novo Lembrete', style: TextStyle(fontSize: 18, color: kTextDark, fontWeight: FontWeight.w700)),
          const SizedBox(height: 18),

          // Title input
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              hintText: 'Ex: Beber água',
              prefixIcon: const Icon(Icons.edit, color: kPrimary),
            ),
          ),
          const SizedBox(height: 16),

          // Category selector
          Text('Categoria', style: TextStyle(fontSize: 13, color: kTextMid, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(
            children: ReminderCategory.values.map((cat) {
              final selected = cat == _selectedCategory;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() { _selectedCategory = cat; }),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 6),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: selected ? cat.color.withValues(alpha: 0.15) : const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: selected ? cat.color : Colors.transparent, width: 1.5),
                    ),
                    child: Column(
                      children: [
                        Text(cat.emoji, style: const TextStyle(fontSize: 18)),
                        Text(cat.label.substring(0, cat.label.length > 4 ? 4 : cat.label.length),
                            style: TextStyle(fontSize: 9, color: selected ? cat.color : kTextLight, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // Time selector
          Text('Horário', style: TextStyle(fontSize: 13, color: kTextMid, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () async {
              final picked = await showTimePicker(context: context, initialTime: _selectedTime);
              if (picked != null) setState(() { _selectedTime = picked; });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Icon(Icons.access_time, color: kPrimary),
                  const SizedBox(width: 10),
                  Text(_selectedTime.format(context), style: TextStyle(fontSize: 15, color: kTextDark, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Save button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                final title = _titleController.text.trim();
                if (title.isEmpty) return;
                final reminder = Reminder(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: title,
                  category: _selectedCategory,
                  time: _selectedTime,
                  createdAt: DateTime.now(),
                );
                Navigator.of(context).pop(reminder);
              },
              child: const Text('Salvar Lembrete'),
            ),
          ),
        ],
      ),
    );
  }
}
