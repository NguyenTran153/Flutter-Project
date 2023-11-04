import "package:flutter/material.dart";
import "package:flutter_project/utils/colors.dart";
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen({
    Key? key,
    required this.title,
    required this.url,
  }) : super(key: key);

  final String title;
  final String url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        leading: BackButton(
          color: secondaryColor,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: SfPdfViewer.network(url),
    );
  }
}
