import 'package:flutter/material.dart';
import 'package:scroll_demo/main_content.dart';
import 'package:scroll_demo/theme.dart';
import 'package:sizer/sizer.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: ((context, orientation, deviceType) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: defaultTheme,
            home: Scaffold(
              appBar: AppBar(
                title: const Text('Scroll demo'),
              ),
              body: MainContent(
                deviceType: deviceType,
              ),
            ),
          )),
    );
  }
}
