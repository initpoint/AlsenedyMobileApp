import 'package:ecommerce_app_ui_kit/config/ui_icons.dart';
import 'package:ecommerce_app_ui_kit/src/models/combination.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/EmptyFavoritesWidget.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/FavoriteListItemWidget.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/ProductGridItemWidget.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ShipmentsWidget extends StatefulWidget {
  @override
  _ShipmentsWidgetState createState() => _ShipmentsWidgetState();
}

class _ShipmentsWidgetState extends State<ShipmentsWidget> {
  String layout = 'grid';
  List<Combination> _combinationList = new List<Combination>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchBarWidget(),
          ),
          SizedBox(height: 10),
          Offstage(
            offstage: _combinationList.isEmpty,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                leading: Icon(
                  UiIcons.heart,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  'Wish List',
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: Theme.of(context).textTheme.display1,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        setState(() {
                          this.layout = 'list';
                        });
                      },
                      icon: Icon(
                        Icons.format_list_bulleted,
                        color: this.layout == 'list' ? Theme.of(context).accentColor : Theme.of(context).focusColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          this.layout = 'grid';
                        });
                      },
                      icon: Icon(
                        Icons.apps,
                        color: this.layout == 'grid' ? Theme.of(context).accentColor : Theme.of(context).focusColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Offstage(
            offstage: this.layout != 'list' || _combinationList.isEmpty,
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemCount: _combinationList.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                return FavoriteListItemWidget(
                  heroTag: 'favorites_list',
                  combination: _combinationList.elementAt(index),
                  onDismissed: () {
                    setState(() {
                      _combinationList.removeAt(index);
                    });
                  },
                );
              },
            ),
          ),
          Offstage(
            offstage: this.layout != 'grid' || _combinationList.isEmpty,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: new StaggeredGridView.countBuilder(
                primary: false,
                shrinkWrap: true,
                crossAxisCount: 4,
                itemCount: _combinationList.length,
                itemBuilder: (BuildContext context, int index) {
                  Combination combination = _combinationList.elementAt(index);
                  return ProductGridItemWidget(
                    combination: combination,
                    heroTag: 'favorites_grid',
                  );
                },
//                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
                staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 15.0,
              ),
            ),
          ),
          Offstage(
            offstage: _combinationList.isNotEmpty,
            child: EmptyFavoritesWidget(),
          )
        ],
      ),
    );
  }
}
