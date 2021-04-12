import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:learn4kids/persist/access/persistenceService.dart';
import 'package:learn4kids/persist/model/category.dart';
import 'package:learn4kids/view/styles/colors.dart';
import 'package:learn4kids/view/styles/text.dart' as TextStyle;

class SettingsPage extends StatelessWidget {
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context).addCategory),
            content: TextField(
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context).category),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Category c = new Category(categoryName: "Category One");
                    PersistenceService.db.addCategoryToDatabase(c);
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    primary: AppColors.primary,
                    backgroundColor: AppColors.secondary,
                  ),
                  child: Text(AppLocalizations.of(context).ok)),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    primary: AppColors.primary,
                    backgroundColor: AppColors.error,
                  ),
                  child: Text(AppLocalizations.of(context).cancel)),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Center(
                  child: Text(AppLocalizations.of(context).settingsHeading,
                      style: TextStyle.heading))),
          Expanded(
              flex: 2,
              child: FutureBuilder<List<Category>>(
                future: PersistenceService.db.getAlCategories(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Category>> snapshot) {
                  if (snapshot.hasData) {
                    return CarouselSlider(
                      options: CarouselOptions(height: 400.0),
                      items: snapshot.data.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: 300,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(color: Colors.amber),
                                child: Text(
                                  'text ${i.categoryName}',
                                  style: TextStyle.normal,
                                ));
                          },
                        );
                      }).toList(),
                    );
                  } else {
                    return SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    );
                  }
                },
              )),
          Expanded(
              child: Center(
            child: TextButton.icon(
                onPressed: () {
                  _displayTextInputDialog(context);
                },
                style: TextButton.styleFrom(
                  primary: AppColors.primary,
                  backgroundColor: AppColors.secondary,
                ),
                icon: Icon(Icons.add),
                label: Text(AppLocalizations.of(context).add)),
          )),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
