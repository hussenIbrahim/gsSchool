import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:testgsschoolst/widget/responsev.dart';
import 'package:photo_view/photo_view.dart';

class ViewProfileImage extends StatelessWidget {
  final bool isFile;
  final String url;
  final String title;
  const ViewProfileImage(
      {Key key,
      @required this.title,
      @required this.isFile,
      @required this.url})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "123456",
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "$title",
              style: TextStyle(
                fontSize: Responsive().setSp(20),
              ),
            ),
          ),
          body: Center(
            child: Container(
                child: PhotoView(
              backgroundDecoration: BoxDecoration(color: Colors.grey[200]),
              loadingBuilder: (t, p) {
                return CircularProgressIndicator(        valueColor: new AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor),);
              },
              imageProvider: isFile
                  ? FileImage(File("$url"))
                  : CachedNetworkImageProvider(
                      "$url",
                      cacheKey: url,
                    ),
            )),
          ),
        ),
      ),
    );
  }
} //5.MediaQuery.Offset
