import 'package:flutter/material.dart';
import 'package:mahallebi/objects/scenario.dart';
import 'getDataFromJSON.dart';

class ScenarioMenu extends StatefulWidget {
  @override
  _ScenarioMenuState createState() => _ScenarioMenuState();
}

class _ScenarioMenuState extends State<ScenarioMenu> {
  List<Widget> scenarioButtonList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetDataFromJSON.getScenarioList().then((List<Scenario> dataList) {
      for (var i = 0; i < dataList.length; i++) {
        setState(() {
          scenarioButtonList
              .add(scenarioButton(dataList[i].order, dataList[i].name,dataList[i].no));
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
            (scenarioButtonList.length <= 0)
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.orange,
                    ),
                  )
                : scenarioButtonsWidget(),
          ],
        ),
      ),
    );
  }

  Widget scenarioButtonsWidget() {
    return Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: scenarioButtonList,
        ));
  }

  Widget scenarioButton(int scenarioOrder, String scenarioName,int scenarioNo) {
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
          children: <Widget>[
            GestureDetector(
                child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.play_circle_outline,
                            size: 36,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                scenarioName,
                                style: TextStyle(fontSize: 28,fontWeight: FontWeight.w700),
                                
                              ),
                              Text(
                                "Senaryo No:"+scenarioNo.toString(),
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                onTap: () {
                  Navigator.pushNamed(context, "scenario/$scenarioOrder");
                })
          ],
        ));
  }
}
