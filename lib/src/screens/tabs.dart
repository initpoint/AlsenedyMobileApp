import 'package:ecommerce_app_ui_kit/config/ui_icons.dart';
import 'package:ecommerce_app_ui_kit/src/screens/account.dart';
import 'package:ecommerce_app_ui_kit/src/screens/chat.dart';
import 'package:ecommerce_app_ui_kit/src/screens/favorites.dart';
import 'package:ecommerce_app_ui_kit/src/screens/home.dart';
import 'package:ecommerce_app_ui_kit/src/screens/messages.dart';
import 'package:ecommerce_app_ui_kit/src/screens/my_transactions.dart';
import 'package:ecommerce_app_ui_kit/src/screens/new_combinations.dart';
import 'package:ecommerce_app_ui_kit/src/screens/notifications.dart';
import 'package:ecommerce_app_ui_kit/src/screens/promotions.dart';
import 'package:ecommerce_app_ui_kit/src/screens/shipment.dart';
import 'package:ecommerce_app_ui_kit/src/screens/signin.dart';
import 'package:ecommerce_app_ui_kit/src/services/auth.service.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/DrawerWidget.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/FilterWidget.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class TabsWidget extends StatefulWidget {
  int currentTab = 2;
  int selectedTab = 2;
  String currentTitle = 'Home';
  Widget currentPage = HomeWidget();
  bool firstRout = true;

  TabsWidget({
    Key key,
    this.currentTab,
  }) : super(key: key);

  @override
  _TabsWidgetState createState() {
    return _TabsWidgetState();
  }
}

class _TabsWidgetState extends State<TabsWidget> {
  void canActivate(BaseAuth auth, BuildContext context) async {
    await auth.getCurrentUser().then((user) {
      if (user == null && widget.firstRout) {
        Navigator.of(context).pushNamed('/SignIn');
        widget.firstRout = false;
      }
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  initState() {
    _selectTab(widget.currentTab);
    super.initState();
  }

  @override
  void didUpdateWidget(TabsWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      widget.selectedTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentTitle = 'Account Statement';
          widget.currentPage = TransactionsWidget();
          break;
        case 1:
          widget.currentTitle = 'Shipments';
          widget.currentPage = ShipmentsWidget();
          break;
        case 2:
          widget.currentTitle = 'Home';
          widget.currentPage = HomeWidget();
          break;
        case 3:
          widget.currentTitle = 'Promotions';
          widget.currentPage = PromotionsWidget();
          break;
        case 4:
          widget.currentTitle = 'New Combinations';
          widget.currentPage = NewCombinationsWidget();
          break;
        case 5:
          widget.selectedTab = 3;
          widget.currentTitle = 'Chat';
          widget.currentPage = ChatWidget();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    try {
      final user = Provider.of<FirebaseUser>(context);
      if (user == null) {
        return SignInWidget();
      }
    } catch (e) {}

    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      endDrawer: FilterWidget(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
//        leading: new IconButton(
//          icon: new Icon(UiIcons.return_icon, color: Theme.of(context).hintColor),
//          onPressed: () => Navigator.of(context).pop(),
//        ),
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.currentTitle,
          style: Theme.of(context).textTheme.display1,
        ),
        actions: <Widget>[
          new ShoppingCartButtonWidget(
              iconColor: Theme.of(context).hintColor,
              labelColor: Theme.of(context).accentColor),
          // Container(
          //     width: 30,
          //     height: 30,
          //     margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
          //     child: InkWell(
          //       borderRadius: BorderRadius.circular(300),
          //       onTap: () {
          //         Navigator.of(context).pushNamed('/Tabs', arguments: 1);
          //       },
          //       child: CircleAvatar(
          //         backgroundImage: AssetImage('img/user2.jpg'),
          //       ),
          //     )),
        ],
      ),
      body: widget.currentPage,
//      bottomNavigationBar: CurvedNavigationBar(
//        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//        buttonBackgroundColor: Theme.of(context).accentColor,
//        color: Theme.of(context).focusColor.withOpacity(0.2),
//        height: 60,
//        index: widget.selectedTab,
//        onTap: (int i) {
//          this._selectTab(i);
//        },
//        items: <Widget>[
//          Icon(
//            UiIcons.bell,
//            size: 23,
//            color: Theme.of(context).focusColor,
//          ),
//          Icon(
//            UiIcons.user_1,
//            size: 23,
//            color: Theme.of(context).focusColor,
//          ),
//          Icon(
//            UiIcons.home,
//            size: 23,
//            color: Theme.of(context).focusColor,
//          ),
//          Icon(
//            UiIcons.chat,
//            size: 23,
//            color: Theme.of(context).focusColor,
//          ),
//          Icon(
//            UiIcons.heart,
//            size: 23,
//            color: Theme.of(context).focusColor,
//          ),
//        ],
//      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).accentColor,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        iconSize: 22,
        elevation: 0,
        backgroundColor: Colors.transparent,
        selectedIconTheme: IconThemeData(size: 25),
        unselectedItemColor: Theme.of(context).hintColor.withOpacity(1),
        currentIndex: widget.selectedTab,
        onTap: (int i) {
          this._selectTab(i);
        },
        // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: Column(
              children: <Widget>[
                Icon(UiIcons.custom_icons),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Statement',
                )
              ],
            ),
            title: new Container(height: 0.0),
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: <Widget>[
                Icon(UiIcons.local_shipping),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Shipments',
                )
              ],
            ),
            title: new Container(height: 0.0),
          ),
          BottomNavigationBarItem(
              title: new Container(height: 5.0),
              icon: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).accentColor.withOpacity(0.4),
                        blurRadius: 40,
                        offset: Offset(0, 15)),
                    BoxShadow(
                        color: Theme.of(context).accentColor.withOpacity(0.4),
                        blurRadius: 13,
                        offset: Offset(0, 3))
                  ],
                ),
                child: new Icon(UiIcons.home,
                    color: Theme.of(context).primaryColor),
              )),
          BottomNavigationBarItem(
            icon: Column(
              children: <Widget>[
                new Icon(UiIcons.whatshot),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Promotions',
                )
              ],
            ),
            title: new Container(height: 0.0),
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: <Widget>[
                new Icon(UiIcons.new_releases),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'New Items',
                )
              ],
            ),
            title: new Container(height: 0.0),
          ),
        ],
      ),
    );
  }
}
