import 'package:gestacao/models/daily_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MessageService {
  // ─── Local fallback messages (used when API is unavailable) ──
  static const List<Map<String, String>> _fallbackMessages = [
    {
      'message':
          'Você está fazendo um trabalho incrível. Cada dia é uma pequena vitória na sua jornada.',
      'category': 'motivational',
      'emoji': '🌸',
    },
    {
      'message':
          'Lembre-se de se hidratar! Água é essencial para você e para o seu bebezinho.',
      'category': 'health',
      'emoji': '💧',
    },
    {
      'message':
          'Seu bebê já consegue ouvir sua voz. Converse com ele — ele adora!',
      'category': 'baby',
      'emoji': '👶',
    },
    {
      'message':
          'Uma caminhada leve pode fazer maravilhas para seu bem-estar hoje.',
      'category': 'health',
      'emoji': '🚶‍♀️',
    },
    {
      'message':
          'Você é mais forte do que imagina. Confie no seu corpo e no seu instinto materno.',
      'category': 'motivational',
      'emoji': '💪',
    },
    {
      'message':
          'Não se esqueça de descansar. O sono é um presente para você e para o bebê.',
      'category': 'health',
      'emoji': '😴',
    },
    {
      'message':
          'Cada momento da sua gravidez é único e precioso. Saboreie esta fase.',
      'category': 'motivational',
      'emoji': '✨',
    },
    {
      'message':
          'Seu bebê está crescendo e se desenvolvendo maravilhosamente dentro de você.',
      'category': 'baby',
      'emoji': '🌱',
    },
    {
      'message':
          'Você merece um momento só seu. Tome um banho relaxante e cuide de si.',
      'category': 'health',
      'emoji': '🛁',
    },
    {
      'message':
          'Rir é um ótimo exercício durante a gravidez. Assista algo que te faça rir hoje!',
      'category': 'motivational',
      'emoji': '😊',
    },
    {
      'message':
          'Seu bebê pode sentir quando você está feliz. Espalhe alegria hoje!',
      'category': 'baby',
      'emoji': '💕',
    },
    {
      'message':
          'Lembre-se de tomar suas vitaminas. Elas são importantes para sua saúde e do bebê.',
      'category': 'health',
      'emoji': '💊',
    },
    {
      'message':
          'Você está criando vida — algo verdadeiramente mágico acontece dentro de você.',
      'category': 'motivational',
      'emoji': '🌷',
    },
    {
      'message':
          'Abraçe alguém que você ama hoje. O amor é energia positiva para vocês dois.',
      'category': 'motivational',
      'emoji': '🤗',
    },
    {
      'message':
          'Seu corpo está passando por mudanças emocionantes. Cada uma é sinal de vida e saúde.',
      'category': 'baby',
      'emoji': '💫',
    },
    {
      'message':
          'Uma boa respiração profunda pode aliviar tensões. Tente agora: inspire por 4s, expira por 6s.',
      'category': 'health',
      'emoji': '🌬️',
    },
    {
      'message':
          'Você não precisa ser perfeita. Você só precisa ser você — e isso já é mais que suficiente.',
      'category': 'motivational',
      'emoji': '🌼',
    },
    {
      'message':
          'Seu bebê vai nascer logo e vai te conhecer pessoalmente. Que momento lindo!',
      'category': 'baby',
      'emoji': '🍼',
    },
    {
      'message':
          'Coma bem hoje. Frutas, verduras e grãos são presentes maravilhosos para você e o bebê.',
      'category': 'health',
      'emoji': '🍎',
    },
    {
      'message': 'Você já virou mamãe no coração. Que orgulho!',
      'category': 'motivational',
      'emoji': '💖',
    },
  ];

  static const String _cachedMessageKey = 'cached_daily_message';
  static const String _cachedDateKey = 'cached_daily_message_date';

  /// Returns today's message — from cache if already fetched today, otherwise fetches new.
  Future<DailyMessage> getTodayMessage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final today = DateTime.now();
      final todayStr =
          '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

      // Check if we have a cached message from today
      final cachedDate = prefs.getString(_cachedDateKey);
      if (cachedDate == todayStr) {
        final cachedJson = prefs.getString(_cachedMessageKey);
        if (cachedJson != null) {
          try {
            final map = json.decode(cachedJson) as Map<String, dynamic>;
            print('✅ Retornando mensagem do cache: ${map['message']}');
            return DailyMessage.fromMap(map);
          } catch (e) {
            print('❌ Erro ao decodificar cache: $e');
            // Continue to fetch new message
          }
        }
      }

      print('🔄 Buscando nova mensagem para hoje: $todayStr');

      // Try to fetch from API
      DailyMessage? apiMessage;
      try {
        apiMessage = await _fetchFromApi(today);
        if (apiMessage != null) {
          print('✅ Mensagem da API obtida com sucesso');
        }
      } catch (e) {
        print('❌ Erro na API: $e. Usando mensagem local...');
      }

      // If API fails, use local message
      final message = apiMessage ?? _getLocalMessage(today);

      // Cache it
      try {
        await prefs.setString(_cachedDateKey, todayStr);
        await prefs.setString(_cachedMessageKey, json.encode(message.toMap()));
        print('✅ Mensagem salva no cache: ${message.message}');
      } catch (e) {
        print('⚠️ Erro ao salvar no cache: $e');
      }

      return message;
    } catch (e) {
      print('❌ Erro crítico em getTodayMessage: $e');
      // Fallback to a basic local message
      return _getLocalMessage(DateTime.now());
    }
  }

  /// Fetch daily message from API
  Future<DailyMessage?> _fetchFromApi(DateTime today) async {
    try {
      // IMPORTANTE: Em dispositivos físicos ou emuladores Android/iOS,
      // use o IP 10.0.2.2 para localhost do computador hospedeiro
      final url = Uri.parse('http://10.0.2.2:5000/messages/daily');

      print('🌐 Conectando à API: $url');
      final response = await http.get(url).timeout(const Duration(seconds: 10));

      print('📊 Status da API: ${response.statusCode}');
      print('📄 Resposta da API: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        return DailyMessage(
          id: data['id']?.toString() ?? 'api_${today.day}',
          message: data['message'] as String,
          category: data['category']?.toString() ?? 'motivacional',
          emoji: data['emoji']?.toString() ?? '🌸',
          date: today,
        );
      } else {
        print('❌ API retornou status ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('❌ Erro na requisição da API: $e');
      return null;
    }
  }

  /// Get a local fallback message based on the date
  DailyMessage _getLocalMessage(DateTime today) {
    // Calcular dia do ano (1-365/366)
    final startOfYear = DateTime(today.year, 1, 1);
    final dayOfYear = today.difference(startOfYear).inDays + 1;

    // Usar o dia do ano para selecionar uma mensagem
    final index = (dayOfYear - 1) % _fallbackMessages.length;
    final msg = _fallbackMessages[index];

    print('📱 Usando mensagem local #$index: ${msg['message']}');

    return DailyMessage(
      id: 'local_${today.year}_$dayOfYear',
      message: msg['message']!,
      category: msg['category']!,
      emoji: msg['emoji']!,
      date: today,
    );
  }
}
