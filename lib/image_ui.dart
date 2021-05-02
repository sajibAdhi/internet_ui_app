import 'package:flutter/material.dart';

class ImageUi extends StatefulWidget {
  @override
  _ImageUiState createState() => _ImageUiState();
}

class _ImageUiState extends State<ImageUi> {
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

        ),
      ),
    );
  }
}
