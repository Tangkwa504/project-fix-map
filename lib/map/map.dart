import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late Position userLocation;
  late GoogleMapController mapController;
  List<Marker> _markers = [];


void _addMarker(double lat, double lng, String title, String snippet, void Function(Marker) onTap) {
  setState(() {
    _markers.add(
      Marker(
        markerId: MarkerId(_markers.length.toString()),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: title, snippet: snippet),
        onTap: () => onTap(Marker(
          markerId: MarkerId(_markers.length.toString()),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(title: title, snippet: snippet),
        )),
      ),
    );
  });
}
void _onMarkerTapped(Marker marker) {
  showModalBottomSheet(
    context: context,
    builder: (builder) {
      return Container(
        height: 200.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(marker.infoWindow.title!),
            ElevatedButton(
              onPressed: () {
                // ดำเนินการเมื่อกดปุ่ม
              },
              child: Text('ดูรายละเอียด'),
            )
          ],
        ),
      );
    },
  );
}
 void _onMapCreated(GoogleMapController controller) {
  mapController = controller;
  _addMarker(userLocation.latitude, userLocation.longitude, 'ตำแหน่งของคุณ', '', (marker) {
    _onMarkerTapped(marker);
  });
}

  Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    userLocation = await Geolocator.getCurrentPosition();
    return userLocation;
  }


  List<Marker> marker = [Marker(markerId: MarkerId("12345"),infoWindow:InfoWindow(title: "ซอยบ้าน",onTap: () {
                  print("Testmapp");
                },) ,position: LatLng(13.852831496654964, 100.51482900312834)),
                Marker(markerId: MarkerId("54321"),infoWindow:InfoWindow(title: "ซอยบ้าน2",onTap: () {
                  print("Testmapp2");
                },) ,position: LatLng(13.852831496654964, 100.56482900312834))];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ค้นหาร้านขายยาใกล้คุณ'),
      ),
      body: FutureBuilder(
        future: _getLocation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GoogleMap(
              markers: marker.toSet(),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                  target: LatLng(userLocation.latitude, userLocation.longitude),
                  zoom: 15),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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