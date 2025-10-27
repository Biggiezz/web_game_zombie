import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_game_zombie/home/home_page.dart';

void main() {
  runApp(const
  ProviderScope(child:
  MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Color(0xFF0A0A0A),
          fontFamily: 'Inter',
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFF0A0A0A),
            elevation: 0
          )
        ),

        home: HomePage());
  }
}
