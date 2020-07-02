import 'dart:io';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';
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
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        right: 20,
        left:30
      ),
      child: Container(
          decoration: null,
          child: ZoomableWidget(
            zoomSteps: 3,
            minScale: 1.0,
            initialScale: 1.4,
            panLimit: 0.8,
            maxScale: 3.0,
            child: Image(image: provider),
          )),
    );
  }
}
