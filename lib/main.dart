import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPS',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'GPS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _timestamp = "NoData";
  String _latitude = "NoData";
  String _longitude = "NoData";
  String _altitude = "NoData";

  Future<void> getLocation() async {
    // 権限を取得
    LocationPermission permission = await Geolocator.requestPermission();
    // 権限がない場合は戻る
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }
    // 位置情報を取得
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      // 日時
      _timestamp = "Timestamp: ${position.timestamp.toString()}";
      // 北緯がプラス。南緯がマイナス
      _latitude = "Latitude: ${position.latitude.toStringAsFixed(2)}";
      // 東経がプラス、西経がマイナス
      _longitude = "Longitude: ${position.longitude.toStringAsFixed(2)}";
      // 高度
      _altitude = "Altitude: ${position.altitude.toStringAsFixed(2)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_timestamp, style: Theme.of(context).textTheme.headlineMedium),
            Text(_latitude, style: Theme.of(context).textTheme.headlineMedium),
            Text(_longitude, style: Theme.of(context).textTheme.headlineMedium),
            Text(_altitude, style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: getLocation, child: const Icon(Icons.location_on)),
    );
  }
} //
