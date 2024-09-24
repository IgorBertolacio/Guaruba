import 'package:flutter/material.dart';
import 'package:myapp/presentation/pages/code_page/main_code_page.dart';

class Guaruba extends StatelessWidget {
  const Guaruba({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainCodePage(),
    );
  }
}