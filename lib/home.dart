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
          scenarioButtonList.add(scenarioButton(dataList[i].order,dataList[i].name));
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

  Widget scenarioButton(int scenarioOrder,String scenarioName) {
    return Container(
      decoration: BoxDecoration(
        //border: Border.all(),
        borderRadius: BorderRadius.circular(10),
color: Colors.orange[50],
      ),
      alignment: Alignment.bottomLeft,
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[GestureDetector(
          
           
            child: Container(
              alignment: Alignment.centerLeft,
              
              padding: EdgeInsets.all(5),
              child: Row(
                children: <Widget>[
Expanded(flex: 1,child: Icon(Icons.play_arrow,size: 36,),),
                  Expanded(flex: 4,child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                "Senaryo:",
                style: TextStyle(fontSize: 28),
              ),
              Text(
                scenarioName,
                style: TextStyle(fontSize: 18),
              ),
                ],
              ),)
                ],
              )
            ),
            onTap: () {
              Navigator.pushNamed(context, "scenario/$scenarioOrder");
            })],
        ));
  }
}
