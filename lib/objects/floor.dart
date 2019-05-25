import 'house.dart';

class Floor{
  int _no;
  //String _image;
  
  List<House> _houseList=[];
  Floor(no){
    this._no=no;
    for(var i=0;i<2;i++){
      House curHouse=new House(i);
      this._houseList.add(curHouse);
    }
  }
  int get floorNo => this._no;
  String get unitImageAddress {
    return "assets/floors/floor0.png";
  }
  get houseList => this._houseList;
}