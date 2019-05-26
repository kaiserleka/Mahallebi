import 'package:flutter/material.dart';

class Scenario{
  int _order;
  int _no;
  String _name;
  List<Task> _taskList=[];
  Scenario({order,no,name,taskList}){
    this._order=order;
    this._no=no;
    this._name=name;
    this._taskList=taskList;
    
  }
  factory Scenario.scenarioIntroEdition(Map receivedData){
    return Scenario(
      //order:receivedData["order"],
      no:receivedData["no"],
      name:receivedData["name"],
    );
  }
  factory Scenario.scenarioGameEdition(Map receivedData){
    
    List<Task> convertedTaskList=[];
    for(var i=0;i<receivedData["tasks"].length;i++){
      convertedTaskList.add(Task(receivedData["tasks"][i]["detail"],receivedData["tasks"][i]["itemIcon"],receivedData["tasks"][i]["itemQuantity"]));
    }
    return Scenario(
     // order:receivedData["order"],
      no:receivedData["no"],
      name:receivedData["name"],
      taskList:convertedTaskList,
      );
  }
  
  // order
  int get order => this._order;
  set setOrder (reqData){
    this._order=reqData;
  }
  // no
  int get no => this._no;
  String get noText => this._no.toString();
  set setNo (reqData){
    this._no=reqData;
  }
  // name
  String get name => this._name;
  set setName (reqData){
    this._name=reqData;
  }
  // tasks
  List<Task> get taskList => this._taskList;
}
class Task{
  int _order;
  String _detail;
  String _gameItemIconName;
  int _gameItemQuantity;
  bool _isCompleted=false;
  Task(this._detail,this._gameItemIconName,this._gameItemQuantity);
  // name
  String get detail => this._detail;
  // is completed
  bool get isCompleted => this._isCompleted;
  void setAsCompleted (){
    this._isCompleted=true;
  }
  // game item icon name
  String get gameItemIconName=> this._gameItemIconName;
  // game item icon's iconData
  IconData get gameItemIconData{
    switch (this._gameItemIconName) {
    case "baby":
      return Icons.child_friendly;
    case "flover":
      return Icons.local_florist;
    default:
    }
  }
  // game item icon quantity
  int get gameItemQuantity => this._gameItemQuantity;
  //
  void decreaseQuantity(){
    this._gameItemQuantity--;
    if(this._gameItemQuantity<=0){
      setAsCompleted();
    }
  } 
}