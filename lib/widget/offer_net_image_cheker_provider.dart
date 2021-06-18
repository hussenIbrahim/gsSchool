import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

ImageProvider offerNetImageCheckerProvider(
    {@required String linkImage,
    @required String tempImage,
    @required BoxFit boxFit,
    double height = 150,
    double width = double.infinity,
    @required String errorImage,
    String additonalPath = ''}) {
  return linkImage == null || linkImage == ''
      ? AssetImage(
          tempImage,
        )
      : linkImage.contains("https")
          ? CachedNetworkImageProvider(
              linkImage,
              cacheKey: linkImage,
            )
          : AssetImage(
              tempImage,
            );
}
