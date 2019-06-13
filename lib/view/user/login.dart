import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viabtc_front/public.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _user = TextEditingController();
  TextEditingController _password = TextEditingController();
  String _token = "";
  String _userName = "";

  void _login(BuildContext context) async {
    var response = await Requests(baseUrl: 'http://10.18.120.169:8080')
        .post(url: '/user/login', data: {
      'username': "jon",
      'password': "shhh",
    });
    _token = response['data']['token'];
    _saveToken(context);
  }

  _saveToken(BuildContext context) async {
    if (_token != "") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", _token);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('登录'),
          elevation: 0,
          backgroundColor: ThemeColor.primary,
        ),
        backgroundColor: Colors.white,
        body: Center(
            child: Column(children: <Widget>[
          SizedBox(height: 40),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 35),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(_userName),
                  buildInput('用户名', _user),
                  SizedBox(height: 10),
                  buildInput('密码', _password),
                  SizedBox(height: 10),
                  buildButton('登录', () => _login(context)),
                ]),
          )
        ])));
  }
}
