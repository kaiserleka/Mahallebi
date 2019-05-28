import 'package:flutter/material.dart';
import 'package:mahallebi/tools/custom_icons_icons.dart';

class Task{
  int _order;
  
  String _detail;
  String _gameItemName;
  int _gameItemQuantity;
  bool _isCompleted=false;
  Task(this._detail,this._gameItemName,this._gameItemQuantity);
  // name
  String get detail => this._detail;
  // is completed
  bool get isCompleted => this._isCompleted;
  void setAsCompleted (){
    this._isCompleted=true;
  }
  // game item icon name
  String get gameItemName=> this._gameItemName;
  // game item icon's iconData
  String get gameItemImageAddress{
    switch (this._gameItemName) {
    case "baby":
      return "assets/itemImages/sunflower.png";
    case "flover":
      return "assets/itemImages/baby.png";
        default:
      return "assets/itemImages/sunflower.png";
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