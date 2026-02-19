import 'package:flutter/material.dart';
import 'package:gestacao/main.dart';

class LoginScreen extends StatefulWidget {
  final bool isSignUp;

  const LoginScreen({Key? key, this.isSignUp = false}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _loginFormKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();

  // Login fields
  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();

  // Signup fields
  final _signupNameController = TextEditingController();
  final _signupEmailController = TextEditingController();
  final _signupPasswordController = TextEditingController();
  final _signupConfirmPasswordController = TextEditingController();

  bool _isLoginPasswordVisible = false;
  bool _isSignupPasswordVisible = false;
  bool _isSignupConfirmPasswordVisible = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.isSignUp ? 1 : 0,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _signupNameController.dispose();
    _signupEmailController.dispose();
    _signupPasswordController.dispose();
    _signupConfirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_loginFormKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // TODO: Implementar lógica de login
    await Future.delayed(Duration(seconds: 2));

    setState(() => _isLoading = false);

    // Navegar para home (ajuste conforme sua navegação)
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login realizado com sucesso!'),
          backgroundColor: Color(0xFF6B8E6B),
        ),
      );
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage()));
    }
  }

  Future<void> _handleSignup() async {
    if (!_signupFormKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // TODO: Implementar lógica de cadastro
    await Future.delayed(Duration(seconds: 2));

    setState(() => _isLoading = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Conta criada com sucesso!'),
          backgroundColor: Color(0xFF6B8E6B),
        ),
      );
      // Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Column(
                children: [
                  // Logo/Emoji
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5C6D3),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text('🤰', style: TextStyle(fontSize: 40)),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Um dia de cada vez',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3D2B35),
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Sua gestação acompanhada com carinho',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Color(0xFF6B5A63)),
                  ),
                ],
              ),
            ),

            // Tab Bar
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: Color(0xFFF5C6D3).withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: Color(0xFFE8849C),
                  borderRadius: BorderRadius.circular(12),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: EdgeInsets.all(4),
                labelColor: Colors.white,
                unselectedLabelColor: Color(0xFF6B5A63),
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                tabs: [
                  Tab(text: 'Entrar'),
                  Tab(text: 'Cadastrar'),
                ],
              ),
            ),

            // Tab Views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [_buildLoginForm(), _buildSignupForm()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Form(
        key: _loginFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 24),
            Text(
              'Bem-vinda de volta!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3D2B35),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Entre para continuar sua jornada',
              style: TextStyle(fontSize: 14, color: Color(0xFF6B5A63)),
            ),
            SizedBox(height: 32),

            // Email
            _buildTextField(
              controller: _loginEmailController,
              label: 'E-mail',
              hint: 'seu@email.com',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.email_outlined,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira seu e-mail';
                }
                if (!value.contains('@')) {
                  return 'E-mail inválido';
                }
                return null;
              },
            ),
            SizedBox(height: 16),

            // Password
            _buildTextField(
              controller: _loginPasswordController,
              label: 'Senha',
              hint: '••••••••',
              obscureText: !_isLoginPasswordVisible,
              prefixIcon: Icons.lock_outline,
              suffixIcon: IconButton(
                icon: Icon(
                  _isLoginPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Color(0xFFE8849C),
                ),
                onPressed: () {
                  setState(() {
                    _isLoginPasswordVisible = !_isLoginPasswordVisible;
                  });
                },
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira sua senha';
                }
                if (value.length < 6) {
                  return 'Senha deve ter no mínimo 6 caracteres';
                }
                return null;
              },
            ),

            // Forgot password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // TODO: Implementar recuperação de senha
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Link enviado para seu e-mail'),
                      backgroundColor: Color(0xFF5BA3C9),
                    ),
                  );
                },
                child: Text(
                  'Esqueceu a senha?',
                  style: TextStyle(
                    color: Color(0xFFE8849C),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            SizedBox(height: 24),

            // Login button
            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE8849C),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  disabledBackgroundColor: Color(0xFFE8849C).withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isLoading
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        'Entrar',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
              ),
            ),

            SizedBox(height: 24),

            // Divider
            Row(
              children: [
                Expanded(child: Divider(color: Color(0xFFF5C6D3))),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'ou',
                    style: TextStyle(color: Color(0xFF6B5A63), fontSize: 14),
                  ),
                ),
                Expanded(child: Divider(color: Color(0xFFF5C6D3))),
              ],
            ),

            SizedBox(height: 24),

            // Social login buttons
            _buildSocialButton(
              icon: 'G',
              label: 'Continuar com Google',
              onPressed: () {
                // TODO: Implementar Google Sign In
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignupForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Form(
        key: _signupFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 24),
            Text(
              'Crie sua conta',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3D2B35),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Comece sua jornada com a gente',
              style: TextStyle(fontSize: 14, color: Color(0xFF6B5A63)),
            ),
            SizedBox(height: 32),

            // Name
            _buildTextField(
              controller: _signupNameController,
              label: 'Nome',
              hint: 'Como você gostaria de ser chamada?',
              prefixIcon: Icons.person_outline,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira seu nome';
                }
                if (value.length < 2) {
                  return 'Nome muito curto';
                }
                return null;
              },
            ),
            SizedBox(height: 16),

            // Email
            _buildTextField(
              controller: _signupEmailController,
              label: 'E-mail',
              hint: 'seu@email.com',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.email_outlined,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira seu e-mail';
                }
                if (!value.contains('@')) {
                  return 'E-mail inválido';
                }
                return null;
              },
            ),
            SizedBox(height: 16),

            // Password
            _buildTextField(
              controller: _signupPasswordController,
              label: 'Senha',
              hint: 'Mínimo 6 caracteres',
              obscureText: !_isSignupPasswordVisible,
              prefixIcon: Icons.lock_outline,
              suffixIcon: IconButton(
                icon: Icon(
                  _isSignupPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Color(0xFFE8849C),
                ),
                onPressed: () {
                  setState(() {
                    _isSignupPasswordVisible = !_isSignupPasswordVisible;
                  });
                },
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira uma senha';
                }
                if (value.length < 6) {
                  return 'Senha deve ter no mínimo 6 caracteres';
                }
                return null;
              },
            ),
            SizedBox(height: 16),

            // Confirm Password
            _buildTextField(
              controller: _signupConfirmPasswordController,
              label: 'Confirmar senha',
              hint: 'Digite a senha novamente',
              obscureText: !_isSignupConfirmPasswordVisible,
              prefixIcon: Icons.lock_outline,
              suffixIcon: IconButton(
                icon: Icon(
                  _isSignupConfirmPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Color(0xFFE8849C),
                ),
                onPressed: () {
                  setState(() {
                    _isSignupConfirmPasswordVisible =
                        !_isSignupConfirmPasswordVisible;
                  });
                },
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, confirme sua senha';
                }
                if (value != _signupPasswordController.text) {
                  return 'As senhas não coincidem';
                }
                return null;
              },
            ),

            SizedBox(height: 24),

            // Terms
            Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: Color(0xFF6B5A63)),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Ao cadastrar, você concorda com nossos Termos de Uso e Política de Privacidade',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B5A63),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 24),

            // Signup button
            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleSignup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE8849C),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  disabledBackgroundColor: Color(0xFFE8849C).withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isLoading
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        'Criar conta',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
              ),
            ),

            SizedBox(height: 24),

            // Divider
            Row(
              children: [
                Expanded(child: Divider(color: Color(0xFFF5C6D3))),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'ou',
                    style: TextStyle(color: Color(0xFF6B5A63), fontSize: 14),
                  ),
                ),
                Expanded(child: Divider(color: Color(0xFFF5C6D3))),
              ],
            ),

            SizedBox(height: 24),

            // Social signup
            _buildSocialButton(
              icon: 'G',
              label: 'Cadastrar com Google',
              onPressed: () {
                // TODO: Implementar Google Sign In
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData prefixIcon,
    Widget? suffixIcon,
    bool obscureText = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF3D2B35),
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          style: TextStyle(fontSize: 16, color: Color(0xFF3D2B35)),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Color(0xFF6B5A63).withOpacity(0.5),
              fontSize: 15,
            ),
            prefixIcon: Icon(prefixIcon, color: Color(0xFFE8849C), size: 22),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Color(0xFFF5C6D3).withOpacity(0.15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Color(0xFFF5C6D3).withOpacity(0.3),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Color(0xFFE8849C), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Color(0xFFD95F4C), width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Color(0xFFD95F4C), width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required String icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 56,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Color(0xFF3D2B35),
          side: BorderSide(color: Color(0xFFF5C6D3), width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFFF5C6D3)),
              ),
              child: Center(
                child: Text(
                  icon,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
