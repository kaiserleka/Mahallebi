import 'package:flutter/material.dart';

class SettingsMenu extends StatefulWidget {
  @override
  _SettingsMenuState createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.red[800],
            alignment: Alignment.center,
            //padding: EdgeInsets.all(25),
            child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image.asset(
                    "assets/interface/header1.png",
                    width: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(
              height: 30,
            ),
            GestureDetector(
                child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.audiotrack,
                            size: 36,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: 
                              Text(
                                "Ses Efekti Aç/Kapa",
                                style: TextStyle(fontSize: 18),
                              ),
                            
                          
                        )
                      ],
                    )),
                onTap: () {
                  //Navigator.pushNamed(context, "scenario/$scenarioOrder");
                })
                ])));
  }
}
