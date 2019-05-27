import 'dart:math';
import '../infoCenter.dart';
import 'floor.dart';

class Apartment {
  int _no;
  String _name;
  //String _image;
  String _typeImage;
  double _heightImage;
  double _widthImage;
  List<Floor> _floorList = [];

  Apartment(no) {
    this._no = no;
    //create random type for this unit
    
    var type = Random().nextInt(InfoCenter.apartmentTypeList.length);
    this._typeImage = InfoCenter.apartmentTypeList[type]["image"];
    this._heightImage = InfoCenter.apartmentTypeList[type]["height"];
    this._widthImage = InfoCenter.apartmentTypeList[type]["width"];
    this._name=InfoCenter.apartmentTypeList[type]["name"];
    //number of floor
    for (var i = 0; i < InfoCenter.apartmentTypeList[type]["floorCount"]; i++) {
      Floor curFloor = new Floor(i,InfoCenter.apartmentTypeList[type]["housePerFloor"]);
      this._floorList.add(curFloor);
    }
  }
  String get unitImageAddress {
    return _typeImage;
  }
  double get unitImageHeight {
    return _heightImage;
  }
  double get unitImageWidth {
    return _widthImage;
  }

  // apt no
  int get apartmentNo => this._no;
  // apt name
  String get apartmentName => this._name;
  // floors
  List<Floor> get floorList => this._floorList;
}
