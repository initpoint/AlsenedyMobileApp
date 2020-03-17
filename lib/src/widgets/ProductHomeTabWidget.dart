import 'package:ecommerce_app_ui_kit/config/ui_icons.dart';
import 'package:ecommerce_app_ui_kit/src/models/combination.dart';
import 'package:ecommerce_app_ui_kit/src/models/customer.dart';
import 'package:ecommerce_app_ui_kit/src/models/product.dart';
import 'package:ecommerce_app_ui_kit/src/models/product_color.dart';
import 'package:ecommerce_app_ui_kit/src/models/product_size.dart';
import 'package:ecommerce_app_ui_kit/src/models/promotion.dart';
import 'package:ecommerce_app_ui_kit/src/services/auth.service.dart';
import 'package:ecommerce_app_ui_kit/src/services/customer.service.dart';
import 'package:ecommerce_app_ui_kit/src/services/promotion.service.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/FlashSalesCarouselWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductHomeTabWidget extends StatefulWidget {
  Combination combination;
  List<Combination> _combinationList = new List<Combination>();

  ProductHomeTabWidget({this.combination});

  @override
  productHomeTabWidgetState createState() => productHomeTabWidgetState();
}

class productHomeTabWidgetState extends State<ProductHomeTabWidget> {
  @override
  Widget build(BuildContext context) {
    // BaseAuth auth = Provider.of<BaseAuth>(context);
    final PromotionsService promotionsService =
        Provider.of<PromotionsService>(context);

    // print(widget.combination.prices['No4wqKyS8cu3tINgz7D4'] ?? 0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.combination?.nameArFull,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.display2,
                ),
              ),
              // Chip(
              //   padding: EdgeInsets.all(0),
              // label: Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              // Text(widget.combination.rate.toString(),
              //     style:
              //         Theme.of(context).textTheme.body2.merge(TextStyle(color: Theme.of(context).primaryColor))),
              // Icon(
              //   Icons.star_border,
              //   color: Theme.of(context).primaryColor,
              //   size: 16,
              // ),
              //   ],
              // ),
              //   backgroundColor: Theme.of(context).accentColor.withOpacity(0.9),
              //   shape: StadiumBorder(),
              // ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(widget.combination.price.toString(),
                  style: Theme.of(context).textTheme.display3),
              SizedBox(width: 10),
              // Text(
              //   widget.combination.price.toString(),
              //   style: Theme.of(context)
              //       .textTheme
              //       .headline
              //       .merge(TextStyle(color: Theme.of(context).focusColor, decoration: TextDecoration.lineThrough)),
              // ),
              // SizedBox(width: 10),
              // Expanded(
              //   child: Text(
              //     '${widget.combination.amount.toString()} Sales',
              //     textAlign: TextAlign.right,
              //   ),
              // )
            ],
          ),
        ),
        Container(
          child: Text(
            'العروض' + '(${widget.combination.promotionCode.length})',
            style: TextStyle(fontSize: 28),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.9),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).focusColor.withOpacity(0.15),
                  blurRadius: 5,
                  offset: Offset(0, 2)),
            ],
          ),
          child: FutureBuilder(
              future: promotionsService
                  .getPromotions(widget.combination.promotionCode),
              builder: (context, AsyncSnapshot<List<Promotion>> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                      height: 200,
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            final promotion = snapshot.data[index];

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  promotion.priceListNameAr,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      promotion.notes,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      promotion.materialDiscountType == '%'
                                          ? '%' +
                                              promotion
                                                  .materialDiscountPercentage
                                          : promotion.materialDiscountAmount +
                                              'ريال',
                                      style: TextStyle(fontSize: 20),
                                    )
                                  ],
                                )
                              ],
                            );
                          }));
                } else if (snapshot.hasError) {
                  return Container(
                    child: Center(
                      child: Text('Error'),
                    ),
                  );
                } else {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }),
        ),
        // Container(
        //   width: double.infinity,
        //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        //   margin: EdgeInsets.symmetric(vertical: 20),
        //   decoration: BoxDecoration(
        //     color: Theme.of(context).primaryColor.withOpacity(0.9),
        //     boxShadow: [
        //       BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.15), blurRadius: 5, offset: Offset(0, 2)),
        //     ],
        //   ),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: <Widget>[
        //       Row(
        //         children: <Widget>[
        //           Expanded(
        //             child: Text(
        //               'Select Size',
        //               style: Theme.of(context).textTheme.body2,
        //             ),
        //           ),
        //           MaterialButton(
        //             onPressed: () {},
        //             padding: EdgeInsets.all(0),
        //             minWidth: 0,
        //             child: Text(
        //               'Clear All',
        //               style: Theme.of(context).textTheme.body1,
        //             ),
        //           )
        //         ],
        //       ),
        //       SizedBox(height: 10),
        //       SelectSizeWidget()
        //     ],
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        //   child: ListTile(
        //     dense: true,
        //     contentPadding: EdgeInsets.symmetric(vertical: 0),
        //     leading: Icon(
        //       UiIcons.box,
        //       color: Theme.of(context).hintColor,
        //     ),
        //     title: Text(
        //       'Related Poducts',
        //       style: Theme.of(context).textTheme.display1,
        //     ),
        //   ),
        // ),
        // FlashSalesCarouselWidget(
        //     heroTag: 'product_related_products', combinationList: widget._combinationList),
      ],
    );
  }
}

class SelectColorWidget extends StatefulWidget {
  SelectColorWidget({
    Key key,
  }) : super(key: key);

  @override
  _SelectColorWidgetState createState() => _SelectColorWidgetState();
}

class _SelectColorWidgetState extends State<SelectColorWidget> {
  ProductColorsList _productColorsList = new ProductColorsList();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(_productColorsList.list.length, (index) {
        var _color = _productColorsList.list.elementAt(index);
        return buildColor(_color);
      }),
    );
  }

  SizedBox buildColor(ProductColor color) {
    return SizedBox(
      width: 38,
      height: 38,
      child: FilterChip(
        label: Text(''),
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
        backgroundColor: color.color,
        selectedColor: color.color,
        selected: color.selected,
        shape: StadiumBorder(),
        avatar: Text(''),
        onSelected: (bool value) {
          setState(() {
            color.selected = value;
          });
        },
      ),
    );
  }
}

class SelectSizeWidget extends StatefulWidget {
  SelectSizeWidget({
    Key key,
  }) : super(key: key);

  @override
  _SelectSizeWidgetState createState() => _SelectSizeWidgetState();
}

class _SelectSizeWidgetState extends State<SelectSizeWidget> {
  ProductSizesList _productSizesList = new ProductSizesList();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(_productSizesList.list.length, (index) {
        var _size = _productSizesList.list.elementAt(index);
        return buildSize(_size);
      }),
    );
  }

  SizedBox buildSize(ProductSize size) {
    return SizedBox(
      height: 38,
      child: RawChip(
        label: Text(size.code),
        labelStyle: TextStyle(color: Theme.of(context).hintColor),
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
        backgroundColor: Theme.of(context).focusColor.withOpacity(0.05),
        selectedColor: Theme.of(context).focusColor.withOpacity(0.2),
        selected: size.selected,
        shape: StadiumBorder(
            side: BorderSide(
                color: Theme.of(context).focusColor.withOpacity(0.05))),
        onSelected: (bool value) {
          setState(() {
            size.selected = value;
          });
        },
      ),
    );
  }
}
