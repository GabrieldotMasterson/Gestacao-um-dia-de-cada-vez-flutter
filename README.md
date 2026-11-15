# 🤰 Gestação: Um Dia de Cada Vez — App Mobile Flutter

> **Aplicativo móvel desenvolvido em Flutter para acompanhamento gestacional diário, com interface humanizada, temas dinâmicos, abas modulares e AppWidgets nativos Android.**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)](https://dart.dev/)
[![Android](https://img.shields.io/badge/Platform-Android-3DDC84?logo=android)](https://www.android.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## 📌 Visão Geral

O **Gestação: Um Dia de Cada Vez** é uma solução móvel desenhada para proporcionar tranquilidade, apoio informativo e acolhimento para gestantes ao longo de todas as semanas da gravidez. O aplicativo possui múltiplos temas visuais (Floral, Força, Natureza, Noite, Oceano, Serenidade), fluxo de onboarding intuitivo, login, acompanhamento de desenvolvimento fetal e integração completa com a [`API_gestacao`](https://github.com/GabrieldotMasterson/API_gestacao).

---

## 📸 Demonstração Visual da Aplicação

| Interface do App Mobile em Execução (Aba Conta & Desenvolvimento Fetal) |
|:---:|
| <img src="assets/screenshots/preview.png" alt="Aba Conta - Gestação" width="380"/> |
| *Captura do dispositivo demonstrando a semana 22, contagem regressiva para o parto, métricas fetais (tamanho, audição e movimento) e navegação inferior por abas.* |

---

## 📱 Módulos e Abas da Aplicação

A arquitetura de telas do aplicativo é dividida nas seguintes rotas e abas:

1. **💌 Aba Mensagens (`daily_message_page.dart`):**
   - Frase diária obstétrica e acolhimento emocional para a mamãe.
   - Exibição dinâmica de mensagens consumidas da `API_gestacao` (base com 589 mensagens categorizadas).
   - Card interativo com a semana atual e dicas de saúde e nutrição.

2. **⏰ Aba Lembretes (`reminders_page.dart`):**
   - Agendamento e monitoramento de consultas médicas e exames pré-natais.
   - Lembretes periódicos de medicamentos e hidratação.

3. **👤 Aba Conta & Gestação (`account_page.dart`):**
   - Dados da gestante e cálculo do trimestre gestacional (1º, 2º ou 3º trimestre).
   - Indicadores numéricos: dias até o parto, semanas restantes e semana atual.
   - Painel **"Sobre Bebezinho"**: tamanho comparativo (ex: manga, mamão), desenvolvimento auditivo e marcos motores.
   - Seletor de paletas temáticas com persistência local (`flutter_secure_storage`).

4. **👑 Aba Premium (`premium_page.dart`):**
   - Planos e benefícios exclusivos para acompanhamento aprofundado e relatórios obstétricos.

5. **🔐 Onboarding & Autenticação (`onboarding_screen.dart`, `login_screen.dart`):**
   - Apresentação acolhedora do propósito do app e fluxo de login/cadastro integrado via JWT.

6. **📱 AppWidgets Nativos Android (`android/app/src/main/res/drawable/`):**
   - Widgets de tela inicial desenvolvidos com drawables XML (`widget_floral_background.xml`, `widget_oceano_background.xml`, etc.) para visualização rápida da mensagem do dia sem abrir o aplicativo.

---

## 🛠️ Tecnologias Utilizadas

- **Framework:** [Flutter SDK](https://flutter.dev/) (Dart 3.x)
- **Persistência Local:** `flutter_secure_storage` para tokens JWT e configurações de perfil
- **UI & Estilização:** Material Design, Google Fonts e temas personalizados em `lib/commons/theme.dart`
- **Backend Integrado:** [API_gestacao](https://github.com/GabrieldotMasterson/API_gestacao) em Flask + PostgreSQL/SQLite

---

## 📁 Estrutura de Pastas

```bash
Gestacao-um-dia-de-cada-vez-flutter/
├── assets/
│   └── screenshots/
│       └── preview.png                      # Captura real da tela de gestação do app
├── android/                                 # Código nativo Android e drawables dos widgets
│   └── app/src/main/res/drawable/
│       ├── widget_floral_background.xml
│       ├── widget_natureza_background.xml
│       ├── widget_noite_background.xml
│       └── widget_serenidade_background.xml
├── lib/
│   ├── main.dart                            # Ponto de entrada e configuração de rotas
│   ├── commons/
│   │   ├── secure_storage.dart              # Gerenciamento de credenciais locais
│   │   └── theme.dart                       # 6 Paletas de cores temáticas
│   ├── models/
│   │   ├── daily_message.dart               # Modelo de mensagem diária da API
│   │   └── reminder.dart                    # Modelo de lembrete pré-natal
│   ├── screens/                             # Abas e telas do app
│   │   ├── account_page.dart                # Aba Conta e timeline da gestação
│   │   ├── daily_message_page.dart          # Aba Mensagens diárias
│   │   ├── reminders_page.dart              # Aba Lembretes
│   │   ├── premium_page.dart                # Aba Assinatura Premium
│   │   ├── onboarding_screen.dart           # Boas-vindas
│   │   └── login_screen.dart                # Autenticação
│   ├── services/
│   │   ├── api_service.dart                 # Cliente HTTP com a API_gestacao
│   │   ├── message_service.dart             # Consumo de mensagens diárias
│   │   └── reminder_service.dart            # Persistência de lembretes
│   └── widgets/
│       └── soft_background.dart             # Fundo em degradê com efeito blur
├── pubspec.yaml                             # Dependências do projeto Flutter
└── README.md
```

---

## ⚙️ Pré-requisitos & Execução

Para compilar e rodar em emulador ou dispositivo físico:
- **Flutter SDK** (3.19 ou superior)
- **Android Studio** com Android SDK & Platform-Tools instalados
- Emulador Android (AVD) ou smartphone conectado com depuração USB ativada

```bash
# 1. Instalar dependências
flutter pub get

# 2. Verificar dispositivo disponível
flutter devices

# 3. Executar o aplicativo
flutter run
```

---

## 📄 Licença

Distribuído sob a licença MIT. Consulte `LICENSE` para mais informações.
