import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:google_maps_webservice/directions.dart';

class DirectionProvider extends ChangeNotifier {
  GoogleMapsDirections directionsApi = GoogleMapsDirections(
    apiKey: 'AIzaSyAnxh2W7QTr2wuKZ9dGOxYD8bHx0pgFAfM',
  );

  Set<maps.Polyline> _route = Set();

  Set<maps.Polyline> get currentRoute => _route;

  findDirections(maps.LatLng from, maps.LatLng to) async {
    var origin = Location(from.latitude, from.longitude);
    var destination = Location(to.latitude, to.longitude);

    var result =
        await directionsApi.directionsWithLocation(origin, destination);

    if (result.isOkay) {
      var route = result.routes[0];
      var leg = route.legs[0];

      Set<maps.Polyline> newRoute = Set();

      List<maps.LatLng> points = [];
      leg.steps.forEach((step) {
        print('------');
        print('${step.travelMode}');
        print('${step.startLocation.lat} - ${step.startLocation.lng}');
        print('${step.endLocation.lat} - ${step.endLocation.lng}');
        print('------');
        points.add(maps.LatLng(step.startLocation.lat, step.startLocation.lng));
        points.add(maps.LatLng(step.endLocation.lat, step.endLocation.lng));
      });
      var line = maps.Polyline(
        points: points,
        polylineId: maps.PolylineId("Mejor ruta"),
        color: Color(0xFF1152FD),
        width: 4,
      );
      newRoute.add(line);
      _route = newRoute;
      notifyListeners();
    }
  }
}
