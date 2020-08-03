import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:gesture_zoom_box/gesture_zoom_box.dart';

class PDFPage extends StatefulWidget {
  final String imgPath;
  final int num;
  PDFPage(this.imgPath, this.num);

  @override
  PDFPageState createState() => PDFPageState();
}

class _PDFPageState extends State<PDFPage> {
  ImageProvider provider;
//final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());

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
            child: Container(
                child: Center(
                    child: GestureZoomBox(
      maxScale: 9.0,
      doubleTapScale: 1.0,
      duration: Duration(milliseconds: 200),
      onPressed: () => Navigator.pop(context),
      child: Image(
        image: provider,
      ),
    )))));
  }
}
