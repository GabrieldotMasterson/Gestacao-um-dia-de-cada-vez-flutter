import 'package:flutter/material.dart';
import 'package:gestacao/commons/theme.dart';

class PremiumPage extends StatefulWidget {
  const PremiumPage({super.key});
  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shimmer;
  int _selectedWidgetIndex = 0;
  int _selectedStyleIndex = 0;
  int _selectedMessageTheme = 0;

  final List<Map<String, dynamic>> _widgetPreviews = [
    {'emoji': '🌸', 'label': 'Floral', 'bg': const Color(0xFFF9E4E8), 'accent': kPrimary},
    {'emoji': '🌙', 'label': 'Noturno', 'bg': const Color(0xFFE8EAF6), 'accent': const Color(0xFF7986CB)},
    {'emoji': '🍃', 'label': 'Natural', 'bg': const Color(0xFFE8F5E9), 'accent': const Color(0xFF66BB6A)},
    {'emoji': '☀️', 'label': 'Ensolarado', 'bg': const Color(0xFFFFF8E1), 'accent': const Color(0xFFFFA726)},
  ];

  final List<Map<String, dynamic>> _reminderStyles = [
    {'name': 'Clássico', 'icon': Icons.list_alt, 'color': kPrimary},
    {'name': 'Cápsulas', 'icon': Icons.lens_blur, 'color': const Color(0xFF7986CB)},
    {'name': 'Cartões', 'icon': Icons.view_agenda, 'color': const Color(0xFF66BB6A)},
    {'name': 'Minimalista', 'icon': Icons.crop_square, 'color': const Color(0xFFFFA726)},
  ];

