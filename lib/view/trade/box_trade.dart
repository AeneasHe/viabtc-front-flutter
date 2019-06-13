import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:viabtc_front/public.dart';
import 'package:viabtc_front/view/user/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoxTrade extends StatefulWidget {
  @override
  _BoxTradeState createState() => _BoxTradeState();
}

class _BoxTradeState extends State<BoxTrade> {
  String _side = "buy";
  bool _isLogin = false;
  double _value = 20.0;
  Color _color = ThemeColor.green;

  @override
  void initState() {
    super.initState();
    _getToken(); //异步初始化
  }

  Widget buildTabBuySell() {
    return Row(children: [
      FlatButton(
        padding: const EdgeInsets.all(0),
        child: ClipPath(
          clipper: ClipperLeft(),
          child: SizedBox(
              height: 40,
              width: 100,
              child: Container(
                  color: ThemeColor.green,
                  child: Center(
                      child: Text('Buy',
                          style: TextStyle(
                              color: ThemeColor.paper,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold))))),
        ),
        onPressed: () => {
              setState(() {
                _side = "buy";
                _color = ThemeColor.green;
              })
            },
      ),
      FlatButton(
        padding: const EdgeInsets.all(0),
        child: ClipPath(
          clipper: ClipperRight(),
          child: SizedBox(
              height: 40,
              width: 100,
              child: Container(
                  color: ThemeColor.red,
                  child: Center(
                      child: Text(
                    'Sell',
                    style: TextStyle(
                        color: ThemeColor.paper,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold),
                  )))),
        ),
        onPressed: () => {
              setState(() {
                _side = "sell";
                _color = ThemeColor.red;
              })
            },
      )
    ]);
  }

  Widget selectButton() {
    if (_isLogin) {
      return buildBuySellButton();
    } else {
      return buildLoginButton();
    }
  }

  Widget buildBuySellButton() {
    var title = "买入";
    if (_side == "sell") {
      title = "卖出";
    }
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: _color,
        ),
        height: 45,
        child: SizedBox.expand(
          child: FlatButton(
            onPressed: () {
              _login(context);
            },
            child: Text(
              title,
              style: TextStyle(fontSize: 16, color: ThemeColor.white),
            ),
          ),
        ));
  }

  Widget buildLoginButton() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: _color,
        ),
        height: 45,
        child: SizedBox.expand(
          child: FlatButton(
            onPressed: () {
              _login(context);
              setState(() {
                _isLogin = true;
              });
            },
            child: Text(
              "登录",
              style: TextStyle(fontSize: 16, color: ThemeColor.white),
            ),
          ),
        ));
  }

  void _login(BuildContext context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (token != null && token != '') {
      _isLogin = true;
    } else {
      _isLogin = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _price = TextEditingController();
    TextEditingController _volume = TextEditingController();

    return Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          // color: ThemeColor.gray,
        ),
        height: 400,
        width: 250,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          separationBoxWhite(),
          buildTabBuySell(),
          separationBoxWhite(),
          Row(children: [
            FlatButton(
              child: Text('限价'),
              onPressed: () => _showBotton(context),
            )
          ]),
          separationBoxWhite(),
          buildPriceInput('400.0', _price),
          separationBoxWhite(),
          buildVolumeInput('40', _volume),
          separationBoxWhite(),
          Slider(
            value: _value,
            activeColor: _color,
            inactiveColor: ThemeColor.lightGray,
            min: 0.0,
            max: 100.0,
            divisions: 5,
            onChanged: (double newValue) {
              setState(() {
                _value = newValue;
              });
            },
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: <Widget>[
                SizedBox(height: 20, width: 100, child: Text('0.0')),
                SizedBox(
                    height: 20,
                    width: 110,
                    child: Text(
                      '100.0USDT',
                      textAlign: TextAlign.right,
                    ))
              ],
            ),
          ),
          separationBoxWhite(),
          Container(
              padding: const EdgeInsets.only(left: 10),
              child: Text('volume: ${_value.toStringAsFixed(1)}')),
          separationBoxWhite(),
          selectButton(),
        ]));
  }

  void _showBotton(BuildContext context) {
    showCupertinoModalPopup<int>(
        context: context,
        builder: (context) {
          var dialog = CupertinoActionSheet(
            cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context, 0);
                },
                child: Text("取消")),
            actions: <Widget>[
              CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context, 1);
                  },
                  child: Text('限价')),
              CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context, 2);
                  },
                  child: Text('市价')),
            ],
          );
          return dialog;
        });
  }
}

Widget buildPriceInput(String title, TextEditingController value) {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: ThemeColor.paper,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(children: [
        SizedBox(
            height: 38,
            width: 150,
            child: TextField(
              controller: value,
              style: TextStyle(fontSize: 14, color: ThemeColor.darkGray),
              decoration: InputDecoration(
                hintText: title,
                hintStyle: TextStyle(color: ThemeColor.gray),
                border: InputBorder.none,
              ),
            )),
        Icon(
          Icons.add,
          color: ThemeColor.gray,
        ),
        Icon(
          Icons.remove,
          color: ThemeColor.gray,
        ),
      ]));
}

Widget buildVolumeInput(String title, TextEditingController value) {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: ThemeColor.paper,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(children: [
        SizedBox(
            height: 38,
            width: 150,
            child: TextField(
              controller: value,
              style: TextStyle(fontSize: 14, color: ThemeColor.darkGray),
              decoration: InputDecoration(
                hintText: title,
                hintStyle: TextStyle(color: ThemeColor.gray),
                border: InputBorder.none,
              ),
            )),
        Text('USDT')
      ]));
}

class ClipperLeft extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width * 0.8, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class ClipperRight extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.2, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
