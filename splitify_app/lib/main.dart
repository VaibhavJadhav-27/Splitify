import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitify_app/constants/app_theme.dart';
import 'package:splitify_app/navigation/routes.dart';
import 'package:splitify_app/providers/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
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
