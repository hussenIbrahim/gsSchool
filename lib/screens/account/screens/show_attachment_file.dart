import 'dart:io';

import 'package:flutter/material.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/widget/responsev.dart';
import 'package:testgsschoolst/widget/state_widget/progress_widget.dart';
import 'package:photo_view/photo_view.dart';

class ShowAttAchmentFromFile extends StatefulWidget {
  final String url;

  const ShowAttAchmentFromFile({
    Key key,
    @required this.url,
  }) : super(key: key);
  @override
  _ShowAttAchmentFromFileState createState() => _ShowAttAchmentFromFileState();
}

class _ShowAttAchmentFromFileState extends State<ShowAttAchmentFromFile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(centerTitle: true, title: Text( Translate.profile.trans())),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
              child: PhotoView(
                minScale: 0.1,
                maxScale: 5.0,
                loadingBuilder: (_, o) {
                  return ProgressWidget();
                },
                errorBuilder: (_, p, o) {
                  return Center(
                      child: Column(
                    children: [
                      Text(
                       Translate.canotloadimage.trans(),
                        style: TextStyle(fontSize: Responsive().setSp(23)),
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {});
                          },
                          child: Text( Translate.retry.trans()))
                    ],
                  ));
                },
                imageProvider: FileImage(File(widget.url)),
              ),
            ),
          )),
    );
  }
}
