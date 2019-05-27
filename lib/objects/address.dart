import 'package:flutter/material.dart';
import '../infoCenter.dart';

class Address {
  //Street _street;
  //Apartment _apartment;
  int _curStreetNo;

  int _curApartmentNo;
  int _curFloor;
  int _curHouse;
  int _curRoom;
  Color _groundColor;
  String _areaType;
  Address({String areaType, int streetNo}) {
    this._areaType = areaType;
    this._curStreetNo = streetNo;
  }
  //Position
  String get areaType {
    return this._areaType;
  }

  set setAreaType(reqData) {
    this._areaType = reqData;
  }

  // ground
  //get groundColor => this._groundColor;
  get groundColor {
    if (this._areaType == "streetView")
      return Colors.green[800];
    else if (this._areaType == "floorView")
      return Colors.green[600];
    else if (this._areaType == "roomView") return Colors.brown[400];
  }

  set setGroundColor(reqData) {
    this._groundColor = reqData;
  }

  // Street
  int get streetNo {
    return this._curStreetNo;
  }

  /*String get streetText {
    if (this._curStreetNo < InfoCenter.streetTypeList.length)
      return InfoCenter.streetTypeList[this._curStreetNo];
    else
      return "${this._curStreetNo}. Cadde";
  }*/

  set setStreetNo(requestedData) {
    this._curStreetNo = requestedData;
  }

  // Apartment
  int get apartmentNo => this._curApartmentNo;
  /*String get apartmentText {

    return (this._curApartmentNo < InfoCenter.apartmentTypeList.length)
        ? InfoCenter.apartmentTypeList[this._curApartmentNo]["name"] +
            " Apartmanı"
        : "Apartman-$_curApartmentNo";
  }*/

  set setApartmentNo(reqData) {
    this._curApartmentNo = reqData;
  }

  // Floor
  int get floorNo => this._curFloor;
  /*String get floorText {
    if (this._curFloor > 0)
      return this._curFloor.toString() + ". Kat";
    else if (this._curFloor == 0)
      return "Giriş Katı";
    else if (this._curFloor < 0) return "Bodrum Katı";
  }*/

  set setCurFloor(reqData) {
    this._curFloor = reqData;
  }

  // House
  int get houseNo => this._curHouse;
  String get houseText {
    return "Daire " + this._curHouse.toString();
  }

  set setCurHouse(reqData) {
    this._curHouse = reqData;
  }

  //
  /*String get currentAddressText {
    //print("--> currentArea "+this._area);
    switch (this._areaType) {
      case "streetView":
        return streetText;
      case "floorView":
        return streetText + " / " + apartmentText + " / " + floorText;
      case "roomView":
        return streetText +
            " / " +
            apartmentText +
            " / " +
            floorText +
            " / " +
            houseText;
      default:
        return "err";
    }
  }*/

  /*String getItemAddressText({level: 3}) {
    switch (level) {
      case 3:
        return streetText +
            " / " +
            apartmentText +
            " / " +
            floorText +
            " / " +
            houseText;
      case 2:
        return streetText + " / " + apartmentText + " / " + floorText;
      case 1:
        return streetText + " / " + apartmentText;
      case 0:
        return streetText;
      default:
    }
  }*/
}
