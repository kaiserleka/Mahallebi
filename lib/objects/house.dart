import 'room.dart';

class House {
  int _no;
  //String _image;
  List<Room> _roomList = [];
  //
  House(no) {
    this._no = no;
    for (var i = 0; i < 2; i++) {
      Room curRoom = Room();
      _roomList.add(curRoom);
    }
  }
  String get unitImageAddress {
    return "assets/houses/house0.png";
  }
  double get unitImageHeight => 0.75;
  double get unitImageWidth => 0.75;
  //room list
  List<Room> get roomList => this._roomList;
}
