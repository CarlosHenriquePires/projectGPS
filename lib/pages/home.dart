import 'package:cloudwalktest3/services/geolocation.dart';
import 'package:cloudwalktest3/services/googleMaps.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    // TODO: implement initState
    Geolocation().getStatusService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: mediaQuery.size.height * 0.8,
              width: mediaQuery.size.width,
              child: GoogleMaps() ,
            )
          ],
        ),
      ),
    );
  }
}
