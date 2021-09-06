import 'package:flutter/material.dart';
import 'package:list_fleet/screens/listVehicles.dart';
import 'package:list_fleet/screens/mainMap.dart';

void main() {
  runApp(MainScreen());//widget
}

class MainScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.lightBlue
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => ListVehicles(),
        '/mapa': (context) => MainMap()
      },
    );
  }

}
