class Room{
  int _gameItemNo;
  bool _itemLocated;
  Room(){
    this._itemLocated=false;
  }
  // unit image
  String get unitImageAddress {
    return "assets/rooms/room1.png";
  }
  double get unitImageHeight => 0.70;
  double get unitImageWidth => 0.70;
  // game item no
  int get gameItemNo => this._gameItemNo;
  set setGameItemNo(reqData){
    this._gameItemNo= reqData;
  }
  // game item located
  bool get itemLocated=>this._itemLocated;
  set setItemLocated(reqData){
    this._itemLocated=reqData;
  }
}