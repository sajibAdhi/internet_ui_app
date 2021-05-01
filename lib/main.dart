import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "InternetUi",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.purpleAccent,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    try {
      InternetAddress.lookup("google.com").then((result) {
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          // Internet Connection Available
        } else {
          // Internet Connection Not Available
          _showDilague();
        }
      }).catchError((error) {
        // Internet Connection Not Available
        _showDilague();
      });
    } on SocketException catch (_) {
      // Internet Connection Not Available
      _showDilague();
    }
  }

  void _showDilague() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text("No Internet Connection Detected"),
        actions: <Widget>[
          TextButton(
              onPressed: () =>
                  SystemChannels.platform.invokeMethod('Systemnavigator.pop'),
              child: Text('Exit'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                "Checking your Internet Connection",
                style: TextStyle(fontSize: 20.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
