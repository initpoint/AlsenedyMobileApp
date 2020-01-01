import 'package:ecommerce_app_ui_kit/src/models/combination.dart';
import 'package:ecommerce_app_ui_kit/src/models/product.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/ProductGridItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategorizedProductsWidget extends StatelessWidget {
  const CategorizedProductsWidget({
    Key key,
    @required this.animationOpacity,
    @required List<Combination> combinationList,
  })  : _combinationsList = combinationList,
        super(key: key);

  final Animation animationOpacity;
  final List<Combination> _combinationsList;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationOpacity,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: new StaggeredGridView.countBuilder(
          primary: false,
          shrinkWrap: true,
          crossAxisCount: 4,
          itemCount: _combinationsList.length,
          itemBuilder: (BuildContext context, int index) {
            Combination combination = _combinationsList.elementAt(index);
            return ProductGridItemWidget(
              combination: combination,
              heroTag: 'categorized_products_grid',
            );
          },
//              staggeredTileBuilder: (int index) => new StaggeredTile.count(2, index.isEven ? 2 : 1),
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 15.0,
        ),
      ),
    );
  }
}
