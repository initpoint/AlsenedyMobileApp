import 'package:ecommerce_app_ui_kit/app_localizations.dart';
import 'package:ecommerce_app_ui_kit/config/ui_icons.dart';
import 'package:ecommerce_app_ui_kit/src/models/customer.dart';
import 'package:ecommerce_app_ui_kit/src/models/user.dart';
import 'package:ecommerce_app_ui_kit/src/services/auth.service.dart';
import 'package:ecommerce_app_ui_kit/src/services/customer.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  User _user = new User.init().getCurrentUser();

  Customer _customer = Customer();

  @override
  Widget build(BuildContext context) {
    final BaseAuth auth = Provider.of<BaseAuth>(context);
    final UsersService usersService = Provider.of<UsersService>(context);

    // TODO: implement build
    return Drawer(
      child: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/Tabs', arguments: 1);
            },
            child: StreamBuilder(
                stream: usersService.getUser().asStream(),
                builder: (context, AsyncSnapshot<Customer> snapshot) {
                  if (snapshot.hasData) {
                    return UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: Theme.of(context).hintColor.withOpacity(0.1),
                        // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35)),
                      ),
                      accountName: Text(
                        snapshot.data.fullName == null ? '' : snapshot.data.fullName,
                        style: Theme.of(context).textTheme.title,
                      ),
                      accountEmail: Text(
                        snapshot.data.email,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      // currentAccountPicture: CircleAvatar(
                      //   backgroundColor: Theme.of(context).accentColor,
                      //   backgroundImage: NetworkImage(snapshot.data.photoUrl),
                      // ),
                    );
                  } else {
                    return Text('Loogjsklfjdslkjfkljs');
                  }
                }),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Tabs', arguments: 2);
            },
            leading: Icon(
              UiIcons.home,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
               AppLocalizations.of(context)
                                  .translate('home'),
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/Tabs', arguments: 0);
          //   },
          //   leading: Icon(
          //     UiIcons.bell,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     "Notifications",
          //     style: Theme.of(context).textTheme.subhead,
          //   ),
          // ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/Orders', arguments: 0);
          //   },
          //   leading: Icon(
          //     UiIcons.inbox,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     "My Orders",
          //     style: Theme.of(context).textTheme.subhead,
          //   ),
          //   trailing: Chip(
          //     padding: EdgeInsets.symmetric(horizontal: 5),
          //     backgroundColor: Colors.transparent,
          //     shape: StadiumBorder(
          //         side: BorderSide(color: Theme.of(context).focusColor)),
          //     label: Text(
          //       '8',
          //       style: TextStyle(color: Theme.of(context).focusColor),
          //     ),
          //   ),
          // ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/Tabs', arguments: 4);
          //   },
          //   leading: Icon(
          //     UiIcons.heart,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     "Wish List",
          //     style: Theme.of(context).textTheme.subhead,
          //   ),
          // ),
          // ListTile(
          //   dense: true,
          //   title: Text(
          //     "Products",
          //     style: Theme.of(context).textTheme.body1,
          //   ),
          //   trailing: Icon(
          //     Icons.remove,
          //     color: Theme.of(context).focusColor.withOpacity(0.3),
          //   ),
          // ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/Categories');
          //   },
          //   leading: Icon(
          //     UiIcons.folder_1,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     "Categories",
          //     style: Theme.of(context).textTheme.subhead,
          //   ),
          // ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/Brands');
          //   },
          //   leading: Icon(
          //     UiIcons.folder_1,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     "Brands",
          //     style: Theme.of(context).textTheme.subhead,
          //   ),
          // ),
          // ListTile(
          //   dense: true,
          //   title: Text(
          //     "Application Preferences",
          //     style: Theme.of(context).textTheme.body1,
          //   ),
          //   trailing: Icon(
          //     Icons.remove,
          //     color: Theme.of(context).focusColor.withOpacity(0.3),
          //   ),
          // ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/Help');
          //   },
          //   leading: Icon(
          //     UiIcons.information,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     "Help & Support",
          //     style: Theme.of(context).textTheme.subhead,
          //   ),
          // ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/Tabs', arguments: 1);
          //   },
          //   leading: Icon(
          //     UiIcons.settings_1,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     "Settings",
          //     style: Theme.of(context).textTheme.subhead,
          //   ),
          // ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Chat');
            },
            leading: Icon(
              UiIcons.chat,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
               AppLocalizations.of(context)
                                  .translate('Chat'),
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Languages');
            },
            leading: Icon(
              UiIcons.planet_earth,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
               AppLocalizations.of(context)
                                  .translate('languages'),
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () async {
              auth.signOut();
            },
            leading: Icon(
              UiIcons.upload,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
               AppLocalizations.of(context)
                                  .translate('logout'),
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            dense: true,
            title: Text(
              "Version 0.0.1",
              style: Theme.of(context).textTheme.body1,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}
