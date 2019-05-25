import 'dart:math';
import 'street.dart';


class World {
  List<Street> _streetList=[];
  
  World (int lengthOfStreets){
    //TR: verilen birimin karesi kadar cadde oluştur
    for(var i=0;i<pow(lengthOfStreets, 2);i++){
      this._streetList.add(new Street(i));
      //print("$i. Cadde eklendi");
    }
  }
  // street list
  List<Street> get streetList => this._streetList;
}