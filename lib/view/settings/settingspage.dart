import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:learn4kids/persist/access/persistenceService.dart';
import 'package:learn4kids/persist/model/category.dart';
import 'package:learn4kids/view/routing/router.dart' as router;
import 'package:learn4kids/view/styles/colors.dart';
import 'package:learn4kids/view/styles/text.dart' as TextStyle;
import 'package:learn4kids/view/widgets/headingWithBackButton.dart';

class Card extends StatelessWidget {
  Category category;
  _SettingsState settingsState;

  Card({this.category, this.settingsState});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              category.categoryName,
              style: TextStyle.normalPrimary,
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                    child: TextButton.icon(
                        onPressed: () {
                          settingsState.navigateTo(this.category);
                        },
                        style: TextButton.styleFrom(
                          primary: AppColors.primary,
                          backgroundColor: AppColors.secondary,
                        ),
                        label: Text(""),
                        icon: Icon(Icons.edit))),
                Flexible(
                    child: TextButton.icon(
                        onPressed: () {
                          settingsState.delete(this.category);
                        },
                        style: TextButton.styleFrom(
                          primary: AppColors.primary,
                          backgroundColor: AppColors.secondary,
                        ),
                        label: Text(""),
                        icon: Icon(Icons.delete)))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _SettingsState extends State<SettingsPage> {
  Future<List<Category>> _data;

  @override
  void initState() {
    super.initState();
    reload();
  }

  void reload() {
    _data = PersistenceService.db.getAlCategories();
  }

  void navigateTo(Category category) {
    Navigator.pushNamed(context, router.SettingsCategoryRoute,
            arguments: category)
        .then((value) {
      setState(() {
        reload();
      });
    });
  }

  void delete(Category category) {
    PersistenceService.db.deleteCategory(category).then((value) {
      setState(() {
        reload();
      });
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
          HeadingWithBackButton(AppLocalizations.of(context).settingsHeading),
          Expanded(
              flex: 2,
              child: FutureBuilder<List<Category>>(
                future: _data,
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
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.secondary,
                                  border: Border.all(width: 4)),
                              child: Card(category: i, settingsState: this),
                            );
                          },
                        );
                      }).toList(),
                    );
                  } else {
                    return SizedBox(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )),
          Expanded(
              child: Center(
            child: TextButton.icon(
                onPressed: () {
                  navigateTo(new Category());
                },
                style: TextButton.styleFrom(
                  primary: AppColors.primary,
                  backgroundColor: AppColors.secondary,
                ),
                icon: Icon(Icons.add),
                label: Text(AppLocalizations.of(context).add,
                    style: TextStyle.normalPrimary)),
          )),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  State createState() => _SettingsState();
}
