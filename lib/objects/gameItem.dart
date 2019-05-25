import 'package:flutter/material.dart';
import 'package:mahallebi/objects/address.dart';
class GameItem{
  String _name;
  bool _isFound=false;

 
  GameItem(this._name,);
  IconData get icon{
    switch (_name) {
    case "baby":
      return Icons.child_friendly;
    case "flover":
      return Icons.local_florist;
    default:
  }
  }
  bool get isFound => this._isFound;
  set setIsFound(reqData){
    this._isFound=reqData;
  }
}