import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitify_app/constants/app_theme.dart';
import 'package:splitify_app/navigation/routes.dart';
import 'package:splitify_app/providers/theme_provider.dart';
import 'package:splitify_app/providers/bottom_nav_provider.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();

  //await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
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
