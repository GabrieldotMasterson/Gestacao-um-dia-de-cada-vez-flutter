import 'package:flutter/material.dart';
import 'package:gestacao/commons/theme.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  // Simulated pregnancy data — in production these come from the API / user profile
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
      body: Stack(
        children: [
          Positioned(
            top: -50,
            right: -45,
            child: _blob(190, kAccent.withValues(alpha: 0.2)),
          ),
          Positioned(
            bottom: -60,
            left: -40,
            child: _blob(200, kPrimaryLight.withValues(alpha: 0.3)),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  // Header
                  Text(
                    'Sua Conta',
                    style: Theme.of(
                      context,
                    ).textTheme.displaySmall?.copyWith(color: kTextDark),
                  ),
                  Text(
                    'Acompanhe sua gestação',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),

                  // Profile + baby card
                  _buildProfileCard(),
                  const SizedBox(height: 20),

                  // Stats row
                  _buildStatsRow(daysLeft, weeksLeft),
                  const SizedBox(height: 20),

                  // Baby info card
                  _buildBabyCard(),
                  const SizedBox(height: 20),

                  // Premium CTA
                  if (!_isPremium) _buildPremiumCTA(),
                  const SizedBox(height: 20),

                  // Configurações section
                  _buildSettingsSection(),
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
    width: size,
    height: size,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );

  Widget _buildProfileCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: kPrimary.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [kPrimary, kPrimaryDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text('👩', style: TextStyle(fontSize: 34)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mamãe',
                  style: TextStyle(
                    fontSize: 18,
                    color: kTextDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Semana $_gestationalWeek da gestação',
                  style: TextStyle(fontSize: 13, color: kTextMid),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: kPrimaryLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '2º Trimestre',
                        style: TextStyle(
                          fontSize: 11,
                          color: kPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(int daysLeft, int weeksLeft) {
    return Row(
      children: [
        Expanded(child: _statCard('📅', 'Dias', '$daysLeft', 'até o parto')),
        const SizedBox(width: 12),
        Expanded(child: _statCard('🕐', 'Semanas', '$weeksLeft', 'restantes')),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard('📍', 'Semana', '$_gestationalWeek', 'atual'),
        ),
      ],
    );
  }

  Widget _statCard(String emoji, String label, String value, String sub) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: kPrimary.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              color: kTextDark,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: kTextMid,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(sub, style: TextStyle(fontSize: 10, color: kTextLight)),
        ],
      ),
    );
  }

  Widget _buildBabyCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kPrimaryLight, kAccent.withValues(alpha: 0.4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('👶', style: TextStyle(fontSize: 28)),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sobre $_babyName',
                    style: TextStyle(
                      fontSize: 16,
                      color: kTextDark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Semana $_gestationalWeek',
                    style: TextStyle(fontSize: 12, color: kTextMid),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Baby milestone info
          _babyMilestone('🍋', 'Tamanho', 'Do tamanho de uma manga'),
          const SizedBox(height: 8),
          _babyMilestone('👂', 'Audição', 'Já consegue ouvir sua voz'),
          const SizedBox(height: 8),
          _babyMilestone('🤸', 'Movimento', 'Pode estar virando o corpo'),
        ],
      ),
    );
  }

  Widget _babyMilestone(String emoji, String title, String desc) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                color: kTextDark,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(desc, style: TextStyle(fontSize: 11, color: kTextMid)),
          ],
        ),
      ],
    );
  }

  Widget _buildPremiumCTA() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF6B4C9A), const Color(0xFF9B59B6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B4C9A).withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('👑', style: TextStyle(fontSize: 26)),
              const SizedBox(width: 10),
              Text(
                'Premium',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: kPremiumGold,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'R\$ 9,90/mês',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Desbloqueie recursos extras exclusivos para sua gestação',
            style: const TextStyle(fontSize: 13, color: Colors.white70),
          ),
          const SizedBox(height: 12),
          _premiumFeature('Widgets personalizados e estilos exclusivos'),
          _premiumFeature('Mensagens especiais do dia com variedade'),
          _premiumFeature('Lembretes com sons e notificações avançadas'),
          _premiumFeature('Acompanhamento detalhado do bebê por semana'),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPremiumGold,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                // TODO: integrate payment / subscription
                setState(() {
                  _isPremium = true;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('🎉 Bem-vinda ao Premium!'),
                    backgroundColor: kPremiumGold,
                  ),
                );
              },
              child: const Text('Ativar Premium'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _premiumFeature(String text) {
    return Row(
      children: [
        const Icon(Icons.check_circle_outline, color: kPremiumGold, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13, color: Colors.white70),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Configurações',
          style: TextStyle(
            fontSize: 15,
            color: kTextDark,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: kPrimary.withValues(alpha: 0.06),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              _settingsTile(Icons.person_outline, 'Perfil', () {}),
              _divider(),
              _settingsTile(
                Icons.notifications_outlined,
                'Notificações',
                () {},
              ),
              _divider(),
              _settingsTile(Icons.language, 'Idioma', () {}),
              _divider(),
              _settingsTile(Icons.help_outline, 'Ajuda', () {}),
              _divider(),
              _settingsTile(Icons.logout, 'Sair', () {}),
            ],
          ),
        ),
      ],
    );
  }

  Widget _settingsTile(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: kPrimaryLight.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Icon(icon, color: kPrimary, size: 20)),
            ),
            const SizedBox(width: 14),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: kTextDark,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(Icons.chevron_right, color: kTextLight, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _divider() => Divider(
    height: 1,
    indent: 70,
    endIndent: 18,
    color: const Color(0xFFF0F0F0),
  );
}
