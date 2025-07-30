import 'package:bsign/extensions/navigator_extensions.dart';
import 'package:bsign/view/pages/create_sign/t.dart';
import 'package:bsign/view/pages/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:bsign/providers/chnage_theme.dart'; // تأكد من مسار هذا
import 'package:google_generative_ai/google_generative_ai.dart';

// ---- BotService class ----
class BotService {
  final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: 'AIzaSyAFWD57jyCRzdzVU7o5Yh9EB-sUutmWUcc',
  );
  Future<String?> sendPrompt(String prompt, BuildContext context) async {
    final content = [
      Content.text('''
. Do not talk about yourself or your technologies. Answer the question only: ($prompt).
Additional instructions:

If the user says "change theme" or "change mode" or "change appearance" or anything similar, return "change_theme".

If the user says "settings page" or anything similar, return "setting_page".

If the user says "add signature" or anything similar, return "add_signature".

Ignore other unrelated information.
'''),
    ];
    final response = await model.generateContent(content);

    final reply =
        response.text ?? "Sorry, we couldn't process your request right now.";

    if (reply.contains('change_theme')) {
      final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
      themeProvider.toggleTheme(!themeProvider.isDarkMode); // عكس الوضع الحالي
      return 'change_theme'; // ترجع بس هذه الكلمة لما يكون في طلب تغيير ثيم
    } else if (reply.contains('setting_page')) {
      navigateTo(context, SettingsPage());
    } else if (reply.contains('add_signature')) {
      navigateTo(context, SignaturePage());
    }

    return reply; // ترجع الرد الأصلي إذا ما كان طلب تغيير ثيم
  }
}

// ---- ChatBotPage widget ----
class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage>
    with SingleTickerProviderStateMixin {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'tap and hold the mic to start speaking...';
  String _botReply = ''; // لعرض رد البوت
  double _scale = 1.0;
  late AnimationController _controller;
  final BotService _botService = BotService();

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      lowerBound: 0.95,
      upperBound: 1.1,
    )..addListener(() {
      setState(() {
        _scale = _controller.value;
      });
    });
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() {
        _isListening = true;
        _text = '';
        _botReply = '';
      });
      _speech.listen(
        localeId: 'ar_SA',
        onResult: (val) async {
          setState(() {
            _text = val.recognizedWords;
          });

          if (val.hasConfidenceRating && val.finalResult) {
            _stopListening();
            await startSearch(_text); // ابدأ البحث بعد الانتهاء
          }
        },
      );
    }
  }

  void _stopListening() {
    setState(() => _isListening = false);
    _speech.stop();
  }

  Future<void> startSearch(String query) async {
    debugPrint("بدء البحث عن: $query");
    final reply = await _botService.sendPrompt(query, context);
    setState(() {
      _botReply = reply ?? "لا يوجد رد من البوت";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Icon(HugeIcons.strokeRoundedArrowDown01),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: AutoSizeText(
                    _text.isEmpty ? '...' : _text,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'arabic',
                    ),
                    textAlign: TextAlign.center,
                    minFontSize: 16,
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),

            Center(
              child: GestureDetector(
                onLongPress: _startListening,
                onLongPressEnd: (details) => _stopListening(),
                child: Transform.scale(
                  scale: _isListening ? _scale : 1.0,
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors:
                            _isListening
                                ? [Colors.orange, Colors.red]
                                : [
                                  Theme.of(context).primaryColor,
                                  const Color.fromARGB(255, 163, 186, 255),
                                ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Icon(
                      HugeIcons.strokeRoundedMic01,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
