import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:learn4kids/persist/access/persistenceService.dart';
import 'package:learn4kids/persist/model/category.dart';
import 'package:learn4kids/view/styles/colors.dart';
import 'package:learn4kids/view/styles/text.dart' as TextStyle;

class _SettingsCategoryPageState extends State<SettingsCategoryPage> {
  String categoryError = "";
  TextEditingController categoryTextEditController =
      new TextEditingController();

  @override
  void initState() {
    categoryTextEditController.text = widget.category.categoryName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(AppLocalizations.of(context).category,
                    style: TextStyle.normal),
              ),
              Flexible(
                  child: Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: TextField(
                  textInputAction: TextInputAction.done,
                  style: TextStyle.normal,
                  controller: categoryTextEditController,
                  maxLength: 20,
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).category),
                ),
              )),
              Flexible(
                  child: Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: TextButton(
                          onPressed: () => _updateCategory(),
                          child: Text(
                            AppLocalizations.of(context).ok,
                            style: TextStyle.normalPrimary,
                          ),
                          style: TextButton.styleFrom(
                              primary: AppColors.primary,
                              backgroundColor: AppColors.secondary)))),
              Flexible(
                  child: Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Visibility(
                          visible: categoryError != "",
                          child: Text(categoryError,
                              style: TextStyle.normalError)))),
            ],
          ))
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _updateCategory() {
    if (categoryTextEditController.text == widget.category.categoryName) {
      return;
    }
    Category category = widget.category;
    category.categoryName = categoryTextEditController.text;
    PersistenceService.db.categoryExists(category).then((exists) {
      if (exists) {
        setState(() {
          categoryError = AppLocalizations.of(context).duplicate;
        });
      } else {
        setState(() {
          categoryError = "";
        });
        if (category.id == -1) {
          PersistenceService.db.addCategoryToDatabase(category);
        } else {
          PersistenceService.db.updateCategory(category);
        }
      }
    });
  }
}

class SettingsCategoryPage extends StatefulWidget {
  Category category;

  SettingsCategoryPage({Key key, this.category}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsCategoryPageState();
}
