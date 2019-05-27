import 'package:flutter/material.dart';
import 'package:mahallebi/objects/task.dart';

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
