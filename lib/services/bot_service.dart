import 'package:bsign/providers/chnage_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:provider/provider.dart';

class BotService {
  final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: 'AIzaSyAFWD57jyCRzdzVU7o5Yh9EB-sUutmWUcc',
  );

Future<String?> sendPrompt(String prompt, BuildContext context) async {
  final content = [
    Content.text('''
. لا تتكلم عن نفسك أو عن تقنياتك. جاوب على السؤال فقط: ($prompt).
التعليمات الإضافية:

 change_theme اذا قال المستخدم "غير الثيم" أو "غير الوضع" أو "غير المظهر" أو أي شيء مشابه، قم  برجاع . 
'''),
  ];
  final response = await model.generateContent(content);

  final reply = response.text ?? "نعتذر، لم نتمكن من معالجة استفسارك حاليًا.";

  if (reply.contains('change_theme')) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    themeProvider.toggleTheme(themeProvider.isDarkMode);
  }

  return reply;
}

}
