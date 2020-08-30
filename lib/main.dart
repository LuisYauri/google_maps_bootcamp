import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/map_bootcamp.dart';
import 'provider/direction_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => DirectionProvider(),
      child: MaterialApp(
        home: MapBootcamp(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
