import 'package:ecommerce_app_ui_kit/src/models/combination.dart';
import 'package:ecommerce_app_ui_kit/src/models/product.dart';
import 'package:ecommerce_app_ui_kit/src/models/route_argument.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/AvailableProgressBarWidget.dart';
import 'package:flutter/material.dart';

class FlashSalesCarouselItemWidget extends StatelessWidget {
  String heroTag;
  double marginLeft;
  Combination combination;

  FlashSalesCarouselItemWidget({
    Key key,
    this.heroTag,
    this.marginLeft,
    this.combination,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed('/Product', arguments: new RouteArgument(id: combination.id, argumentsList: [combination, heroTag]));
      },
      child: Container(
        margin: EdgeInsets.only(left: this.marginLeft, right: 20),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Hero(
              tag: heroTag + combination.id,
              child: Container(
                width: 160,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(combination.photoUrl),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 6,
              right: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)), color: Theme.of(context).accentColor),
                alignment: AlignmentDirectional.topEnd,
                child: Text(
                  '${combination.discount} %',
                  style: Theme.of(context).textTheme.body2.merge(TextStyle(color: Theme.of(context).primaryColor)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 170),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              width: 140,
              height: 113,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    combination.nameAr,
                    style: Theme.of(context).textTheme.body2,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                  Row(
                    children: <Widget>[
                      // The title of the product
                      Expanded(
                        child: Text(
                          '${combination.price.toString()} Sales',
                          style: Theme.of(context).textTheme.body1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                        ),
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      Text(
                        combination.rate.toString(),
                        style: Theme.of(context).textTheme.body2,
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  SizedBox(height: 7),
                  Text(
                    '${combination.amount} Available',
                    style: Theme.of(context).textTheme.body1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AvailableProgressBarWidget(available: combination.amount.toDouble())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
