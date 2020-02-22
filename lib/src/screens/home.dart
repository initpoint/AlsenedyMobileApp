import 'package:ecommerce_app_ui_kit/config/ui_icons.dart';
import 'package:ecommerce_app_ui_kit/src/models/product.dart';
import 'package:ecommerce_app_ui_kit/src/services/combinations.service.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/ProductGridItemWidget.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/EmptyFavoritesWidget.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/FavoriteListItemWidget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../app_localizations.dart';
import '../models/combination.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget>
    with SingleTickerProviderStateMixin {
  String layout = 'grid';
  ScrollController _scrollController;
  CombinationsRepo _combinationsRepo;

  ProductsList _productsList = new ProductsList();
  List<Combination> _compbinationList = List<Combination>();
  int currentPage = 1;
  getCombinations() async {
    var combinations = await _combinationsRepo.getCombinations();
    setState(() {
      _compbinationList =
          combinations.where((com) => com.isActive == true).toList();
    });
  }

  _scrollListener() async {
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      print('start');
    }
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      print(_compbinationList.length);
      var combToAdd = await _combinationsRepo.getCombinations();
      _compbinationList.addAll(combToAdd);
      print(_compbinationList.length);
      setState(() {
        _compbinationList = _compbinationList.toSet().toList();
      });
      print('end');
    }
  }

  @override
  void initState() {
    _combinationsRepo = CombinationsRepo();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    this.getCombinations();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_compbinationList.length == 0) {
      return Column(
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
                  AppLocalizations.of(context).translate('combinations'),
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
          Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      );
    }
    return SingleChildScrollView(
      controller: _scrollController,
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
                  AppLocalizations.of(context).translate('combinations'),
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
              child: Column(
                children: <Widget>[
                  ListView.separated(
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
                        combination: _compbinationList?.elementAt(index),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  !_combinationsRepo.allComming
                      ? Center(
                          // child: LinearProgressIndicator(),
                        )
                      : Text('لا يوجد المزيد من التركيبات'),
                  SizedBox(
                    height: 20,
                  ),
                ],
              )),
          Offstage(
            offstage:
                this.layout != 'grid' || _productsList.favoritesList.isEmpty,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  StaggeredGridView.countBuilder(
                    primary: false,
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    itemCount: _compbinationList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Combination combination =
                          _compbinationList.elementAt(index);
                      // return Center(child: CircularProgressIndicator()  ,);
                      return ProductGridItemWidget(
                        combination: combination,
                        heroTag: 'favorites_grid',
                      );
                    },
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.fit(2),
                    mainAxisSpacing: 15.0,
                    crossAxisSpacing: 15.0,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  !_combinationsRepo.allComming
                      ? Center(
                          // child: LinearProgressIndicator(),
                        )
                      : Text('لا يوجد المزيد من التركيبات'),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
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
