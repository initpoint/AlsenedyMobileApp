import 'package:ecommerce_app_ui_kit/src/models/bill_item.model.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/DrawerWidget.dart';
import 'package:flutter/material.dart';

class ShipmentItemssWidget extends StatefulWidget {
  final List<BillItem> billItems;

  const ShipmentItemssWidget({Key key, this.billItems}) : super(key: key);

  @override
  _ShipmentItemssWidgetState createState() => _ShipmentItemssWidgetState();
}

class _ShipmentItemssWidgetState extends State<ShipmentItemssWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Chat',
          style: Theme.of(context).textTheme.display1,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: ListView.separated(
              itemCount: widget.billItems.length,
              itemBuilder: (context, index) {
                final bill = widget.billItems[index];
                return Column(
                  children: <Widget>[Text(bill.nameArFull), Text(bill.tax)],
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          )
        ],
      ),
    );
  }
}
