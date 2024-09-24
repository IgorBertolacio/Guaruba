import 'package:flutter/material.dart';
import 'package:myapp/presentation/widgets/code_page/widget_blocos_pilha.dart';
import 'package:myapp/presentation/widgets/code_page/widget_menu_lateral.dart';

class MainCodePage extends StatelessWidget {
  const MainCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Row(
          children: [
            WidigetMenuLateral(),
            WidgetBlocosPilha(),
          ],
        ),
      ),
    );
  }
}
