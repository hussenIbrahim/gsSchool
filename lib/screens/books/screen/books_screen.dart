import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/books/screen/books_widget.dart';
import 'package:testgsschoolst/screens/books/services/books_notifer.dart';
import 'package:testgsschoolst/screens/subjects/services/subjects_model.dart';

import 'package:testgsschoolst/widget/state_widget/falied_load_page_widget.dart';
import 'package:testgsschoolst/widget/state_widget/network_error.dart';
import 'package:testgsschoolst/widget/state_widget/no_data_found.dart';
import 'package:testgsschoolst/widget/state_widget/progress_widget.dart';

class BooksScreen extends StatefulWidget {
  BooksScreen({Key key}) : super(key: key);

  @override
  _BooksState createState() => _BooksState();
}

class _BooksState extends State<BooksScreen> {
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      booksNotifer = Provider.of<BooksNotifer>(context, listen: false);
      if (booksNotifer.getDataStatus != Status.loading &&
          booksNotifer.eventsList.length == 0) {
        booksNotifer.getBooks(false, booksNotifer.subjectModel?.id ?? 0);
      }
      if (subJectsNotifer.getDataStatus != Status.loading &&
          subJectsNotifer.subjects.length == 0) {
        subJectsNotifer.getSubectss(false);
      }
    });
    super.initState();
  }

  Future<void> refresh() async {
    await booksNotifer.refresh(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Consumer<BooksNotifer>(builder: (context, myType, child) {
            return Container(
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: DropdownButtonFormField<SubjectModel>(
                      items: myType.subjects.map((SubjectModel category) {
                        return new DropdownMenuItem(
                            value: category,
                            child: Row(
                              children: <Widget>[
                                Text("${category.name}"),
                              ],
                            ));
                      }).toList(),
                      onChanged: (SubjectModel newValue) {
                        // do other stuff with _category
                        myType.changeSubjectModel(newValue);
                      },
                      value: myType.subjectModel,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        filled: true,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        fillColor: Colors.grey[200],
                        hintText: "Select Subject",
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          Expanded(
            child: Consumer<BooksNotifer>(builder: (context, myType, child) {
              if (myType.getDataStatus == Status.loading ||
                  myType.getDataStatus == Status.initState) {
                return ProgressWidget();
              } else if (myType.getDataStatus == Status.error) {
                return FaliedLoadPageWIdget(
                    onPress: refresh, text: "Failed load books");
              } else if (myType.getDataStatus == Status.newtworkError) {
                return NetWorkErrorWidget(
                    onPress: refresh, text: "Failed load books");
              } else if (myType.getDataStatus == Status.noDataFound) {
                return NoDataFound(onPress: refresh, text: "No books Found");
              } else if (myType.getDataStatus == Status.dataFound) {
                return Column(
                  children: [
                    Expanded(
                        child: RefreshIndicator(
                            onRefresh: refresh,
                            child: ListView.separated(
                              itemCount: myType.eventsList.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  BooksWidget(
                                model: myType.eventsList[index],
                              ),
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider();
                              },
                            ))),
                  ],
                );
              } else {
                return ProgressWidget();
              }
            }),
          ),
        ],
      ),
    );
  }
}
