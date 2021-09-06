import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:list_fleet/model/listPositions.dart';
import 'package:list_fleet/model/position.dart';

class MainMap extends StatefulWidget {
  const MainMap({Key? key}) : super(key: key);

  @override
  _MainMapState createState() => _MainMapState();

  MainMap.name();

}

class _MainMapState extends State<MainMap> {

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS

  //null safety (Toda hora essa merda)
  Position? position;
  late ListPositions listPositions;

  late CameraPosition _position;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    if (ModalRoute.of(context)!.settings.arguments is Position){
      position = ModalRoute.of(context)!.settings.arguments as Position;
      _position = CameraPosition(
          target: LatLng(position!.lat, position!.lng),
          zoom: 14.4746,
      );
    } else {
      listPositions = ModalRoute.of(context)!.settings.arguments as ListPositions;

      _position = CameraPosition(
        target: LatLng(listPositions.positions![0].lat, listPositions.positions![0].lng),
        zoom: 18.4746,
      );
    }
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _position,
        onMapCreated: _onMapCreated,
        markers: Set<Marker>.of(markers.values),
      ),
    );
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    if (position != null) {
      final marker = Marker(
        markerId: MarkerId(position!.veiculo_placa),
        position: LatLng(position!.lat, position!.lng),
      );
      markers[marker.markerId] = marker;
    } else {
      List<LatLng> latLngs = [];
      if(listPositions.positions != null){
        for (final position in listPositions.positions!) {
          LatLng latLng = LatLng(position.lat, position.lng);
          latLngs.add(latLng);
          final marker = Marker(
            markerId: MarkerId(position.veiculo_placa),
            position: latLng,
            infoWindow: InfoWindow(
              title: position.veiculo_placa,
              snippet: position.condutor_nome,
            ),
          );
          markers[marker.markerId] = marker;
        }
      }
      LatLngBounds bounds = boundsFromLatLngList(latLngs);
      controller.animateCamera(
          CameraUpdate.newLatLngBounds(bounds, 45.0),
      );
      //como deixar todos markers visíveis
    }
    setState(() {});
  }

  /*Future<void> _onMapCreated(GoogleMapController controller) async {
    LatLngBounds bounds = boundsFromLatLngList(latLngs);
    controller.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 45.0),
    );
  }*/

  LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
  }

}
