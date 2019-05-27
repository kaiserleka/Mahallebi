import 'package:flutter/material.dart';
import 'package:mahallebi/settingsMenu.dart';
import 'game.dart';
import 'home.dart';
import 'scenarioMenu.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // root class
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => new Home(),
        '/scenarioMenu': (context)=> new ScenarioMenu(),
        '/settingsMenu': (context)=> new SettingsMenu()
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
