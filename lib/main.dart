
import 'package:artifex/features/prompt/ui/create_prompt_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void>  main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.grey.shade900),
      home: CreatePromptScreen(),
    );
  }
}