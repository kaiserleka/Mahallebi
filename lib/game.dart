import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'dart:math';
import 'getDataFromJSON.dart';
import 'objects/scenario.dart';
import 'objects/address.dart';
import 'objects/world.dart';
import 'objects/street.dart';
import 'objects/gameItem.dart';

class Game extends StatefulWidget {
  Game({Key key, int this.scenario}) : super(key: key);
  //Uygulama başlığı
  final int scenario;

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  //creating sound player
  final assetsAudioPlayer = AssetsAudioPlayer();
  //
  Address curAddress = new Address(areaType: "streetView", streetNo: 0);
  //Screen width and height
  double screenHeight;
  double screenWidth;
  //world installation
  World world;
  // a number greater than 1
  int axisLength = 5;
  //world current area objects
  List<Street> curAreaStreetList = [];
  //create game item List for scenarios
  List<GameItem> gameItemList = [];
  int gameItemListCount = 0;
  //
  bool reverseSituation = false;
  //tasks
  Scenario curScenario;
  // loading vars
  bool scenarioLoaded = false;
  //
  @override
  void initState() {
    // initState
    super.initState();
    print(">>> Oyun yükleniyor");
    loadScenario(widget.scenario);
    // create world
    world = World(axisLength);
  }

  @override
  Widget build(BuildContext context) {
    //Screen width and height
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Mahallebi",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 4.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ],
          ),
        )),
        actions: <Widget>[
          //Icon(Icons.access_alarm)
        ],
      ),
      /*drawer: Drawer(
        child: new Container(
            padding: EdgeInsets.fromLTRB(10, 25, 10, 5),
            color: Colors.green[700],
            child: SingleChildScrollView(child: Text(""))),
      ),*/
      body: Container(
        child: (scenarioLoaded == false)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Geçerli Adres Alanı
                  Expanded(flex: 1, child: displayAddressBar(curAddress)),
                  //Oyun alanı
                  SizedBox(
                    //flex: 7,
                    height: screenWidth,
                    child: Container(
                      //color: Colors.red[800],
                      child: displayArea(curAddress),
                    ),
                  ),
                  //Oyun içi panel
                  Expanded(
                    flex: 3,
                    child: displayPanel(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void loadScenario(int scenarioOrder) {
    List<String> taskList = [];
    // add tasks
    //taskList.add("Kayıp çiçeği bul");
    //update tasks;
    //taskList;
    GetDataFromJSON.getScenarioInfo(scenarioOrder)
        .then((Scenario datas) {
          curScenario = datas;
          print(">>> Senaryo Yüklendi");
          //set gameicons according to current scenario
          // setState(() {
          //gameItemList.add(GameItem("flover"));
          //});
        })
        .catchError((err) => print("Hata: " + err.toString()))
        .whenComplete(() {
          // locateGameItems
          locateGameItems();
          setState(() {
            scenarioLoaded = true;
          });
        });
  }

  void locateGameItems() {
    // locate item
    for (var i = 0; i < curScenario.taskList.length; i++) {
      // increase count for each gameitem
      gameItemListCount++;
      // find random room to locate
      int selectedStreet = 0;
      int selectedApartment = 0;
      int selectedFloor = 0;
      int selectedHouse = 0;
      // make that room's itemLocated true
      world
          .streetList[selectedStreet]
          .apartmentList[selectedApartment]
          .floorList[selectedFloor]
          .houseList[i]
          .roomList[0]
          .setItemLocated = true;
      // set that room's itemNo
      world.streetList[selectedStreet].apartmentList[selectedApartment]
          .floorList[selectedFloor].houseList[i].roomList[0].setGameItemNo = i;
    }
  }

  Widget displayArea(Address curAddress) {
    //print(">>> Adres: " + curAddress.fullAddress);
    return SingleChildScrollView(
        reverse: reverseSituation,
        scrollDirection: Axis.horizontal,
        controller: ScrollController(
            initialScrollOffset: MediaQuery.of(context).size.width / 3,
            keepScrollOffset: false),
        child: Container(
          color: Colors.blue,
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              displaySideMenu("left"),
              displayGameArea(curAddress),
              // show right side menu for game if area type is streetview
              (curAddress.areaType == "streetView")
                  ? displaySideMenu("right")
                  : SizedBox(
                      width: 0,
                    )
            ],
          ),
        ));
  }

  Widget displaySideMenu(String side) {
    List<Widget> buttonList = [];
    if (side == "left") {
      // left side menu of game
      switch (curAddress.areaType) {
        case "streetView":

          //menzilin kuzey sınırı ise gösterme
          if ((curAddress.streetNo) ~/ axisLength > 0)
            buttonList.add(displaySideMenuItem(
                "assets/gameIcons/arrow-north.png",
                "${world.streetList[curAddress.streetNo - axisLength].name}",
                curAddress.streetNo - axisLength,
                isRightSide: false));
          //menzilin batı sınırı ise gösterme
          if (curAddress.streetNo % axisLength > 0)
            buttonList.add(displaySideMenuItem(
                "assets/gameIcons/arrow-west.png",
                "${world.streetList[curAddress.streetNo - 1].name}",
                curAddress.streetNo - 1,
                isRightSide: false,
                horitantalPassing: true));

          //menzilin güney sınırı ise gösterme
          if ((curAddress.streetNo) ~/ axisLength < axisLength - 1)
            buttonList.add(displaySideMenuItem(
                "assets/gameIcons/arrow-south.png",
                "${world.streetList[curAddress.streetNo + axisLength].name}",
                curAddress.streetNo + axisLength,
                isRightSide: false));
          break;
        case "floorView":
          buttonList.add(displaySideMenuItem(
              "assets/gameIcons/door-exit.png", "Caddeye", 0));
          break;
        case "roomView":
          buttonList.add(displaySideMenuItem(
              "assets/gameIcons/door-exit.png", "Apartmana", "toApartment"));
          buttonList.add(displaySideMenuItem(
              "assets/gameIcons/door-exit.png", "Caddeye", "toStreet"));

          break;
      }
    } else {
      // right side menu of game
      switch (curAddress.areaType) {
        case "streetView":
          //menzilin kuzey sınırı ise gösterme
          if ((curAddress.streetNo) ~/ axisLength > 0)
            buttonList.add(displaySideMenuItem(
                "assets/gameIcons/arrow-north.png",
                "${world.streetList[curAddress.streetNo - axisLength].name}",
                curAddress.streetNo - axisLength,
                isRightSide: false));
          //menzilin doğu sınırı ise gösterme
          if (curAddress.streetNo % axisLength < axisLength - 1)
            buttonList.add(displaySideMenuItem(
                "assets/gameIcons/arrow-east.png",
                "${world.streetList[curAddress.streetNo + 1].name}",
                curAddress.streetNo + 1,
                isRightSide: true,
                horitantalPassing: true));
          //menzilin güney sınırı ise gösterme
          if ((curAddress.streetNo) ~/ axisLength < axisLength - 1)
            buttonList.add(displaySideMenuItem(
                "assets/gameIcons/arrow-south.png",
                "${world.streetList[curAddress.streetNo + axisLength].name}",
                curAddress.streetNo + axisLength,
                isRightSide: false));
          break;
      }
    }

    return Container(
      color: Colors.red[800],
      child: SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: buttonList,
          )),
    );
  }

  Widget displaySideMenuItem(
      String buttonIconImage, buttonName, var targetValue,
      {bool horitantalPassing = false, bool isRightSide}) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(5),
        color: Colors.red[50],
        child: Column(children: [
          Image.asset(
            buttonIconImage,
            width: screenWidth / 6,
          ),
          SizedBox(
            height: screenWidth / 75,
          ),
          AutoSizeText(
            buttonName,
            textAlign: TextAlign.center,
            minFontSize: 8,
            maxLines: 2,
          ),
        ]),
        onPressed: () {
          switch (curAddress.areaType) {
            case "streetView":
              setState(() {
                curAddress.setStreetNo = targetValue;
              });
              if (horitantalPassing == true)
                setState(() {
                  //reverseSituation = true;
                });
              else
                setState(() {
                  //reverseSituation = false;
                });

              break;
            case "floorView":
              setState(() {
                curAddress.setAreaType = "streetView";
              });
              break;
            case "roomView":
              setState(() {
                (targetValue == "toApartment")
                    ? curAddress.setAreaType = "floorView"
                    : curAddress.setAreaType = "streetView";
              });
              break;
          }
        },
      ),
    );
  }

  Widget displayGameArea(Address curAddress) {
    List units;
    switch (curAddress.areaType) {
      //street view
      case "streetView":
        units = world.streetList[curAddress.streetNo].apartmentList;
        break;
      case "floorView":
        units = world.streetList[curAddress.streetNo]
            .apartmentList[curAddress.apartmentNo].floorList[0].houseList;
        break;
      case "roomView":
        // print(":: "+world.streetList[curAddress.streetNo]
        //     .apartmentList[curAddress.apartmentNo].floorList[0].houseList.length.toString());
        //print("//-> " + curAddress.houseNo.toString());
        units = world
            .streetList[curAddress.streetNo]
            .apartmentList[curAddress.apartmentNo]
            .floorList[0]
            .houseList[curAddress.houseNo]
            .roomList;
        break;
      default:
    }
    return Container(
        color: curAddress.groundColor,
        child: Row(
          children: <Widget>[
            displayWestOfArea(curAddress.areaType, screenWidth),
            displayCenterOfArea(curAddress.areaType, screenWidth, units),
            displayEastOfArea(curAddress.areaType, screenWidth),
          ],
        ));
    /*List items = [];
    List<Widget> areaItems = [];
    
    switch (curAddress.areaType) {
           //floor view
      case "floorView":
        areaItems.add(Image.asset(world
            .streetList[curAddress.streetNo]
            .apartmentList[curAddress.apartmentNo]
            .floorList[curAddress.floorNo]
            .unitImage));
        items = world
            .streetList[curAddress.streetNo]
            .apartmentList[curAddress.apartmentNo]
            .floorList[curAddress.floorNo]
            .houseList;
        break;
      
    }*/
  }

  Widget displayAddressBar(Address curAddress) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      alignment: Alignment.center,
      color: Colors.orange[50],
      child: AutoSizeText(
        curAddress.fullAddress,
        maxLines: 1,
        minFontSize: 8,
        style: TextStyle(
          color: Colors.red[800],
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget displayPanel() {
    List<Widget> gameItemsWidgetList = [];
    for (var i = 0; i < curScenario.taskList.length; i++) {
      Color curColor = (curScenario.taskList[i].isCompleted == false)
          ? Colors.black26
          : Colors.indigo[700];
      var curIcon = Icon(
        curScenario.taskList[i].gameItemIconData,
        color: curColor,
        size: 36,
      );
      gameItemsWidgetList.add(curIcon);
    }
    return Container(
        color: Colors.red[800],
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.red),
                    color: Colors.red[50]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    AutoSizeText(
                      "Eşyalar",
                      style: TextStyle(
                          color: Colors.red[900], fontWeight: FontWeight.bold),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: gameItemsWidgetList),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
                flex: 1,
                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.red),
                        color: Colors.red[900]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.list,
                          color: Colors.green[200],
                          size: 32,
                        ),
                        AutoSizeText(
                          "Görev",
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.red,
                            height: screenWidth,
                            // alignment: Alignment.center,
                            child: showTasks(),
                          );
                        });
                  },
                )),
            SizedBox(
              width: 5,
            ),
            Expanded(
                flex: 1,
                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.red),
                        color: Colors.red[900]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.lightbulb_outline,
                          color: Colors.yellow[200],
                          size: 32,
                        ),
                        AutoSizeText(
                          "İpucu",
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    //temp
                    showHint();
                  },
                )),
            SizedBox(
              width: 5,
            ),
            Expanded(
                flex: 1,
                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.red),
                      color: Colors.red[900],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/panelIcons/map.png"),
                        AutoSizeText(
                          "Harita",
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.red,
                            height: screenWidth,
                            alignment: Alignment.center,
                            child: showMap(),
                          );
                        });
                  },
                )),
          ],
        ));
  }

  Widget displayWestOfArea(areaType, screenWidth) {
    // West
    List<Widget> items = [];
    Widget curWidget;
    switch (areaType) {
      case "streetView":
        curWidget = Flexible(
            child: Image(
          image: AssetImage("assets/streetItems/westofstreet.png"),
          /*child: Container(
          color: Colors.black,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                  flex: 4,
                  child: Container(
                    color: Colors.green,
                    child: Image(
                      image: AssetImage("assets/streetItems/westofunits.png"),
                      fit: BoxFit.contain,
                      //color: Colors.grey,
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.pink,
                    child: Image(
                      image: AssetImage("assets/streetItems/westofway.png"),
                      //color: Colors.red,
                    ),
                  ))
            ],
          ),*/
        ));

        break;
      case "floorView":
        curWidget = Expanded(
          flex: 1,
          child: Container(
            //color: Colors.brown,
            child: Image(
                image: AssetImage("assets/floors/floor0.png"),
                fit: BoxFit.contain
                //color: Colors.grey,
                ),
          ),
        );
        break;
      case "roomView":
        curWidget = Expanded(
          flex: 1,
          child: Container(
            child: Image(
                image: AssetImage("assets/rooms/room0.png"), fit: BoxFit.contain
                //color: Colors.grey,
                ),
          ),
        );
        break;
    }
    items.add(curWidget);
    return Container(
        //color: Colors.purple,
        child: Column(
      children: items,
    ));
  }

  Widget displayCenterOfArea(areaType, screenWidth, units) {
    List<Widget> items = [];
    List<Widget> touchableItems = [];
    Widget curWidget;
    double widthOfCenterArea = 0;
    // Middle
    for (var i = 0; i < units.length; i++) {
      Widget curWidget;
      //make them touchable
      curWidget = GestureDetector(
        child: Image.asset(
          units[i].unitImageAddress,
          height: screenWidth * (units[i].unitImageHeight),
        ),
        onTap: () {
          //make them able to enter
          passToInside(areaType, i);
        },
      );
      touchableItems.add(curWidget);
      // if area is street, put a space between apartments
      if (curAddress.areaType == "streetView")
        touchableItems.add(SizedBox(
          width: screenWidth * 0.2,
        ));
      //calculate length of way (middle part)
      if (curAddress.areaType == "streetView") {
        //if area is strett, add also space width
        widthOfCenterArea +=
            screenWidth * units[i].unitImageWidth + screenWidth * 0.2;
      } else {
        widthOfCenterArea += screenWidth * units[i].unitImageWidth;
      }
    }

    switch (areaType) {
      case "streetView":
        curWidget = Container(
            //color: Colors.teal,
            height: screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    flex: 4,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: touchableItems,
                    )),
                Expanded(
                  flex: 1,
                  child: Container(
                      //alignment: Alignment.,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              alignment: Alignment.centerLeft,
                              image: AssetImage(
                                  "assets/streetItems/middleofway.png"),
                              repeat: ImageRepeat.repeatX,
                              fit: BoxFit.contain)),
                      child: SizedBox(
                        width: widthOfCenterArea,
                      )),
                )
              ],
            ));

        break;
      case "floorView":
        curWidget = Flexible(
          flex: 1,
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: Container(
                      //color: Colors.pink,
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: touchableItems,
                  ))),
              Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 0,
                  ))
            ],
          ),
        );
        break;
      case "roomView":
        var curRoom = world
            .streetList[curAddress.streetNo]
            .apartmentList[curAddress.apartmentNo]
            .floorList[curAddress.floorNo]
            .houseList[curAddress.houseNo]
            .roomList[0];

        bool hasGameItem = curRoom.itemLocated;
        curWidget = Flexible(
          flex: 1,
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 7,
                  child: Container(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: touchableItems,
                  ))),
              Expanded(
                  flex: 3,
                  child: (hasGameItem == false)
                      ? SizedBox(
                          height: 0,
                        )
                      : GestureDetector(
                          child: Container(
                            //alignment: Alignment.topRight,
                            margin: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white12,
                                shape: BoxShape.rectangle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.yellow, blurRadius: 30),
                                ]
                                //gradient: Gradient(colors: [Colors.teal,Colors.teal],stops: [0.5,0.2]),
                                //backgroundBlendMode: BlendMode.softLight
                                ),
                            child: Icon(
                              curScenario.taskList[curRoom.gameItemNo]
                                  .gameItemIconData,
                              color: Colors.indigo[700],
                              size: screenWidth*0.15,
                            ),
                          ),
                          onTap: () {
                            // play sound
                            assetsAudioPlayer.open(AssetsAudio(
                              asset: "itemfound.mp3",
                              folder: "assets/audios/",
                            ));
                            assetsAudioPlayer.play();
                            //if found a game item

                            // remove from located room
                            setState(() {
                              curRoom.setItemLocated = false;
                              gameItemListCount--;
                            });
                            if (gameItemListCount <= 0)
                              showTasksCompletedWidget();
                            // change item status as "found"
                            curScenario.taskList[curRoom.gameItemNo]
                                .setAsCompleted();
                          },
                        ))
            ],
          ),
        );
        break;
    }
    items.add(curWidget);
    return Column(
      children: items,
    );
  }

  Widget displayEastOfArea(areaType, screenWidth) {
    //East
    List<Widget> items = [];
    switch (areaType) {
      case "streetView":
        var curWidget = Flexible(
          // flex: 1,
          child: Image(
            image: AssetImage("assets/streetItems/eastofstreet.png"),
            //alignment: Alignment.bottomCenter,

            width: screenWidth,
            //fit: BoxFit,
            //width: 226,
          ),
        );
        items.add(curWidget);
        break;
      case "floorView":
        break;
      case "roomView":
        break;
    }

    return Container(
      // width: (items.length > 0) ? (screenWidth / 2) : 0,
      child: Column(
        children: items,
      ),
    );
  }

  void passToInside(areaType, selectedUnitNo) {
    // play sound
    assetsAudioPlayer.open(AssetsAudio(
      asset: "unlocked.mp3",
      folder: "assets/audios/",
    ));
    assetsAudioPlayer.play();
    //
    String prevArea = areaType;
    //String nextArea;
    switch (prevArea) {
      //from street to apartment
      case "streetView":
        // play sound
        assetsAudioPlayer.open(AssetsAudio(
          asset: "unlocked.mp3",
          folder: "assets/audios/",
        ));
        assetsAudioPlayer.play();
        //print("passing to floor of apartment from street");
        setState(() {
          curAddress.setApartmentNo = selectedUnitNo;
          curAddress.setCurFloor = 0;
          curAddress.setAreaType = "floorView";
        });
        break;
      case "floorView":
        // play sound
        assetsAudioPlayer.open(AssetsAudio(
          asset: "locked.mp3",
          folder: "assets/audios/",
        ));
        assetsAudioPlayer.play();
        //print("passing to room of house from floor of apartment");
        setState(() {
          curAddress.setAreaType = "roomView";
          curAddress.setCurHouse = selectedUnitNo;
        });
        break;
      default:
    }
  }

  Widget showMap() {
    List<Widget> streetIcons = [];
    for (var i = 0; i < pow(axisLength, 2); i++) {
      streetIcons.add(mapStreetIcon(i));
    }
    //create rows
    List<Widget> mapRows = [];
    //add title to Map widget
    mapRows.add(Text(
      "Mahallebi Haritası\n\n",
      style: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red[900]),
    ));
    for (var i = 0; i < axisLength; i++) {
      List<Widget> rowIcons = [];
      for (var j = 0; j < axisLength; j++) {
        rowIcons.add(streetIcons[i * axisLength + j]);
      }
      mapRows.add(Container(
          //color: Colors.yellow,
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: rowIcons,
      )));
    }

    return Container(
        decoration: BoxDecoration(
            color: Colors.red[50], borderRadius: BorderRadius.circular(10)),
        //
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: mapRows,
        ));
  }

  Widget mapStreetIcon(streetNo) {
    return GestureDetector(
      child: SizedBox(
        height: screenWidth / (axisLength * 2),
        width: screenWidth / (axisLength * 1.25),
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          color: Colors.grey,
          child: AutoSizeText(
            world.streetList[streetNo].name,
            minFontSize: 8,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onTap: () {
        setState(() {
          curAddress.setStreetNo = streetNo;
        });
        Navigator.pop(context);
      },
    );
  }

  Widget showTasks() {
    List<Widget> taskListWidgets = [];
    //add title widget
    taskListWidgets.add(Text(
      "Görevler\n",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        shadows: <Shadow>[
          Shadow(
            offset: Offset(1.0, 1.0),
            blurRadius: 3.0,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ],
      ),
    ));
    for (var i = 0; i < curScenario.taskList.length; i++) {
      taskListWidgets.add(Container(
          padding: EdgeInsets.all(10),
          child: showTaskItem(curScenario.taskList[i].detail,
              curScenario.taskList[i].isCompleted)));
    }
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: taskListWidgets,
          )),
    );
  }

  Widget showTaskItem(taskDetail, isCompleted) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Icon(
            (isCompleted == true) ? Icons.check : Icons.check_box_outline_blank,
            color: Colors.red[800],
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            taskDetail,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ]));
  }

  Widget showHint() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "İpucu",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            titlePadding: EdgeInsets.all(25),
            backgroundColor: Colors.red[700],
            contentPadding: EdgeInsets.all(0),
            content: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              color: Colors.white,
              height: screenHeight * 0.3,
              width: screenWidth * 0.95,
              child: Text(
                ":(", //curAddress.fullAddress,
                maxLines: 2,
                style: TextStyle(fontSize: 14),
              ),
            ),
          );
        });
  }

  Widget showTasksCompletedWidget() {
    showDialog(
        context: context,
        builder: (context) {
          List<Widget> taskListWidgets = [];
          for (var i = 0; i < curScenario.taskList.length; i++) {
            taskListWidgets.add(Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.check,
                    color: Colors.red[800],
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    curScenario.taskList[i].detail,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ]));
          }
          return AlertDialog(
            title: Text(
              "Görevler Tamamlandı",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            titlePadding: EdgeInsets.all(25),
            backgroundColor: Colors.red[700],
            contentPadding: EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                height: screenHeight * 0.8,
                width: screenWidth * 0.95,
                child: Column(
                  children: taskListWidgets,
                ),
              ),
            ),
            actions: <Widget>[
              RaisedButton(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: Text(
                  "Serbest Dolaş",
                  style: TextStyle(color: Colors.red[900]),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              RaisedButton(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: Text(
                  "Oyunu Bitir",
                  style: TextStyle(color: Colors.red[900]),
                ),
                onPressed:(){
                  Navigator.pushNamed(context, '/');
                }
              )
            ],
          );
        });
  }
}
