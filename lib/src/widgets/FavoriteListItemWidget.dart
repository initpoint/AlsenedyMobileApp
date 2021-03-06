import 'package:ecommerce_app_ui_kit/config/ui_icons.dart';
import 'package:ecommerce_app_ui_kit/src/models/combination.dart';
import 'package:ecommerce_app_ui_kit/src/models/customer.dart';
import 'package:ecommerce_app_ui_kit/src/models/product.dart';
import 'package:ecommerce_app_ui_kit/src/models/route_argument.dart';
import 'package:ecommerce_app_ui_kit/src/services/customer.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: must_be_immutable
class FavoriteListItemWidget extends StatefulWidget {
  String heroTag;
  Combination combination;

  VoidCallback onDismissed;

  FavoriteListItemWidget({Key key, this.heroTag, this.combination, this.onDismissed}) : super(key: key);

  @override
  _FavoriteListItemWidgetState createState() => _FavoriteListItemWidgetState();
}

class _FavoriteListItemWidgetState extends State<FavoriteListItemWidget> {
  @override
  Widget build(BuildContext context) {
    final UsersService usersService = Provider.of<UsersService>(context);
    return Dismissible(
      key: Key(this.widget.combination?.hashCode?.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              UiIcons.trash,
              color: Colors.white,
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        // Remove the item from the data source.
        setState(() {
          widget.onDismissed();
        });

        // Then show a snackbar.
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("The ${widget.combination?.nameAr} product is removed from wish list")));
      },
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        focusColor: Theme.of(context).accentColor,
        highlightColor: Theme.of(context).primaryColor,
        onTap: () {
          Navigator.of(context).pushNamed('/Product',
              arguments: new RouteArgument(
                  argumentsList: [this.widget.combination, this.widget.heroTag], id: this.widget.combination?.id));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.9),
            boxShadow: [
              BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag: widget.heroTag + widget.combination?.id,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(image: widget.combination.pics.isEmpty? AssetImage('img/defalut.jpg') : NetworkImage(widget.combination.pics.first), fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(width: 15),
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.combination?.nameArFull,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.subhead,
                          ),
                          Row(
                            children: <Widget>[
                              // The title of the product
                              // Text(
                              //   '${widget.combination.price} Sales',
                              //   style: Theme.of(context).textTheme.body1,
                              //   overflow: TextOverflow.fade,
                              //   softWrap: false,
                              // ),
                              // SizedBox(width: 10),
                              // Icon(
                              //   Icons.star,
                              //   color: Colors.amber,
                              //   size: 18,
                              // ),
                              // Text(
                              //   widget.combination.rate.toString(),
                              //   style: Theme.of(context).textTheme.body2,
                              // )
                            ],
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    StreamBuilder(
                      stream: usersService.getUser().asStream(),
                      builder: (context, AsyncSnapshot<Customer> snapshot) {
                     if(snapshot.data != null) {
                        return Text(widget.combination?.prices[snapshot?.data?.pricelist]?.toString() ?? 0.toString(), style: Theme.of(context).textTheme.display1);
                     } else {
                       return Text('0');
                     }
                      }
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