  final List<Map<String, String>> _exclusiveMessages = [
    {'emoji': '🌺', 'category': 'Floral', 'msg': 'Como uma flor que floresce devagar, você está crescendo e florescendo a cada dia.'},
    {'emoji': '🌊', 'category': 'Oceano', 'msg': 'Você é como o oceano — forte, bonita e cheia de profundidade. Confie nas ondas da vida.'},
    {'emoji': '🦋', 'category': 'Transformação', 'msg': 'Você está passando por uma metamorfose linda. A borboleta dentro de você está nascendo.'},
    {'emoji': '🌙', 'category': 'Noite', 'msg': 'Nas noites mais silenciosas, a vida dentro de você continua sonhando e crescendo.'},
    {'emoji': '🍃', 'category': 'Natureza', 'msg': 'Como a natureza encontra seu caminho, você também encontrará o seu — com graça e força.'},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
    _shimmer = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSurface,
      body: Stack(
        children: [
          Positioned(top: -40, left: -30, child: _blob(150, const Color(0xFFE8D5F5).withValues(alpha: 0.5))),
          Positioned(bottom: -50, right: -30, child: _blob(170, const Color(0xFFD5E8F5).withValues(alpha: 0.4))),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  // Header
                  _buildPremiumHeader(),
                  const SizedBox(height: 28),

                  // Widget Styles
                  Text('Estilos de Widget', style: TextStyle(fontSize: 16, color: kTextDark, fontWeight: FontWeight.w700)),
                  Text('Personalize como a mensagem aparece na tela', style: TextStyle(fontSize: 13, color: kTextMid)),
                  const SizedBox(height: 14),
                  _buildWidgetPreviews(),
                  const SizedBox(height: 8),
                  _buildWidgetPreview(),
                  const SizedBox(height: 24),

                  // Mensagens Exclusivas
                  Text('Mensagens Exclusivas', style: TextStyle(fontSize: 16, color: kTextDark, fontWeight: FontWeight.w700)),
                  Text('Variedade de mensagens temáticas especiais', style: TextStyle(fontSize: 13, color: kTextMid)),
                  const SizedBox(height: 14),
                  _buildMessageThemes(),
                  const SizedBox(height: 8),
                  _buildExclusiveMessages(),
                  const SizedBox(height: 24),

                  // Estilos de Lembretes
                  Text('Estilos de Lembrete', style: TextStyle(fontSize: 16, color: kTextDark, fontWeight: FontWeight.w700)),
                  Text('Escolha como os lembretes são exibidos', style: TextStyle(fontSize: 13, color: kTextMid)),
                  const SizedBox(height: 14),
                  _buildReminderStyles(),
                  const SizedBox(height: 8),
                  _buildReminderPreview(),
                  const SizedBox(height: 40),
                ],
              ),
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

  Widget _buildPremiumHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF6B4C9A), const Color(0xFF9B59B6)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(color: const Color(0xFF6B4C9A).withValues(alpha: 0.3), blurRadius: 16, offset: const Offset(0, 6))],
      ),
      padding: const EdgeInsets.all(22),
      child: Row(
        children: [
          AnimatedBuilder(
            animation: _shimmer,
            builder: (ctx, child) => Container(
              width: 64, height: 64,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15 + _shimmer.value * 0.1),
                shape: BoxShape.circle,
              ),
              child: const Center(child: Text('👑', style: TextStyle(fontSize: 32))),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Área Premium', style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700)),
              Text('Seus recursos exclusivos', style: const TextStyle(fontSize: 13, color: Colors.white60)),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Widget style selectors ──────────────────────────────────
  Widget _buildWidgetPreviews() {
    return Row(
      children: _widgetPreviews.asMap().entries.map((entry) {
        final i = entry.key;
        final w = entry.value;
        final selected = i == _selectedWidgetIndex;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() { _selectedWidgetIndex = i; }),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: selected ? w['accent'].withValues(alpha: 0.1) : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: selected ? w['accent'] : Colors.transparent, width: 2),
              ),
              child: Column(
                children: [
                  Text(w['emoji'], style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 4),
                  Text(w['label'], style: TextStyle(fontSize: 11, color: selected ? w['accent'] : kTextLight, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildWidgetPreview() {
    final w = _widgetPreviews[_selectedWidgetIndex];
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: ScaleTransition(scale: animation, child: child)),
      child: Container(
        key: ValueKey(_selectedWidgetIndex),
        decoration: BoxDecoration(
          color: w['bg'],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: w['accent'].withValues(alpha: 0.15), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(w['emoji'], style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 8),
            Text('Mensagem do Dia', style: TextStyle(fontSize: 13, color: w['accent'], fontWeight: FontWeight.w600), textAlign: TextAlign.center),
            const SizedBox(height: 6),
            Text(
              'Como uma flor que floresce devagar, você está crescendo e florescendo.',
              style: TextStyle(fontSize: 13, color: kTextDark, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: w['accent'].withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text('Abrir App', style: TextStyle(fontSize: 11, color: w['accent'], fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Message themes ─────────────────────────────────────────
  Widget _buildMessageThemes() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _exclusiveMessages.asMap().entries.map((entry) {
          final i = entry.key;
          final m = entry.value;
          final selected = i == _selectedMessageTheme;
          return GestureDetector(
            onTap: () => setState(() { _selectedMessageTheme = i; }),
            child: Padding(
              padding: EdgeInsets.only(right: 8, left: i == 0 ? 0 : 0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: selected ? kPrimary.withValues(alpha: 0.1) : const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: selected ? kPrimary : Colors.transparent, width: 1.5),
                ),
                child: Row(
                  children: [
                    Text(m['emoji']!, style: const TextStyle(fontSize: 16)),
                    const SizedBox(width: 6),
                    Text(m['category']!, style: TextStyle(fontSize: 12, color: selected ? kPrimary : kTextMid, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildExclusiveMessages() {
    final msg = _exclusiveMessages[_selectedMessageTheme];
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
      child: Container(
        key: ValueKey(_selectedMessageTheme),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: kPrimary.withValues(alpha: 0.08), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(msg['emoji']!, style: const TextStyle(fontSize: 36)),
            const SizedBox(height: 8),
            Text(msg['category']!, style: TextStyle(fontSize: 14, color: kPrimary, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text(msg['msg']!, style: TextStyle(fontSize: 14, color: kTextDark, height: 1.6), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  // ─── Reminder styles ────────────────────────────────────────
  Widget _buildReminderStyles() {
    return Row(
      children: _reminderStyles.asMap().entries.map((entry) {
        final i = entry.key;
        final s = entry.value;
        final selected = i == _selectedStyleIndex;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() { _selectedStyleIndex = i; }),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: selected ? s['color'].withValues(alpha: 0.1) : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: selected ? s['color'] : Colors.transparent, width: 2),
              ),
              child: Column(
                children: [
                  Icon(s['icon'], color: selected ? s['color'] : kTextLight, size: 22),
                  const SizedBox(height: 4),
                  Text(s['name'], style: TextStyle(fontSize: 10, color: selected ? s['color'] : kTextLight, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildReminderPreview() {
    final style = _reminderStyles[_selectedStyleIndex];
    final items = [
      {'emoji': '💧', 'title': 'Beber água', 'time': '08:00', 'done': true},
      {'emoji': '💊', 'title': 'Tomar vitamina', 'time': '09:00', 'done': false},
      {'emoji': '🚶‍♀️', 'title': 'Caminhada leve', 'time': '17:00', 'done': false},
    ];

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
      child: Container(
        key: ValueKey(_selectedStyleIndex),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: style['color'].withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: items.map((item) {
            final done = item['done'] as bool;
            // Classic style
            if (_selectedStyleIndex == 0) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Text(item['emoji'] as String, style: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 10),
                    Expanded(child: Text(item['title'] as String, style: TextStyle(fontSize: 13, color: done ? kTextLight : kTextDark, decoration: done ? TextDecoration.lineThrough : null))),
                    Text(item['time'] as String, style: TextStyle(fontSize: 11, color: kTextLight)),
                    const SizedBox(width: 8),
                    Container(
                      width: 20, height: 20,
                      decoration: BoxDecoration(
                        color: done ? style['color'] : Colors.transparent,
                        border: Border.all(color: done ? style['color'] : kTextLight, width: 1.5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: done ? Icon(Icons.check, color: Colors.white, size: 13) : null,
                    ),
                  ],
                ),
              );
            }
            // Capsule style
            if (_selectedStyleIndex == 1) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: done ? style['color'].withValues(alpha: 0.1) : const Color(0xFFF8F8F8),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Row(
                    children: [
                      Text(item['emoji'] as String, style: const TextStyle(fontSize: 16)),
                      const SizedBox(width: 8),
                      Expanded(child: Text(item['title'] as String, style: TextStyle(fontSize: 12, color: done ? style['color'] : kTextDark))),
                      Text('✓', style: TextStyle(fontSize: 14, color: done ? style['color'] : kTextLight)),
                    ],
                  ),
                ),
              );
            }
            // Card style
            if (_selectedStyleIndex == 2) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: done ? style['color'].withValues(alpha: 0.08) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: done ? style['color'].withValues(alpha: 0.3) : const Color(0xFFEEEEEE)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(color: style['color'].withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
                        child: Center(child: Text(item['emoji'] as String, style: const TextStyle(fontSize: 16))),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['title'] as String, style: TextStyle(fontSize: 12, color: kTextDark, fontWeight: FontWeight.w600)),
                            Text(item['time'] as String, style: TextStyle(fontSize: 10, color: kTextLight)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            // Minimalist style
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Text(item['emoji'] as String, style: const TextStyle(fontSize: 16)),
                  const SizedBox(width: 10),
                  Expanded(child: Text(item['title'] as String, style: TextStyle(fontSize: 13, color: done ? kTextLight : kTextDark, decoration: done ? TextDecoration.lineThrough : null))),
                  Container(
                    width: 18, height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: done ? style['color'] : Colors.transparent,
                      border: Border.all(color: done ? style['color'] : kTextLight, width: 1.5),
                    ),
                    child: done ? Icon(Icons.check, color: Colors.white, size: 10) : null,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
