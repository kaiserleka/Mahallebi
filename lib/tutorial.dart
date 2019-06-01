import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:mahallebi/tools/header.dart';

class Tutorial extends StatelessWidget {
  final tutorialPageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    final tutorialPageView = PageView(
      controller: tutorialPageController,
      //physics: ,
      children: <Widget>[
        
        tutorialPage(Colors.red[900],structures()),
        tutorialPage(Colors.green,Text("1")),
        tutorialPage(Colors.pink,Text("2")),
      ],
    );
    return Scaffold(
      body:tutorialPageView,
    );
  }
  Widget tutorialPage(pageColor,pageInsideWidget){
    return Container(color: pageColor,child: Column(
      children: <Widget>[
        Expanded(flex: 1,child:Center(child:  Header("Nasıl Oynanır"),),),
        Expanded(flex: 5,child: pageInsideWidget,),
        Expanded(flex: 1,child: Text("Bottom Nav"),),
      ],
    ),);
  }
  Widget structures(){
    return Image.asset("assets/tutorial/ss_street.png");
  }
}
