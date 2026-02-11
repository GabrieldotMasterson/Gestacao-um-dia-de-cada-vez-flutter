import 'package:flutter/material.dart';
import 'package:gestacao/commons/theme.dart';
import 'package:gestacao/models/daily_message.dart';
import 'package:gestacao/services/message_service.dart';

class DailyMessagePage extends StatefulWidget {
  const DailyMessagePage({super.key});
  @override
  State<DailyMessagePage> createState() => _DailyMessagePageState();
}

class _DailyMessagePageState extends State<DailyMessagePage>
    with SingleTickerProviderStateMixin {
  DailyMessage? _message;
  bool _loading = true;
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final msg = await MessageService().getTodayMessage();
      print(msg);
      if (mounted) {
        setState(() {
          _message = msg;
          _loading = false;
        });
        _controller.forward();
      }
    } catch (_) {
      if (mounted) {
        print("errooo");
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSurface,
      body: Stack(
        children: [
          // Decorative blobs
          Positioned(
            top: -60,
            right: -40,
            child: _blob(200, kPrimaryLight.withValues(alpha: 0.45)),
          ),
          Positioned(
            top: 50,
            left: -35,
            child: _blob(130, kAccent.withValues(alpha: 0.22)),
          ),
          Positioned(
            bottom: -70,
            left: -50,
            child: _blob(220, kPrimaryLight.withValues(alpha: 0.35)),
          ),
          Positioned(
            bottom: 60,
            right: -25,
            child: _blob(110, kAccent.withValues(alpha: 0.18)),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mensagem do Dia',
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge?.copyWith(color: kTextDark),
                          ),
                          Text(
                            'Uma palavra especial para você',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Main card area
                Expanded(
                  child: _loading
                      ? _buildLoader()
                      : _message != null
                      ? _buildMessageContent()
                      : _buildError(),
                ),

                // Widget CTA banner
                _buildWidgetCTA(),
              ],
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

  Widget _buildLoader() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 48,
          height: 48,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(kPrimary),
            strokeWidth: 3,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Preparando sua mensagem...',
          style: TextStyle(color: kTextLight, fontSize: 14),
        ),
      ],
    ),
  );

  Widget _buildError() => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('😢', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 12),
          Text(
            'Não foi possível carregar a mensagem.',
            style: TextStyle(color: kTextMid),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _load,
            child: const Text('Tentar novamente'),
          ),
        ],
      ),
    ),
  );

  // Função para mostrar o pop-up
void _showHowToDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Como adicionar o widget'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStep(1, 'Pressione e segure em uma área vazia da tela inicial'),
              _buildStep(2, 'Toque em "Widgets" no menu que aparecer'),
              _buildStep(3, 'Encontre nosso app na lista'),
              _buildStep(4, 'Selecione o widget "Mensagem do Dia"'),
              _buildStep(5, 'Arraste para a posição desejada'),
              const SizedBox(height: 16),
              const Text(
                'Pronto! Agora você verá uma nova mensagem inspiradora todos os dias.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendi'),
          ),
        ],
      );
    },
  );
}

Widget _buildStep(int number, String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: kPrimary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              '$number',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    ),
  );
}

  Widget _buildMessageContent() {
    final msg = _message!;
    return SlideTransition(
      position: _slideUp,
      child: FadeTransition(
        opacity: _fadeIn,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Emoji circle
              AnimatedScale(
                scale: 1.0,
                duration: const Duration(milliseconds: 600),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [kPrimaryLight, kAccent.withValues(alpha: 0.6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: kPrimary.withValues(alpha: 0.25),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      msg.emoji,
                      style: const TextStyle(fontSize: 42),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Category tag
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _categoryLabel(msg.category),
                  style: TextStyle(
                    fontSize: 12,
                    color: kPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Message text card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: kPrimary.withValues(alpha: 0.1),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(28),
                child: Text(
                  msg.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.6,
                    color: kTextDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Date label
              Text(
                _formatDate(msg.date),
                style: TextStyle(fontSize: 13, color: kTextLight),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildWidgetCTA() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              kPrimary.withValues(alpha: 0.08),
              kAccent.withValues(alpha: 0.12),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: kPrimary.withValues(alpha: 0.2), width: 1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            const Text('📱', style: TextStyle(fontSize: 24)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Adicione o Widget na sua tela',
                    style: TextStyle(
                      fontSize: 14,
                      color: kTextDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Receba a mensagem do dia sem abrir o app',
                    style: TextStyle(fontSize: 12, color: kTextMid),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: kPrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  _showHowToDialog(context);
                },
                child: const Text(
                  'Como?',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _categoryLabel(String cat) {
    switch (cat) {
      case 'health':
        return '🏥 Saúde';
      case 'baby':
        return '👶 Bebê';
      case 'motivational':
        return '⭐ Motivação';
      default:
        return '✨ Especial';
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Fev',
      'Mar',
      'Abr',
      'Mai',
      'Jun',
      'Jul',
      'Ago',
      'Set',
      'Out',
      'Nov',
      'Dez',
    ];
    return '${date.day} de ${months[date.month - 1]} de ${date.year}';
  }
}
