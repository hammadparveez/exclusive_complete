import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/view/test_provider.dart';

class TestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TestProvider(),
      child: Container(child: Builder(builder: (ct) {
        return Text("Hello World");
      })),
    );
  }
}
