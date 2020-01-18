import 'package:ecommerce_app_ui_kit/src/models/combination.dart';
import 'package:ecommerce_app_ui_kit/src/models/combination.dart';
import 'package:ecommerce_app_ui_kit/src/models/route_argument.dart';
import 'package:ecommerce_app_ui_kit/src/services/cart.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatefulWidget {
  String heroTag;
  // Product product;
  int quantity;
  Combination combination;

  CartItemWidget({Key key, this.combination, this.heroTag, this.quantity = 1})
      : super(key: key);

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    CartService cartService = Provider.of<CartService>(context);
    print(widget.combination);

    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
        Navigator.of(context).pushNamed('/Product',
            arguments: new RouteArgument(
                argumentsList: [widget.combination, widget.heroTag],
                id: widget.combination?.id));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).focusColor.withOpacity(0.1),
                blurRadius: 5,
                offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: widget.heroTag + widget.combination.id,
              child: Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(
                      image: AssetImage('img/defalut.jpg'),
                      fit: BoxFit.cover),
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
                          widget.combination.nameArFull,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subhead,
                        ),
                        Text(
                          widget.combination.price.toString(),
                          style: Theme.of(context).textTheme.display1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          cartService.updateCart(widget.combination);
                        },
                        iconSize: 30,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        icon: Icon(Icons.add_circle_outline),
                        color: Theme.of(context).hintColor,
                      ),
                      Text(widget.combination.amount.toString(),
                          style: Theme.of(context).textTheme.subhead),
                      IconButton(
                        onPressed: () {
                          cartService.updateCart(widget.combination,
                              increment: false);
                        },
                        iconSize: 30,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        icon: Icon(Icons.remove_circle_outline),
                        color: Theme.of(context).hintColor,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  incrementQuantity(int quantity) {
    if (quantity <= 99) {
      return ++quantity;
    } else {
      return quantity;
    }
  }

  decrementQuantity(int quantity) {
    if (quantity > 1) {
      return --quantity;
    } else {
      return quantity;
    }
  }
}
