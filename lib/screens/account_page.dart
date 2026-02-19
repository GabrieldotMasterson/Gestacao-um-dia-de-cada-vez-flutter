import 'package:flutter/material.dart';
import 'package:gestacao/commons/theme.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final int _gestationalWeek = 22;
  final String _babyName = 'Bebezinho';
  final DateTime _expectedDate = DateTime(2026, 6, 15);
  bool _isPremium = false;

  @override
  Widget build(BuildContext context) {
    final daysLeft = _expectedDate.difference(DateTime.now()).inDays;
    final weeksLeft = (daysLeft / 7).round();

    return Scaffold(
      backgroundColor: kSurface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header minimalista
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'minha gestação',
                        style: TextStyle(
                          fontSize: 13,
                          color: kTextLight,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Olá, Mamãe',
                        style: TextStyle(
                          fontSize: 28,
                          color: kTextDark,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: kPrimary.withValues(alpha: 0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text('👩', style: TextStyle(fontSize: 28)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Card da semana atual - minimalista
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: kPrimary.withValues(alpha: 0.03),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Semana $_gestationalWeek',
                            style: TextStyle(
                              fontSize: 26,
                              color: kTextDark,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '2º trimestre • $daysLeft dias para o parto',
                            style: TextStyle(fontSize: 14, color: kTextMid),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: kPrimaryLight.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('🍼', style: TextStyle(fontSize: 24)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Seção do bebê - mais clean
              Text(
                'seu bebê',
                style: TextStyle(
                  fontSize: 12,
                  color: kTextLight,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: kPrimary.withValues(alpha: 0.03),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _milestoneItem('🍋', 'Tamanho', 'Do tamanho de uma manga'),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(height: 1, color: Color(0xFFF0F0F0)),
                    ),
                    _milestoneItem(
                      '👂',
                      'Audição',
                      'Já consegue ouvir sua voz',
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(height: 1, color: Color(0xFFF0F0F0)),
                    ),
                    _milestoneItem(
                      '🤸',
                      'Movimento',
                      'Está se movimentando bastante',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Stats em linha - mais arejado
              Row(
                children: [
                  _statChip('📅', '$daysLeft dias'),
                  const SizedBox(width: 8),
                  _statChip('🕐', '$weeksLeft semanas'),
                  const SizedBox(width: 8),
                  _statChip('📍', 'semana $_gestationalWeek'),
                ],
              ),

              const SizedBox(height: 28),

              // Premium CTA - mais suave
              if (!_isPremium) ...[
                Text(
                  'recursos exclusivos',
                  style: TextStyle(
                    fontSize: 12,
                    color: kTextLight,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFF9F0FF),
                        const Color(0xFFF3E8FF),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: kPrimary.withValues(alpha: 0.1),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('✨', style: TextStyle(fontSize: 24)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Desbloqueie recursos especiais',
                              style: TextStyle(
                                fontSize: 16,
                                color: kTextDark,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '• Mensagens diárias personalizadas\n'
                        '• Acompanhamento detalhado\n'
                        '• Widgets exclusivos\n'
                        '• Lembretes especiais',
                        style: TextStyle(
                          fontSize: 14,
                          color: kTextMid,
                          height: 1.8,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            setState(() => _isPremium = true);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: kPrimary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'Ativar por R\$ 9,90/mês',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 28),

              // Configurações - mais clean
              Text(
                'configurações',
                style: TextStyle(
                  fontSize: 12,
                  color: kTextLight,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: kPrimary.withValues(alpha: 0.03),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _settingsItem(Icons.person_outline, 'Perfil'),
                    _settingsItem(Icons.notifications_outlined, 'Notificações'),
                    _settingsItem(Icons.language, 'Idioma'),
                    _settingsItem(Icons.help_outline, 'Ajuda'),
                    _settingsItem(Icons.logout, 'Sair', isLast: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _milestoneItem(String emoji, String title, String desc) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: kSurface,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Text(emoji, style: const TextStyle(fontSize: 20)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  color: kTextDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(desc, style: TextStyle(fontSize: 13, color: kTextMid)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statChip(String emoji, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: kPrimary.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: kTextDark,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingsItem(IconData icon, String label, {bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              Icon(icon, size: 20, color: kTextMid),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    color: kTextDark,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, size: 18, color: kTextLight),
            ],
          ),
        ),
        if (!isLast)
          const Padding(
            padding: EdgeInsets.only(left: 56),
            child: Divider(height: 1, color: Color(0xFFF0F0F0)),
          ),
      ],
    );
  }
}
