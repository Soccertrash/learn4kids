import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:learn4kids/persist/access/persistenceService.dart';
import 'package:learn4kids/persist/model/category.dart';
import 'package:learn4kids/view/routing/router.dart' as router;
import 'package:learn4kids/view/styles/colors.dart';
import 'package:learn4kids/view/styles/text.dart' as TextStyle;

class _SettingsState extends State<SettingsPage> {
  Future<List<Category>> _data;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _data = PersistenceService.db.getAlCategories();
  }

  void _navigateTo(Category category) {
    Navigator.pushNamed(context, router.SettingsCategoryRoute,
            arguments: category)
        .then((value) {
      setState(() {
        _reload();
      });
    });
  }

  void _delete(Category category) {
    PersistenceService.db.deleteCategory(category).then((value) {
      setState(() {
        _reload();
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
          Expanded(
              child: Center(
                  child: Text(AppLocalizations.of(context).settingsHeading,
                      style: TextStyle.heading))),
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
                                child: GestureDetector(
                                  child: Text(
                                    '${i.categoryName}',
                                    style: TextStyle.normalPrimary,
                                  ),
                                  onTap: () {
                                    _navigateTo(i);
                                  },
                                  onLongPress: () {
                                    _delete(i);
                                  },
                                ));
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
                  _navigateTo(new Category());
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

class SettingsPage extends StatefulWidget {
  @override
  State createState() => _SettingsState();
}
