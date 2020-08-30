import 'package:flutter/material.dart';
import 'package:google_maps_bootcamp/provider/direction_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapBootcamp extends StatefulWidget {
  LatLng startPoint = LatLng(-12.0521502, -76.9521389);
  LatLng endPoint = LatLng(-12.0569181, -76.971774);

  @override
  _MapBootcampState createState() => _MapBootcampState();
}

class _MapBootcampState extends State<MapBootcamp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Consumer<DirectionProvider>(
            builder: (context, api, child) {
              return GoogleMap(
                mapType: MapType.normal,
                polylines: api.currentRoute,
                initialCameraPosition: CameraPosition(
                  target: LatLng(-12.0521502, -76.9521389),
                  zoom: 14,
                ),
                markers: createMarkers(),
                onMapCreated: (controller) {
                  var api =
                      Provider.of<DirectionProvider>(context, listen: false);
                  // Usar siempre list: false dentro como parametro dentro del Provider.
                  api.findDirections(widget.startPoint, widget.endPoint);
                },
              );
            },
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width * 1,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              child: Column(
                children: <Widget>[
                  carWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  payWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  buttonWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget carWidget() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Image.asset('assets/img/car.png'),
              Text(
                'Standard',
                style: TextStyle(
                  color: Color(0xFF3E4958),
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                '\$6 - 7',
                style: TextStyle(
                  color: Color(0xFF3E4958),
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFD5DDE0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '3min',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 20,
            offset: Offset(0, 2),
          ),
        ],
      ),
    );
  }

  Widget payWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Estimated trip time',
                style: TextStyle(
                  color: Color(0xFF97ADB6),
                  fontSize: 13,
                ),
              ),
              Text(
                '24min',
                style: TextStyle(
                  color: Color(0xFF1152FD),
                  fontSize: 13,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Image.asset('assets/img/pay.png'),
              SizedBox(
                width: 20,
              ),
              Text(
                '**** 8295',
                style: TextStyle(
                  color: Color(0xFF4B545A),
                  fontSize: 15,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buttonWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
        padding: EdgeInsets.symmetric(vertical: 20),
        color: Color(0xFF1152FD),
        child: Text(
          'Book ride',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Set<Marker> createMarkers() {
    var temp = Set<Marker>();
    temp.add(
      Marker(
        markerId: MarkerId('StartPoint'),
        position: widget.startPoint,
        infoWindow: InfoWindow(
          title: 'Start Point',
        ),
        onTap: () {
          print('Click StartPoint');
        },
        draggable: false,
      ),
    );
    temp.add(
      Marker(
        markerId: MarkerId('EndPoint'),
        position: widget.endPoint,
        infoWindow: InfoWindow(
          title: 'End Point',
        ),
        onTap: () {
          print('Click EndPoint');
        },
        draggable: false,
      ),
    );
    return temp;
  }
}
