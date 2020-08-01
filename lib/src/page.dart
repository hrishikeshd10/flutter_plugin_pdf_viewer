import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:zoom_widget/zoom_widget.dart';

class PDFPage extends StatefulWidget {
  final String imgPath;
  final int num;
  PDFPage(this.imgPath, this.num);

  @override
  _PDFPageState createState() => _PDFPageState();
}

class _PDFPageState extends State<PDFPage> {
  ImageProvider provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _repaint();
  }

  @override
  void didUpdateWidget(PDFPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imgPath != widget.imgPath) {
      _repaint();
    }
  }

  _repaint() {
    provider = FileImage(File(widget.imgPath));
    final resolver = provider.resolve(createLocalImageConfiguration(context));
    resolver.addListener(ImageStreamListener((imgInfo, alreadyPainted) {
      if (!alreadyPainted) setState(() {});
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Zoom(
          initZoom: 0.048,
          backgroundColor: Colors.white,
          enableScroll: true,
          doubleTapZoom: true,
          width: 1100,
          height: 1800,
          scrollWeight: 1.0,
          centerOnScale: true,
          zoomSensibility: 3.0,
          onPositionUpdate: (Offset position) {
            print(position);
          },
          onScaleUpdate: (double scale, double zoom) {
            print("$scale  $zoom");
          },
          child: Center(
              child: Image(
            image: provider,
          ))),
    ));
  }
}
