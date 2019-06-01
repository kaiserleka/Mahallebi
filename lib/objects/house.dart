import 'room.dart';

class House {
  int _no;
  //String _image;
  bool _isLocked;
  List<Room> _roomList = [];
  //
  House(no) {
    this._no = no;
    this._isLocked=true;
    // temporary 2 room per house
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
  // is locked
  bool get isLocked => this._isLocked;
  //room list
  List<Room> get roomList => this._roomList;
}
