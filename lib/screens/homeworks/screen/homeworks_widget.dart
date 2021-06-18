import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/screens/books/screen/pdf_url_view.dart';
import 'package:testgsschoolst/screens/homeworks/services/homeworks_model.dart';
import 'package:testgsschoolst/widget/net_image_cheker.dart';
import 'package:testgsschoolst/widget/responsev.dart';
import 'package:testgsschoolst/widget/state_widget/view_profile_image.dart';

class HomeWorkWidget extends StatelessWidget {
  const HomeWorkWidget({
    Key key,
    @required this.model,
  }) : super(key: key);
  final HomeWorksModel model;
  @override
  Widget build(BuildContext context) {
    TeXViewRenderingEngine renderingEngine =
        const TeXViewRenderingEngine.mathjax();
    return Container(
      color: Theme.of(context).secondaryHeaderColor,
      padding: EdgeInsets.only(top: 5, left: 5, right: 5),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                          width: Responsive().setWidth(100),
                          height: Responsive().setWidth(100),
                          color: Colors.grey,
                          child: LessonImage.contains(model.subjectName)
                              ? Image.asset(
                                  "assets/images/${model.subjectName}.png",
                                  fit: BoxFit.cover,
                                )
                              : Text("${model.subjectName[0]}")),
                    ),
                    Text("${model.subjectName}",
                        style: TextStyle(
                            fontSize: Responsive().setSp(15),
                            color:
                                Theme.of(context).textTheme.subtitle2.color)),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width -
                    Responsive().setWidth(110),
                padding: const EdgeInsets.only(left: 8, right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${model.title}",
                        style: TextStyle(
                            fontSize: Responsive().setSp(17),
                            color: Colors.red)),
                    IgnorePointer(
                        ignoring: false,
                        child: model.hasEquation == true
                            ? TeXView(
                                renderingEngine: renderingEngine,
                                child: _teXViewWidget('${model.description}'))
                            : Text('${model.description}',
                                style: TextStyle(
                                    fontSize: Responsive().setSp(16),
                                    color: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .color))),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (model.hasAttachment == true)
                            SizedBox(
                              height: Responsive().setWidth(200),
                              width: (MediaQuery.of(context).size.width -
                                      Responsive().setWidth(165)) /
                                  2,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ViewProfileImage(
                                                isFile: false,
                                                title: "${model.title}",
                                                url: model.image,
                                              )));
                                },
                                child: NetImageChecker(
                                    linkImage: model.image,
                                    tempImage:
                                        "assets/images/${model.subjectName}.png",
                                    boxFit: BoxFit.fill,
                                    errorImage:
                                        "assets/images/${model.subjectName}.png"),
                              ),
                            ),
                          if (model.hasPdf == true)
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => PDFViewerCachedFromUrl(
                                              url: model.image,
                                              lesson: "${model.title}",
                                            )));
                              },
                              child: SizedBox(
                                height: Responsive().setWidth(200),
                                width: (MediaQuery.of(context).size.width -
                                        Responsive().setWidth(165)) /
                                    2,
                                child: NetImageChecker(
                                    linkImage: null,
                                    tempImage: "assets/images/pdf_cover.png",
                                    boxFit: BoxFit.fill,
                                    errorImage: "assets/images/pdf_cover.png"),
                              ),
                            )
                        ],
                      ),
                    ),
                    Text("Teacher : ${model.staffName}",
                        style: TextStyle(
                            fontSize: Responsive().setSp(16),
                            color:
                                Theme.of(context).textTheme.subtitle1.color)),
                    Text("Date : ${model.dueTo}",
                        style: TextStyle(
                            fontSize: Responsive().setSp(16),
                            color:
                                Theme.of(context).textTheme.subtitle1.color)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TeXViewWidget _teXViewWidget(String body) {
    return TeXViewColumn(
        style: TeXViewStyle(
          margin: TeXViewMargin.all(5),
          padding: TeXViewPadding.all(5),
          borderRadius: TeXViewBorderRadius.all(10),
        ),
        children: [
          TeXViewDocument(body,
              style: TeXViewStyle(margin: TeXViewMargin.only(top: 10)))
        ]);
  }
}
