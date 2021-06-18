import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:testgsschoolst/locator.dart';

class PDFViewerCachedFromUrl extends StatelessWidget {
  const PDFViewerCachedFromUrl(
      {Key key,
      @required this.url,
      @required this.lesson,
     })
      : super(key: key);
   final String url;
  final String lesson;
  @override
  Widget build(BuildContext context) {
    myPrint("url $url");
    return Scaffold(
      appBar: AppBar(
        title: Text('$lesson'),
      ),
      body: url.contains("http")
          ? PDF().cachedFromUrl(
              getDownloadLinkFromDrive(url),
              placeholder: (double progress) =>
                  Center(child: Text('$progress %')),
              errorWidget: (dynamic error) =>
                  Center(child: Text(error.toString())),
            )
          : PDF().fromPath(
              url,
            ),
    );
  }

  String getDownloadLinkFromDrive(String driveLink) {
    try {
      final fileId = RegExp(r'/d\/(.+?)(?:\/|#|\?|$)$')
          .stringMatch(driveLink)
          .split('/')[2];
      if (fileId == null) return driveLink;
      return driveLink;
    } catch (e) {
      myPrint("error in PDFViewerCachedFromUrl splite");
      return driveLink;
    }
  }
}
