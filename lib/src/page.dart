import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_advanced_networkimage/zoomable.dart';

class PDFPage extends StatefulWidget {
  final String imgPath;
  final int num;

  PDFPage(this.imgPath, this.num);

  @override
  _PDFPageState createState() => _PDFPageState();
}

class _PDFPageState extends State<PDFPage> {
  ImageProvider provider;
  double scale = 1.5;
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
        decoration: null,
        child: ZoomableWidget(
          onTap: () {
            setState(() {
              scale = 1.5;
            });
          },
          zoomSteps: 10,
          minScale: 1.5,
          initialScale: scale,
          panLimit: 1,
          maxScale: 12.0,
          child: Image(image: provider),
        ));
  }
}
