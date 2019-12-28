import 'package:ecommerce_app_ui_kit/config/ui_icons.dart';
import 'package:ecommerce_app_ui_kit/src/services/auth.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_localizations.dart';

class SignInWidget extends StatefulWidget {
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  bool _showPassword = false;
  bool _loginError = false;
  String _email;
  String _password;
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final BaseAuth auth = Provider.of<BaseAuth>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.2),
                              offset: Offset(0, 10),
                              blurRadius: 20)
                        ]),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 25),
                        Text(AppLocalizations.of(context).translate('sign_in'),
                            style: Theme.of(context).textTheme.display3),
                        SizedBox(height: 20),
                        new TextFormField(
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                          keyboardType: TextInputType.emailAddress,
                          decoration: new InputDecoration(
                            hintText: AppLocalizations.of(context)
                                .translate('email_placeholder'),
                            hintStyle: Theme.of(context).textTheme.body1.merge(
                                  TextStyle(
                                      color: Theme.of(context).accentColor),
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
                              value.isEmpty ? AppLocalizations.of(context)
                                .translate('email_can_not_be_empty') : null,
                          onChanged: (value) {
                            _email = value.trim();
                          },
                        ),
                        SizedBox(height: 20),
                        new TextFormField(
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                          keyboardType: TextInputType.text,
                          obscureText: !_showPassword,
                          decoration: new InputDecoration(
                            hintText: AppLocalizations.of(context)
                                .translate('password_placeholder'),
                            hintStyle: Theme.of(context).textTheme.body1.merge(
                                  TextStyle(
                                      color: Theme.of(context).accentColor),
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
                              UiIcons.padlock_1,
                              color: Theme.of(context).accentColor,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.4),
                              icon: Icon(_showPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                          validator: (value) =>
                              value.isEmpty ? 
                            AppLocalizations.of(context)
                                .translate('password_can_not_be_empty') : null,
                          onChanged: (value) {
                            _password = value.trim();
                          },
                        ),
                        SizedBox(height: 20),
                        FlatButton(
                          onPressed: () {},
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('forgot_password'),
                            style: Theme.of(context).textTheme.body1,
                          ),
                        ),
                        SizedBox(height: 30),
                        FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 70),
                          child: Text(
                            'Login',
                            style: Theme.of(context).textTheme.title.merge(
                                  TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                          ),
                          color: Theme.of(context).accentColor,
                          shape: StadiumBorder(),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              try {
                                var userId =
                                    await auth.signIn(_email, _password);
                                if (userId != null) {
                                  Navigator.of(context).pushNamed('/');
                                }
                              } catch (e) {
                                setState(() {
                                  _loginError = true;
                                });
                              }
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        Text(
                          _loginError
                              ? AppLocalizations.of(context)
                                  .translate('login_error')
                              : '',
                          style: TextStyle(color: Colors.red),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            FlatButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('customer1'),
                                style: Theme.of(context).textTheme.title.merge(
                                      TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                              ),
                              color: Theme.of(context).accentColor,
                              shape: StadiumBorder(),
                              onPressed: () async {
                                try {
                                  var userId = await auth.signIn(
                                      'customer1@mailinator.com', '123456');
                                  if (userId != null) {
                                    Navigator.of(context).pushNamed('/');
                                  }
                                } catch (e) {
                                  setState(() {
                                    _loginError = true;
                                  });
                                }
                              },
                            ),
                            SizedBox(width: 15),
                            FlatButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('customer2'),
                                style: Theme.of(context).textTheme.title.merge(
                                      TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                              ),
                              color: Theme.of(context).accentColor,
                              shape: StadiumBorder(),
                              onPressed: () async {
                                try {
                                  var userId = await auth.signIn(
                                      'customer2@mailinator.com', '123456');
                                  if (userId != null) {
                                    Navigator.of(context).pushNamed('/');
                                  }
                                } catch (e) {
                                  setState(() {
                                    _loginError = true;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                      // SizedBox(height: 20),
                      // new SocialMediaWidget()
                    ),
                  ),
                ],
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/SignUp');
                },
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.title.merge(
                          TextStyle(color: Theme.of(context).primaryColor),
                        ),
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)
                            .translate('do_not_have_account'),
                      ),
                      TextSpan(
                          text:
                              AppLocalizations.of(context).translate('sign_up'),
                          style: TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
