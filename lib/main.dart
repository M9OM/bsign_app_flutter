import 'package:bsign/core/theme/app_theme.dart';
import 'package:bsign/providers/attachment_provider.dart';
import 'package:bsign/providers/chnage_theme.dart';
import 'package:bsign/providers/document_provider.dart';
import 'package:bsign/providers/pdf_annotation_provider.dart';
import 'package:bsign/providers/signature_field_provider.dart';
import 'package:bsign/view/pages/auth/auth_state_handler.dart';
import 'package:bsign/view/pages/document/SignatureScreenLogic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'core/supabase_config.dart';
import 'providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.initialize();

  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => SignatureScreenProvider()),        
        ChangeNotifierProvider(create: (_) => AnnotationProvider()),
        ChangeNotifierProvider(create: (_) => AttachmentProvider()),
        ChangeNotifierProvider(create: (_) => DocumentProvider()),
        ChangeNotifierProvider(create: (_) => SignatureFieldProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return ChangeNotifierProvider(
          create: (_) => AuthProvider(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode:
                themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: AnimatedSplashScreen(
              splash: Icons.home,
              splashTransition: SplashTransition.fadeTransition,
              backgroundColor: Colors.blue,
              nextScreen: AuthStateHandler(),
              duration: 3000,
            ),
          ),
        );
      },
    );
  }
}
