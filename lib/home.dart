import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            /* Text(
              "Mahallebi",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ), */
            SizedBox(
              height: 30,
            ),
            menuItem(
                buttonText: "Senaryo Seç",
                buttonIcon: Icons.playlist_play,
                target: "scenarioMenu"),
            /*menuItem(
              buttonText: "Serbest Dolaş",
              buttonIcon: Icons.play_arrow,
            ),*/
           /* menuItem(
                buttonText: "Ayarlar",
                buttonIcon: Icons.settings,
                target: "settingsMenu")*/
          ],
        ),
      ),
    );
  }

  Widget menuItem({buttonText, buttonIcon, target}) {
    return Container(
        //color: Colors.black,
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        decoration: BoxDecoration(
          //border: Border.all(),
          borderRadius: BorderRadius.circular(10),
          color: (target != null) ? Colors.white : Colors.grey,
        ),
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Icon(
                  buttonIcon,
                  color: Colors.red[900],
                  size: 36,
                )),
            Expanded(
              flex: 5,
              child: GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Text(buttonText,style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),),
                ),
                onTap: () {
                  if (target != null) Navigator.pushNamed(context, "/$target");
                },
              ),
            )
          ],
        ));
  }
}
