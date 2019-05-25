import '../infoCenter.dart';
import 'apartment.dart';

class Street {
  int _no;
  String _name;
  List<Apartment> _apartmentList=[];

  Street(no){
    this._no=no;
    ///print(">> "+InfoCenter.streetTypeList[no]);
    this._name=(no<InfoCenter.streetTypeList.length) ? InfoCenter.streetTypeList[no] : "${(no).toString()}. Cadde";
    // apartmentCount (temporary this limit is constant)
    int apartmentCount=3;
    for (var i = 0; i < apartmentCount; i++) {
      Apartment curApartment = new Apartment(i);
      
      this._apartmentList.add(curApartment);
    }
  }

  // no
  int get no => this._no;
  set setStreetNo(requestedData) {
    this._no = requestedData;
  }
  // name
  String get name => this._name;
  // apartments
  List<Apartment> get apartmentList => this._apartmentList;
}
