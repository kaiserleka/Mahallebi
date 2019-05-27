import 'package:flutter/material.dart';

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
      return Icons.not_listed_location;
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