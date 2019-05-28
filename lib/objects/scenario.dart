import 'package:flutter/material.dart';
import 'package:mahallebi/objects/task.dart';

class Scenario{
  int _order;
  int _no;
  String _name;
  String _description;
  int _time;
  int _hintCount;
  List<Task> _taskList=[];
  Scenario({order,no,name,description,time,hintCount,taskList}){
    this._order=order;
    this._no=no;
    this._name=name;
    this._description=description;
    this._time=time;
    this._hintCount=hintCount;
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
      description:receivedData["description"],
      time:receivedData["time"],
      hintCount:receivedData["hintCount"],
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
  // description
  String get description => this._description;
  // time
  int get time => this._time;
  // hint count
  int get hintCount => this._hintCount;
  // tasks
  List<Task> get taskList => this._taskList;
}
