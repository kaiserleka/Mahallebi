import 'package:flutter/material.dart';
import 'game.dart';
import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // root class
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => new Home(),
      },
      onGenerateRoute: (RouteSettings settings) {
        List<String> pathElements = settings.name.split("/");
        //for(var pth in pathElements)
        //debugPrint("path :"+pth);
        if (pathElements[0] == "scenario") {
          return MaterialPageRoute(
              builder: (context) => Game(scenario: int.parse(pathElements[1])));
        }
      },
      title: 'Mahallebi',
      theme: ThemeData(
        // red
        primarySwatch: Colors.red,
      ),
      // home: new Homes(),
    );
  }
}
