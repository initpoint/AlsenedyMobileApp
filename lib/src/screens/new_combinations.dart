import 'package:ecommerce_app_ui_kit/config/ui_icons.dart';
import 'package:ecommerce_app_ui_kit/src/models/combination.dart';
import 'package:ecommerce_app_ui_kit/src/models/product.dart';
import 'package:ecommerce_app_ui_kit/src/services/combinations.service.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/EmptyFavoritesWidget.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/FavoriteListItemWidget.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/ProductGridItemWidget.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../app_localizations.dart';

class NewCombinationsWidget extends StatefulWidget {
  @override
  _NewCombinationsWidgetState createState() => _NewCombinationsWidgetState();
}

class _NewCombinationsWidgetState extends State<NewCombinationsWidget> {
  String layout = 'grid';
  ProductsList _productsList = new ProductsList();
  List<Combination> _compbinationList = List<Combination>();

  @override
  Widget build(BuildContext context) {
    var combinationsRef = Provider.of<CombinationsService>(context);

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
            offstage: _productsList.favoritesList.isEmpty,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                leading: Icon(
                  UiIcons.shopping_cart,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  AppLocalizations.of(context).translate('new_combinations'),
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
                        color: this.layout == 'list'
                            ? Theme.of(context).accentColor
                            : Theme.of(context).focusColor,
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
                        color: this.layout == 'grid'
                            ? Theme.of(context).accentColor
                            : Theme.of(context).focusColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Offstage(
            offstage:
                this.layout != 'list' || _productsList.favoritesList.isEmpty,
            child: StreamBuilder(
                stream: combinationsRef.getCombinations(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    _compbinationList = snapshot.data.documents
                        .map((doc) =>
                            Combination.fromMap(doc.data, doc.documentID))
                        .where((com) => com.isNew == true  && com.isActive == true)
                        .toList();
                    return ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: _compbinationList.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10);
                      },
                      itemBuilder: (context, index) {
                        return FavoriteListItemWidget(
                          heroTag: 'favorites_list',
                          combination: _compbinationList.elementAt(index),
                          onDismissed: () {
                            setState(() {
                              _productsList.favoritesList.removeAt(index);
                            });
                          },
                        );
                      },
                    );
                  } else {
                    return Text('fetching');
                  }
                }),
          ),
          Offstage(
            offstage:
                this.layout != 'grid' || _productsList.favoritesList.isEmpty,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: StreamBuilder(
                  stream: combinationsRef.getCombinations(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      _compbinationList = snapshot.data.documents
                          .map((doc) =>
                              Combination.fromMap(doc.data, doc.documentID))
                          .where((com) => com.isNew == true)
                          .toList();
                      return new StaggeredGridView.countBuilder(
                        primary: false,
                        shrinkWrap: true,
                        crossAxisCount: 4,
                        itemCount: _compbinationList.length,
                        itemBuilder: (BuildContext context, int index) {
                          Combination combination =
                              _compbinationList.elementAt(index);
                          return ProductGridItemWidget(
                            combination: combination,
                            heroTag: 'favorites_grid',
                          );
                        },
//                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
                        staggeredTileBuilder: (int index) =>
                            new StaggeredTile.fit(2),
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 15.0,
                      );
                    } else {
                      return Text('Lodinnngl.........');
                    }
                  }),
            ),
          ),
          Offstage(
            offstage: _productsList.favoritesList.isNotEmpty,
            child: EmptyFavoritesWidget(),
          )
        ],
      ),
    );
 }
}
