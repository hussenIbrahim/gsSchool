import 'dart:io';
import 'dart:typed_data';
import 'package:extended_image/extended_image.dart' as extended;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/main.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/widget/alerts/faliedAlert.dart';
import 'package:testgsschoolst/widget/alerts/loading_alert.dart';
import 'package:image_editor/image_editor.dart' as editor;
import 'package:path_provider/path_provider.dart';

class SimpleCropRoute extends StatefulWidget {
  final File file;
  final bool isAttachmen;
  const SimpleCropRoute(
      {Key key, @required this.file, @required this.isAttachmen})
      : super(key: key);
  @override
  _SimpleCropRouteState createState() => _SimpleCropRouteState();
}

class _SimpleCropRouteState extends State<SimpleCropRoute> {
  final GlobalKey<extended.ExtendedImageEditorState> editorKey =
      GlobalKey<extended.ExtendedImageEditorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.edit.trans()),
      ),
      body: extended.ExtendedImage.file(
        widget.file,
        fit: BoxFit.contain,
        mode: extended.ExtendedImageMode.editor,
        enableLoadState: true,
        cacheRawData: true,
        extendedImageEditorKey: editorKey,
        initEditorConfigHandler: (extended.ExtendedImageState state) {
          return extended.EditorConfig(
            maxScale: 8.0,
            cropRectPadding: const EdgeInsets.all(20.0),
            hitTestSize: 20.0,
            initCropRectType: extended.InitCropRectType.imageRect,
            cropAspectRatio: extended.CropAspectRatios.ratio1_1,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.crop),
          onPressed: () {
            cropImage();
          }),
    );
  }

  Future<void> cropImage() async {
    try {
      showLoadingProgressAlert();
      final Uint8List fileData = Uint8List.fromList(
          await cropImageDataWithNativeLibrary(state: editorKey.currentState));

      final tempDir = await getTemporaryDirectory();
      myPrint("tempDir.path ${tempDir.path}");
      final file = await new File('${tempDir.path}/${DateTime.now()}image.jpg')
          .create(recursive: true);
      file.writeAsBytesSync(fileData);
      Navigator.pop(navigatorKey.currentContext);

      Navigator.pop(navigatorKey.currentContext);

      personalInfoNotifier.changeFileImage(file);
    } catch (w) {
      myPrint("error in crop image");
      Navigator.pop(navigatorKey.currentContext);
      failedAlert(error: "Failed in crop image");
    }
  }
}

Future<List<int>> cropImageDataWithNativeLibrary(
    {extended.ExtendedImageEditorState state}) async {
  print('native library start cropping');

  final Rect cropRect = state.getCropRect();
  final extended.EditActionDetails action = state.editAction;

  final int rotateAngle = action.rotateAngle.toInt();
  final bool flipHorizontal = action.flipY;
  final bool flipVertical = action.flipX;
  final Uint8List img = state.rawImageData;

  final editor.ImageEditorOption option = editor.ImageEditorOption();

  if (action.needCrop) {
    option.addOption(editor.ClipOption.fromRect(cropRect));
  }

  if (action.needFlip) {
    option.addOption(
        editor.FlipOption(horizontal: flipHorizontal, vertical: flipVertical));
  }

  if (action.hasRotateAngle) {
    option.addOption(editor.RotateOption(rotateAngle));
  }

  final DateTime start = DateTime.now();
  final Uint8List result = await editor.ImageEditor.editImage(
    image: img,
    imageEditorOption: option,
  );

  print('${DateTime.now().difference(start)} ：total time');
  return result;
}
