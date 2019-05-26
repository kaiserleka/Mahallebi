import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'objects/scenario.dart';

class GetDataFromJSON{

  // get scenario list
  static Future<List<Scenario>> getScenarioList()async{
    List<Scenario> scenarioList=[];
    var receivedData = await http
        .get("http://www.elidakitap.com/mahallebi/scenarios.json", headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
    });
    List jsonScenarioList= jsonDecode(utf8.decode(receivedData.bodyBytes));
    
    for(var i=0;i<jsonScenarioList.length;i++){
      Scenario curScenario=Scenario.scenarioIntroEdition(jsonScenarioList[i]);
      curScenario.setOrder=i;
      scenarioList.add(curScenario);
    }
     return scenarioList;
  }
  // get selected scenario's info
  static Future<Scenario> getScenarioInfo(int scenarioOrder)async{
    
    var receivedData = await http
        .get("http://www.elidakitap.com/mahallebi/scenarios.json", headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
    });
    List jsonScenarioList= jsonDecode(utf8.decode(receivedData.bodyBytes));
    
    Scenario curScenario=Scenario.scenarioGameEdition(jsonScenarioList[scenarioOrder]);    
    curScenario.setOrder=scenarioOrder;
    return curScenario;
  }
}