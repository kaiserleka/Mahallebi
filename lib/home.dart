import 'package:flutter/material.dart';
import 'package:mahallebi/objects/scenario.dart';
import 'getDataFromJSON.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> scenarioButtonList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetDataFromJSON.getScenarioList().then((List<Scenario> dataList) {
      for (var i = 0; i < dataList.length; i++) {
        setState(() {
          scenarioButtonList.add(scenarioButton(dataList[i].order));
        });
      }
    }).catchError((err) => print("err:" + err.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red[800],
        alignment: Alignment.center,
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Mahallebi",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 30,
            ),
            (scenarioButtonList.length <= 0)
                ? LinearProgressIndicator(
                    backgroundColor: Colors.orange,
                  )
                : scenarioButtonsWidget(),
          ],
        ),
      ),
    );
  }

  Widget scenarioButtonsWidget() {
    return Column(
      children: scenarioButtonList,
    );
  }

  Widget scenarioButton(int scenarioOrder) {
    return Container(
        margin: EdgeInsets.all(10),
        child: RaisedButton.icon(
            icon: Icon(
              Icons.play_arrow,
              size: 36,
            ),
            label: Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "Senaryo-$scenarioOrder",
                style: TextStyle(fontSize: 28),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, "scenario/$scenarioOrder");
            }));
  }
}
