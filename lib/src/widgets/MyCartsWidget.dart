import 'package:ecommerce_app_ui_kit/src/models/cart.model.dart';
import 'package:ecommerce_app_ui_kit/src/services/cart.service.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/DrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCarts extends StatefulWidget {
  @override
  _MyCartsState createState() => _MyCartsState();
}

class _MyCartsState extends State<MyCarts> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final CartService cartService = Provider.of<CartService>(context);

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
          'My Carts',
          style: Theme.of(context).textTheme.display1,
        ),
      ),
      body: StreamBuilder(
          stream: cartService.getCustomerCarts(),
          builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[ 
                        Text(
                           snapshot.data[index].items.length.toString() +'  Items - ' + snapshot.data[index].totalPrice.toString() + ' USD' ,
                          style: TextStyle(fontSize: 30),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Container(child: Text('has Error'),);
            }
             else {
              return Container(child: Text('waiiiii'));
            }
          }),
    );
  }
}
