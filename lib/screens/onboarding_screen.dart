import 'package:flutter/material.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      emoji: '🌸',
      title: 'Sua gestação acompanhada\ntodos os dias',
      description:
          'Cada fase da gestação é única. Receba mensagens diárias, orientações e pequenos lembretes pensados para cuidar de você e do seu bebê com calma e carinho.',
      supportText: 'Porque cada dia importa.',
      color: Color(0xFFF5C6D3),
      accentColor: Color(0xFFE8849C),
    ),
    OnboardingPage(
      emoji: '💕',
      title: 'Você não está sozinha\nnessa jornada',
      description:
          'Mensagens como se o bebê estivesse falando com você, informações sobre o desenvolvimento semana a semana e lembretes suaves para se hidratar, descansar e se movimentar.',
      supportText: 'Um cuidado que acompanha você.',
      color: Color(0xFFF3D7E3),
      accentColor: Color(0xFFD4A5C4),
    ),
    OnboardingPage(
      emoji: '✨',
      title: 'Tudo no seu tempo',
      description:
          'Personalize sua gestação e receba conteúdos adaptados à sua fase. Um espaço leve, seguro e pensado para tornar esse momento mais tranquilo.',
      supportText: '',
      color: Color(0xFFFFF8F9),
      accentColor: Color(0xFFE8849C),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _goToLogin();
    }
  }

  void _goToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            if (_currentPage < _pages.length - 1)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _goToLogin,
                    child: Text(
                      'Pular',
                      style: TextStyle(
                        color: Color(0xFFE8849C),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
            else
              SizedBox(height: 60),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index]);
                },
              ),
            ),

            // Page Indicator
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => _buildDot(index),
                ),
              ),
            ),

            // Buttons
            Padding(
              padding: EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: _currentPage == _pages.length - 1
                  ? Column(
                      children: [
                        // Primary CTA
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      LoginScreen(isSignUp: true),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFE8849C),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              'Começar agora',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        // Secondary CTA
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: OutlinedButton(
                            onPressed: _goToLogin,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Color(0xFFE8849C),
                              side: BorderSide(
                                color: Color(0xFFE8849C),
                                width: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              'Já tenho conta',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE8849C),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Continuar',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          SizedBox(height: 20),
          // Emoji illustration
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              color: page.color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                page.emoji,
                style: TextStyle(fontSize: 80),
              ),
            ),
          ),
          SizedBox(height: 48),
          // Title
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3D2B35),
              height: 1.3,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 24),
          // Description
          Text(
            page.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF6B5A63),
              height: 1.6,
              letterSpacing: 0.1,
            ),
          ),
          if (page.supportText.isNotEmpty) ...[
            SizedBox(height: 24),
            // Support text
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: page.color.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                page.supportText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: page.accentColor,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: _currentPage == index ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? Color(0xFFE8849C) : Color(0xFFF5C6D3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class OnboardingPage {
  final String emoji;
  final String title;
  final String description;
  final String supportText;
  final Color color;
  final Color accentColor;

  OnboardingPage({
    required this.emoji,
    required this.title,
    required this.description,
    required this.supportText,
    required this.color,
    required this.accentColor,
  });
}
