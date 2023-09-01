import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../Role_pharmacy/shopprofile.dart';
import '../firebase_options.dart';
import '../model/createmarker.dart';
import '../widgets/Service.dart';

class MapsPage extends StatefulWidget {
  MapsPage({super.key, required this.lat ,required this.long,required this.opennow});

  @override
  _MapsPageState createState() => _MapsPageState();
  
  String lat;
  String long;
  bool opennow;


}


class _MapsPageState extends State<MapsPage> {
  late Position userLocation;
  late GoogleMapController mapController;
  List<Marker> _markers = [];
  List<Marker> shopMarkers = [];
  List<shopmarkermodel> shopdata = [];
  Marker? nearestMarker;
  double? nearestDistance;

  
  // ฟังก์ชันสำหรับคำนวณ Marker ที่ใกล้ที่สุด
  void findNearestMarker({bool opennow = false}) {
    double minDistance = double.infinity;
    Marker? nearest;
    
    for (Marker marker in shopMarkers) {
      double distance = Geolocator.distanceBetween(
        userLocation.latitude,
        userLocation.longitude,
        marker.position.latitude,
        marker.position.longitude,
      );

      if (distance < minDistance) {
        minDistance = distance;
        nearest = marker;
      }
    }
    if(opennow ){
      nearestMarker = nearest;
      nearestDistance = minDistance;
      print("ทดสอบบบ =  ${nearestMarker}");
      List<shopmarkermodel> nearshop = shopdata.where((element) => MarkerId(element.id) == nearestMarker?.markerId).toList();
      if(nearshop.length > 0){
        openprofileshop(address: nearshop[0].address, licensepharmacy: nearshop[0].licensepharmacy, pharmacyname: nearshop[0].pharmacyname, timeclosing: nearshop[0].timeclosing, timeopening: nearshop[0].timeopening, title: nearshop[0].title, url: nearshop[0].url);
        print("URLINOPEN ===== ${nearshop[0].url}");
      }
      print('ทดสอบ 2  ====  $nearshop');
    }
    else{
    setState(() {
      nearestMarker = nearest;
      nearestDistance = minDistance;
      
    });
    }

    if (nearest != null) {
      mapController.animateCamera(CameraUpdate.newLatLng(nearest.position));
    }
  }






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

void openprofileshop({required String address, required String pharmacyname, required String title, required String timeclosing, required String 
timeopening, required String? url, required String licensepharmacy}){
  Navigator.push(context, MaterialPageRoute(builder: (context) => Shopprofile(Addressshop: address, Pharmacyname: pharmacyname, Shopname: title,
         Timeclosing: timeclosing, Timeopening: timeopening, Url: url, Licensepharmacy: licensepharmacy)));
          print("URL ====== $url");
}

void createMarker(double lat, double lng, String id, String title, String address, String pharmacyname, String timeopening, String timeclosing, String? url, String licensepharmacy) {
  Marker newMarker = Marker(
    markerId: MarkerId(id),
    infoWindow: InfoWindow(
      title: title,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Shopprofile(Addressshop: address, Pharmacyname: pharmacyname, Shopname: title,
         Timeclosing: timeclosing, Timeopening: timeopening, Url: url, Licensepharmacy: licensepharmacy)));
        print("Testmapp");
      },
    ),
    position: LatLng(lat, lng),
  );

  setState(() {
    shopMarkers.add(newMarker);
    shopdata.add(shopmarkermodel(lat: lat, lng: lng, address: address, id: id, pharmacyname: pharmacyname, timeclosing: timeclosing, timeopening: timeopening, title: title, licensepharmacy: licensepharmacy,url: url));
  });

   // Print ค่าเพื่อตรวจสอบว่าฟังก์ชันถูกเรียก
  print('createMarker called with: lat=$lat, lng=$lng, id=$id, title=$title');
}

 void _onMapCreated(GoogleMapController controller) {
  mapController = controller;
  if(widget.opennow){
    Timer(Duration(seconds: 3), () {findNearestMarker(opennow: true);});
    
  }
  // _addMarker(userLocation.latitude, userLocation.longitude, 'ตำแหน่งของคุณ', '', (marker) {
  //   _onMarkerTapped(marker);
  // });

  DatabaseReference starCountRef = FirebaseDatabase.instance.ref('Pharmacy');
  starCountRef.onValue.listen((DatabaseEvent event) {
  if (event.snapshot.exists) {
    Map<dynamic, dynamic> data = (event.snapshot.value ?? {}) as Map<dynamic, dynamic>;
    data.forEach((key, value) async {
      String markerId = value['Email'];
      String markerTitle = value['Nameshop'];
      double markerLatitude = value['latitude'];
      double markerLongitude = value['longitude'];
      String markerAddressshop  = value['Addressshop'];
      String markerPharmacyname  = value['Name'];
      String markerTimeopening  = value['Timeopening'];
      String markerTimeclosing  = value['Timeclosing'];
      String markerLicensepharmacy = value['Licensepharmacy'];
      ProviderSer profileService =
        Provider.of<ProviderSer>(context, listen: false);
        String? url = await profileService.getProfileshopImageUrl(markerId);

      createMarker(markerLatitude, markerLongitude, markerId, markerTitle, markerAddressshop, markerPharmacyname, markerTimeopening, markerTimeclosing,url,markerLicensepharmacy);

      // Print ค่าที่ถูกเพิ่มลงใน shopMarkers
        print('Added marker with id=$markerId, title=$markerTitle, lat=$markerLatitude, lng=$markerLongitude');
      });
    }
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



  @override
  Widget build(BuildContext context) {

    //  List<Marker> marker = [Marker(markerId: MarkerId("12345"),infoWindow:InfoWindow(title: "ซอยบ้าน",onTap: () {
    //               Navigator.push(context, MaterialPageRoute(builder: (context) => Shopprofile(),));
    //               print("Testmapp");
    //             },) ,position: LatLng(13.852831496654964, 100.51482900312834)),
    //             Marker(markerId: MarkerId("54321"),infoWindow:InfoWindow(title: "ซอยบ้าน2",onTap: () {
    //               print("Testmapp2");
    //             },) ,position: LatLng(13.852831496654964, 100.56482900312834))];
    //==============================================================================================
  //   List<Marker> marker = [
  // Marker(
  //   markerId: MarkerId(markerId),
  //   infoWindow: InfoWindow(
  //     title: markerTitle,
  //     onTap: () {
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => const Shopprofile()));
  //       print("Testmapp");
  //     },
  //   ),
  //   position: LatLng(markerLatitude, markerLongitude),
  // )];           
  // ==============================================================================================
    return Scaffold(
      appBar: AppBar(
        title: Text('ค้นหาร้านขายยาใกล้คุณ'),
      ),
      body: FutureBuilder(
        future: _getLocation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GoogleMap(
              markers: shopMarkers.toSet(),
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: findNearestMarker,
            label: Text("ค้นหา Marker ที่ใกล้ที่สุด"),
            icon: Icon(Icons.place),
          ),
          if (nearestMarker != null && nearestDistance != null)
            Text("Marker ที่ใกล้ที่สุด: ${nearestMarker!.infoWindow.title}"),
          if (nearestMarker != null && nearestDistance != null)
            Text("ระยะทาง: ${nearestDistance!.toStringAsFixed(2)} เมตร"),
        ],
      ),
    );
  }
}


void initfirebase() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    
  }