import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late Position userLocation;
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  Future<Position> _getLocation() async{
    try {
      userLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      var _userLocation = null;
      userLocation = _userLocation;
    }
    return userLocation;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text('ค้นหาร้านยาใกล้คุณ'),
      ),
      body: FutureBuilder(
        future: _getLocation(),
         builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return GoogleMap(
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(userLocation.latitude, userLocation.longitude),
                zoom: 15),
              );
          }else{
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
         },
      ),
    );
  }
}