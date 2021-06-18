import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/screens/books/screen/pdf_url_view.dart';
import 'package:testgsschoolst/screens/books/services/books_model.dart';
import 'package:testgsschoolst/screens/books/services/books_services.dart';
import 'package:testgsschoolst/widget/net_image_cheker.dart';
import 'package:testgsschoolst/widget/responsev.dart';

class BooksWidget extends StatelessWidget {
  const BooksWidget({
    Key key,
    @required this.model,
  }) : super(key: key);
  final BooksModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, left: 5, right: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: Responsive().setWidth(100),
                  height: Responsive().setWidth(200),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                        color: Colors.grey,
                        child: NetImageChecker(
                          boxFit: BoxFit.cover,
                          linkImage: null,
                          errorImage: "assets/images/${model.subjectName}.png",
                          tempImage: "assets/images/${model.subjectName}.png",
                        )),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width -
                      Responsive().setWidth(120),
                  padding: const EdgeInsets.only(left: 8, right: 8.0),
                  height: Responsive().setWidth(200),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("${model.subjectName??''}",
                          style: TextStyle(
                              fontSize: Responsive().setSp(25),
                              color:
                                  Theme.of(context).textTheme.subtitle2.color)),
                      Text("${model.title}",
                          style: TextStyle(
                              fontSize: Responsive().setSp(15),
                              color:
                                  Theme.of(context).textTheme.subtitle2.color)),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PDFViewerCachedFromUrl(
                                    url: model.savedName == null ||
                                            model.savedName == ""
                                        ? model.downloadLink
                                        : model.savedName,
                                    lesson: model.subjectName,
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.open_in_browser),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        print("dfgdfgdf");
                        print("    model.savedName != "
                            " || model.savedName != null ${model.savedName}");
                        if (model.savedName != "" && model.savedName != null) {
                          Share.shareFiles([model.savedName],
                              text: model.title);
                        } else {
                          Share.share(model.downloadLink, subject: model.title);
                        }
                      },
                      child: Icon(Icons.share_rounded)),
                  model.savedName != null
                      ? InkWell(
                          child: Icon(Icons.delete),
                          onTap: () {
                            locator<BooksServices>().deleteFile(model);
                          },
                        )
                      : InkWell(
                          child: Icon(Icons.download),
                          onTap: () {
                            locator<BooksServices>().downloadFile(model
                              ..downloadLink =
                                  "http://www.orimi.com/pdf-test.pdf");
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
