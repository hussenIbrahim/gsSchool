import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetImageChecker extends StatelessWidget {
  const NetImageChecker(
      {Key key,
      @required this.linkImage,
      @required this.tempImage,
      @required this.boxFit,
      @required this.errorImage,
      this.additonalPath = ''})
      : super(key: key);
  final String linkImage;
  final String tempImage;
  final BoxFit boxFit;
  final String errorImage;
  final String additonalPath;

  @override
  Widget build(BuildContext context) {
    return linkImage == null || linkImage == ''
        ? Image.asset(
            tempImage,
            fit: boxFit,
          )
        : linkImage.contains("https")
            ? CachedNetworkImage(
                cacheKey: linkImage + additonalPath,
                useOldImageOnUrlChange: true,
                key: ValueKey(new Random().nextInt(100)),
                imageUrl: linkImage,
                placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                )),
                errorWidget: (context, url, error) => Image.asset(
                  "$errorImage",
                  fit: boxFit,
                ),
                fit: boxFit,
              )
            : Image.asset(
                '$tempImage',
                fit: boxFit,
              );
  }
}
