import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitify_app/constants/app_theme.dart';
import 'package:splitify_app/navigation/routes.dart';
import 'package:splitify_app/providers/theme_provider.dart';
import 'package:splitify_app/providers/bottom_nav_provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:splitify_app/services/auth_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: const SplitifyApp(),
    ),
  );
}

class SplitifyApp extends StatelessWidget {
  const SplitifyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Splitify',
      theme:
          themeProvider.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      initialRoute: '/login',
      routes: appRoutes,
    );
  }
}
