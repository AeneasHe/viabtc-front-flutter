import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:viabtc_front/theme.dart';
import 'package:viabtc_front/view/home/banner.dart';
import 'package:viabtc_front/view/market/symbol.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeColor.primary,
          title: Text("首页"),
        ),
        body: Material(
            child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ListView(children: [
            BannerViewPage(),
            buildTodayMarket(),
            Image.asset("assets/img/tang.jpg")
          ]),
        )));
  }
}

Widget buildTodayMarket() {
  final List<Symbol> symbolList = <Symbol>[
    new Symbol('BTC/USDT', '7681.50', '0.10'),
    new Symbol('ETH/USDT', '234.03', '-0.10'),
    new Symbol('EOS/USDT', '6.1645', '0.0001'),
  ];
  return Container(
      child: Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      buildSymbolInfo(symbolList[0]),
      buildSymbolInfo(symbolList[1]),
      buildSymbolInfo(symbolList[2])
    ],
  ));
}
