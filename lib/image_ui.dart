import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageUi extends StatefulWidget {
  @override
  _ImageUiState createState() => _ImageUiState();
}

class _ImageUiState extends State<ImageUi> {
  late StreamSubscription connectivitySubscription;

  late ConnectivityResult _previousResult;

  bool diolagueShow = false;

  List<String> code = [
    'https://images.pexels.com/photos/169573/pexels-photo-169573.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
    'https://images.pexels.com/photos/270348/pexels-photo-270348.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
    'https://images.pexels.com/photos/943096/pexels-photo-943096.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
  ];

  List<String> nature = [
    'https://images.pexels.com/photos/358457/pexels-photo-358457.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/235615/pexels-photo-235615.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/414144/pexels-photo-414144.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
  ];

  List<String> computer = [
    'https://images.pexels.com/photos/2115217/pexels-photo-2115217.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
    'https://images.pexels.com/photos/204611/pexels-photo-204611.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
    'https://images.pexels.com/photos/2800552/pexels-photo-2800552.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940 ',
  ];

  List<String> toShow = [
    'https://images.pexels.com/photos/2115217/pexels-photo-2115217.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
    'https://images.pexels.com/photos/204611/pexels-photo-204611.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
    'https://images.pexels.com/photos/2800552/pexels-photo-2800552.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940 ',
  ];

  Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return Future.value(true);
      }
      return false;
    } on SocketException catch (_) {
      return Future.value(false);
    }
  }

  @override
  void initState() {
    super.initState();

    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connResult) {
      if (connResult == ConnectivityResult.none) {
        diolagueShow = true;
        _showDialog();
      } else if (_previousResult == ConnectivityResult.none) {
        checkInternet().then((result) => {
              if (result == true)
                {
                  if (diolagueShow == true) {Navigator.pop(context)}
                }
            });
      }

      _previousResult = connResult;
    });
  }

  @override
  void dispose() {
    super.dispose();

    connectivitySubscription.cancel();
  }

  void createList(String kword) {
    if (kword == "code") {
      toShow = [];
      setState(() {
        for (var source in code) {
          toShow.add(source);
        }
      });
    } else if (kword == "nature") {
      toShow = [];
      setState(() {
        for (var source in nature) {
          toShow.add(source);
        }
      });
    } else if (kword == "computer") {
      toShow = [];
      setState(() {
        for (var source in computer) {
          toShow.add(source);
        }
      });
    }
  }

  Widget cards(String src) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.network(src),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Image Viewer",
          style: TextStyle(
            color: Colors.red,
            fontSize: 24.0,
            fontFamily: "Consolas",
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    onPressed: () => createList('code'),
                    child: Text(
                      "Code",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: "Verdana",
                        color: Colors.red[600],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () => createList('nature'),
                    child: Text(
                      "Nature",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: "Verdana",
                        color: Colors.red[600],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () => createList('computer'),
                    child: Text(
                      "Computers",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: "Verdana",
                        color: Colors.red[600],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                cards(toShow[0]),
                cards(toShow[1]),
                cards(toShow[2]),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text("No Internet Connection Available"),
        actions: <Widget>[
          TextButton(
              onPressed: () =>
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
              child: Text('Exit'))
        ],
      ),
    );
  }
}
