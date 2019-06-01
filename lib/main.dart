import 'package:flutter/material.dart';
import 'package:mahallebi/settingsMenu.dart';
import 'package:mahallebi/tutorial.dart';
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
        '/settingsMenu': (context)=> new SettingsMenu(),
        '/tutorial': (context)=> new Tutorial()
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
        //appBarTheme: AppBarTheme(color: Colors.redAccent[700]),
        //dialogTheme: DialogTheme(backgroundColor:  Colors.redAccent[700]),
        primarySwatch: Colors.red,
        
      ),
      debugShowCheckedModeBanner: false,
      // home: new Homes(),
    );
  }
  
}
