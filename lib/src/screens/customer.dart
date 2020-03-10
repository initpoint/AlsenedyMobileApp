import 'package:ecommerce_app_ui_kit/config/ui_icons.dart';
import 'package:ecommerce_app_ui_kit/src/firebase/auth/phone_auth/get_phone.dart';
import 'package:ecommerce_app_ui_kit/src/models/customer.dart';
import 'package:ecommerce_app_ui_kit/src/services/auth.service.dart';
import 'package:ecommerce_app_ui_kit/src/services/customer.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerDataWidget extends StatefulWidget {
  @override
  _CustomerDataWidgetState createState() => _CustomerDataWidgetState();
}

class _CustomerDataWidgetState extends State<CustomerDataWidget> {
  bool _showPassword = false;
  String _email;
  String _name;
  String _company;
  String _city;

  Widget build(BuildContext context) {
    final BaseAuth auth = Provider.of<BaseAuth>(context);
    final UsersService usersRepo = UsersRepo();

    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 65, horizontal: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor.withOpacity(0.6),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                          offset: Offset(0, 10),
                          blurRadius: 20)
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 25),
                      Text('Info', style: Theme.of(context).textTheme.display3),
                      SizedBox(height: 20),
                      new TextFormField(
                        style: TextStyle(color: Theme.of(context).accentColor),
                        keyboardType: TextInputType.emailAddress,
                        decoration: new InputDecoration(
                          hintText: 'Email Address',
                          hintStyle: Theme.of(context).textTheme.body1.merge(
                                TextStyle(color: Theme.of(context).accentColor),
                              ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.2))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor)),
                          prefixIcon: Icon(
                            UiIcons.envelope,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        validator: (value) =>
                            value.isEmpty ? 'Email cannot be empty' : null,
                        onChanged: (value) {
                          _email = value.trim();
                        },
                      ),
                      SizedBox(height: 20),
                      new TextFormField(
                        style: TextStyle(color: Theme.of(context).accentColor),
                        keyboardType: TextInputType.emailAddress,
                        decoration: new InputDecoration(
                          hintText: 'Full Name',
                          hintStyle: Theme.of(context).textTheme.body1.merge(
                                TextStyle(color: Theme.of(context).accentColor),
                              ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.2))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor)),
                          prefixIcon: Icon(
                            UiIcons.envelope,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        validator: (value) =>
                            value.isEmpty ? 'Full Name cannot be empty' : null,
                        onChanged: (value) {
                          _name = value.trim();
                        },
                      ),
                      SizedBox(height: 20),
                      new TextFormField(
                        style: TextStyle(color: Theme.of(context).accentColor),
                        keyboardType: TextInputType.emailAddress,
                        decoration: new InputDecoration(
                          hintText: 'Company Name',
                          hintStyle: Theme.of(context).textTheme.body1.merge(
                                TextStyle(color: Theme.of(context).accentColor),
                              ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.2))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor)),
                          prefixIcon: Icon(
                            UiIcons.credit_card,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        validator: (value) => value.isEmpty
                            ? 'Company Name cannot be empty'
                            : null,
                        onChanged: (value) {
                          _company = value.trim();
                        },
                      ),
                      SizedBox(height: 20),
                      new TextFormField(
                        style: TextStyle(color: Theme.of(context).accentColor),
                        keyboardType: TextInputType.emailAddress,
                        decoration: new InputDecoration(
                          hintText: 'City',
                          hintStyle: Theme.of(context).textTheme.body1.merge(
                                TextStyle(color: Theme.of(context).accentColor),
                              ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.2))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor)),
                          prefixIcon: Icon(
                            UiIcons.cosmetics,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        validator: (value) =>
                            value.isEmpty ? 'City cannot be empty' : null,
                        onChanged: (value) {
                          _city = value.trim();
                        },
                      ),
                      SizedBox(height: 20),
                      FlatButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 70),
                        onPressed: () async {
                          var user = await auth.getCurrentUser();
                          var customer = Customer(
                            id: user.uid,
                              uid: user.uid,
                              fullName: _name,
                              email: _email,
                              company: _company,
                              phoneNumber: user.phoneNumber,
                              credit: '0',
                              debt: '0');
                          await usersRepo.addUser(customer);
                          Navigator.pushNamed(context, '/');
                        },
                        child: Text(
                          'DONE',
                          style: Theme.of(context).textTheme.title.merge(
                                TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                        ),
                        color: Theme.of(context).accentColor,
                        shape: StadiumBorder(),
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
            FlatButton(
              onPressed: () {},
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.title.merge(
                        TextStyle(color: Theme.of(context).primaryColor),
                      ),
                  children: [
                    TextSpan(text: 'Already have an account ?'),
                    TextSpan(
                        text: ' Sign In',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
