import 'package:ecommerce_app_ui_kit/config/ui_icons.dart';
import 'package:ecommerce_app_ui_kit/src/models/combination.dart';
import 'package:ecommerce_app_ui_kit/src/models/product.dart';
import 'package:ecommerce_app_ui_kit/src/models/route_argument.dart';
import 'package:ecommerce_app_ui_kit/src/screens/image_screen.dart';
import 'package:ecommerce_app_ui_kit/src/services/cart.service.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/DrawerWidget.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/HomeSliderWidget.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/ProductDetailsTabWidget.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/ProductHomeTabWidget.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/ProductsSliderWidget.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/ReviewsListWidget.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:provider/provider.dart';

class ProductWidget extends StatefulWidget {
  RouteArgument routeArgument;
  Combination _combination;
  String _heroTag;

  ProductWidget({Key key, this.routeArgument}) {
    _combination = this.routeArgument.argumentsList[0] as Combination;
    _heroTag = this.routeArgument.argumentsList[1] as String;
  }

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _tabIndex = 0;

  @override
  void initState() {
    _tabController =
        TabController(length: 3, initialIndex: _tabIndex, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CartService cartService = Provider.of<CartService>(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).focusColor.withOpacity(0.15),
                blurRadius: 5,
                offset: Offset(0, -2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            widget._combination.amount == 0
                ? Expanded(
                    child: FlatButton(
                        onPressed: () {
                          cartService.addToCartCart(widget._combination);
                        },
                        padding: EdgeInsets.symmetric(vertical: 14),
                        color: Theme.of(context).accentColor,
                        shape: StadiumBorder(),
                        child: Text(
                          'Add To Cart',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  )
                : FlatButton(
                    onPressed: () {
                      // cartService.addToCartCart(widget._combination);
                    },
                    color: Theme.of(context).accentColor,
                    shape: StadiumBorder(),
                    child: Container(
                      // width: 240,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          // Expanded(
                          //   child: Text(
                          //     'Add to Cart',
                          //     textAlign: TextAlign.start,
                          //     style: TextStyle(color: Theme.of(context).primaryColor),
                          //   ),
                          // ),
                          IconButton(
                            onPressed: () {
                              cartService.updateCart(widget._combination, increment: false);
                            },
                            iconSize: 30,
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            icon: Icon(Icons.remove_circle_outline),
                            color: Theme.of(context).primaryColor,
                          ),
                          Text(
                              widget._combination.amount.toString(),
                              style: Theme.of(context).textTheme.subhead.merge(
                                  TextStyle(
                                      color: Theme.of(context).primaryColor))),
                          IconButton(
                            onPressed: () {
                              cartService.updateCart(widget._combination);
                            },
                            iconSize: 30,
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            icon: Icon(Icons.add_circle_outline),
                            color: Theme.of(context).primaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
//          snap: true,
          floating: true,
//          pinned: true,
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(UiIcons.return_icon,
                color: Theme.of(context).hintColor),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            new ShoppingCartButtonWidget(
                iconColor: Theme.of(context).hintColor,
                labelColor: Theme.of(context).accentColor),
            // Container(
            // width: 30,
            // height: 30,
            // margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
            // child: InkWell(
            //   borderRadius: BorderRadius.circular(300),
            //   onTap: () {
            //     Navigator.of(context).pushNamed('/Tabs', arguments: 1);
            //   },
            // child: CircleAvatar(
            //   backgroundImage: AssetImage('img/user2.jpg'),
            // ),
            // )
            // ),
          ],
          backgroundColor: Theme.of(context).primaryColor,
          expandedHeight: 350,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            background: Hero(
              tag: widget._heroTag + widget.routeArgument.id,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                    width: double.infinity,
                    // decoration: BoxDecoration(
                    //   image: DecorationImage(
                    //     fit: BoxFit.cover,
                    //     image: NetworkImage(widget._combination.pics.first),
                    //   ),
                    // ),
                    child: ProductSliderWidget(
                      productsPhotos: widget._combination.pics,
                    ),
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //       gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                  //     Theme.of(context).primaryColor,
                  //     Colors.white.withOpacity(0),
                  //     Colors.white.withOpacity(0),
                  //     Theme.of(context).scaffoldBackgroundColor
                  //   ], stops: [
                  //     0,
                  //     0.4,
                  //     0.6,
                  //     1
                  //   ])),
                  // ),
                ],
              ),
            ),
          ),

          //   bottom: TabBar(
          //       controller: _tabController,
          //       indicatorSize: TabBarIndicatorSize.label,
          //       labelPadding: EdgeInsets.symmetric(horizontal: 10),
          //       unselectedLabelColor: Theme.of(context).accentColor,
          //       labelColor: Theme.of(context).primaryColor,
          //       indicator: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Theme.of(context).accentColor),
          //       tabs: [
          //         Tab(
          //           child: Container(
          //             padding: EdgeInsets.symmetric(horizontal: 5),
          //             decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(50),
          //                 border: Border.all(color: Theme.of(context).accentColor.withOpacity(0.2), width: 1)),
          //             child: Align(
          //               alignment: Alignment.center,
          //               child: Text("Product"),
          //             ),
          //           ),
          //         ),
          //         Tab(
          //           child: Container(
          //             padding: EdgeInsets.symmetric(horizontal: 5),
          //             decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(50),
          //                 border: Border.all(color: Theme.of(context).accentColor.withOpacity(0.2), width: 1)),
          //             child: Align(
          //               alignment: Alignment.center,
          //               child: Text("Detail"),
          //             ),
          //           ),
          //         ),
          //         Tab(
          //           child: Container(
          //             padding: EdgeInsets.symmetric(horizontal: 5),
          //             decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(50),
          //                 border: Border.all(color: Theme.of(context).accentColor.withOpacity(0.2), width: 1)),
          //             child: Align(
          //               alignment: Alignment.center,
          //               child: Text("Review"),
          //             ),
          //           ),
          //         ),
          //       ]),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Offstage(
              offstage: 0 != _tabIndex,
              child: Column(
                children: <Widget>[
                  ProductHomeTabWidget(combination: widget._combination),
                ],
              ),
            ),
            Offstage(
              offstage: 1 != _tabIndex,
              child: Column(
                children: <Widget>[
                  ProductDetailsTabWidget(
                    combination: widget._combination,
                  )
                ],
              ),
            ),
            Offstage(
              offstage: 2 != _tabIndex,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      leading: Icon(
                        UiIcons.chat_1,
                        color: Theme.of(context).hintColor,
                      ),
                      title: Text(
                        'Product Reviews',
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ),
                  ),
                  ReviewsListWidget()
                ],
              ),
            )
          ]),
        )
      ]),
    );
  }
}
