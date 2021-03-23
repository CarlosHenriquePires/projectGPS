import 'dart:async';
import 'package:geolocator/geolocator.dart';
class Geolocation {
  LocationPermission _permission;
  bool _statusService;

  Future<void> getStatusService() async{
    _statusService = await Geolocator.isLocationServiceEnabled();
    if(!_statusService){
      print("Status Service: Disabled");
    }else{
      getPermission();
    }

  }

  Future<void>getPermission() async{
    _permission = await Geolocator.checkPermission();
    if(_permission == LocationPermission.deniedForever || _permission == LocationPermission.denied){
      _permission = await Geolocator.requestPermission();
      getPermission();
    }else{
      print(_permission.toString());
      getLocation();
    }

  }

  Future<Position> getLocation() async{
    Position position;
    try{
        position = await Geolocator.getCurrentPosition();
        return position;
      }catch (e){
          print(e);
        return position;
    }
  }
}