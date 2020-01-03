import 'package:ecommerce_app_ui_kit/src/models/combination.dart';
import 'package:ecommerce_app_ui_kit/src/models/product.dart';
import 'package:ecommerce_app_ui_kit/src/models/route_argument.dart';
import 'package:flutter/material.dart';

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
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        Navigator.of(context).pushNamed('/Product',
            arguments: new RouteArgument(argumentsList: [this.combination, this.heroTag], id: this.combination.id));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.10), offset: Offset(0, 4), blurRadius: 10)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: this.heroTag + combination.id,
              child: Image.network(combination.photoUrl),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                combination.nameAr,
                style: Theme.of(context).textTheme.body2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                combination.price.toString(),
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: <Widget>[
                  // The title of the product
                  // Expanded(
                    // child: Text(
                    //   '${combination.price.toString()} Sales',
                    //   style: Theme.of(context).textTheme.body1,
                    //   overflow: TextOverflow.fade,
                    //   softWrap: false,
                    // ),
                  // ),
                  // Icon(
                  //   Icons.star,
                  //   color: Colors.amber,
                  //   size: 18,
                  // ),
                  // Text(
                  //   combination.rate.toString(),
                  //   style: Theme.of(context).textTheme.body2,
                  // )
                ],
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
