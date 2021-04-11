import 'package:flutter/material.dart';
import 'package:learn4kids/routing/router.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 5, child: Center(child: Text("Eins"))),
          Expanded(
              flex: 5,
              child: Align(
                child: GestureDetector(
                  onLongPress: () {
                    Navigator.pushNamed(context, SettingsRoute);
                  },
                  child: IconButton(
                    icon: const Icon(Icons.settings),
                    iconSize: 50,
                  ),
                ),
                alignment: Alignment.bottomRight,
              )),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
