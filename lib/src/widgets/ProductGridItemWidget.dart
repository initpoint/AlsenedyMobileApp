import 'package:ecommerce_app_ui_kit/src/models/combination.dart';
import 'package:ecommerce_app_ui_kit/src/models/customer.dart';
import 'package:ecommerce_app_ui_kit/src/models/route_argument.dart';
import 'package:ecommerce_app_ui_kit/src/services/customer.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_localizations.dart';

class ProductGridItemWidget extends StatelessWidget {
  const ProductGridItemWidget({
    Key key,
    @required this.combination,
    @required this.heroTag,
  }) : super(key: key);

  final Combination combination;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    final UsersService usersService = Provider.of<UsersService>(context);
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        Navigator.of(context).pushNamed('/Product',
            arguments: new RouteArgument(
                argumentsList: [this.combination, this.heroTag],
                id: this.combination?.id));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).hintColor.withOpacity(0.10),
                offset: Offset(0, 4),
                blurRadius: 10)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: this.heroTag + combination?.id,
              child: combination.pics.isEmpty
                  ? Image.asset('img/defalut.jpg')
                  : Image.network(combination.pics.first),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                combination?.nameArFull,
                style: Theme.of(context).textTheme.body2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  StreamBuilder(
                      stream: usersService.getUser().asStream(),
                      builder: (context, AsyncSnapshot<Customer> snapshot) {
                        if (snapshot.data != null) {
                          return Text(
                            combination?.prices[snapshot?.data?.pricelist]?.toString() ?? 0.toString(),
                            style: Theme.of(context).textTheme.title,
                          );
                        } else {
                          return Text('0');
                        }
                      }),
                  combination.isNew
                      ? Chip(
                          backgroundColor: Colors.red,
                          label: Text(
                  AppLocalizations.of(context)
                                  .translate('new'),
                            style: TextStyle(color: Colors.white),
                          ))
                      : Container()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: <Widget>[],
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
