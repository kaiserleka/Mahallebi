import 'dart:math';
import '../infoCenter.dart';
import 'floor.dart';

class Apartment {
  int _no;
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
    //number of floor
    for (var i = 0; i < InfoCenter.apartmentTypeList[type]["floorCount"]; i++) {
      Floor curFloor = new Floor(i);
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

  //
  int get apartmentNo => this._no;
  // floors
  List<Floor> get floorList => this._floorList;
}
