import 'package:flutter/material.dart';
import 'package:viabtc_front/public.dart';

class Symbol {
  final String title;
  final String price;
  final String percent;
  Symbol(this.title, this.price, this.percent);
}

//绿涨红跌框
Widget buildColorBox(String number) {
  var _number = double.parse(number);
  var color = ThemeColor.gray;
  if (_number > 0.0001) {
    color = ThemeColor.primary;
  } else if (_number < -0.0001) {
    color = ThemeColor.red;
  }
  var title = (_number * 100).toString() + '%';
  if (_number > 0) {
    title = '+' + title;
  }
  return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
      height: 35,
      width: 80,
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Color(0xffffffff)),
        ),
      ));
}

//交易对行情信息
Widget buildSymbolInfo(Symbol symbol) {
  var _percent = double.parse(symbol.percent);
  var color = ThemeColor.gray;
  if (_percent > 0.0001) {
    color = ThemeColor.primary;
  } else if (_percent < -0.0001) {
    color = ThemeColor.red;
  }
  var title = (_percent * 100).toString() + '%';
  if (_percent > 0) {
    title = '+' + title;
  }

  return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
      height: 130,
      width: 130,
      child: Center(
          child: Column(
        children: <Widget>[
          Text(
            symbol.title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                color: ThemeColor.darkGray,
                fontWeight: FontWeight.w600),
          ),
          separationBoxWhite(),
          Text(
            symbol.price,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24, color: color, fontWeight: FontWeight.bold),
          ),
          separationBoxWhite(),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: color),
          ),
        ],
      )));
}

//交易对行情信息
Widget buildSymbolInfo2(Symbol symbol) {
  var _percent = double.parse(symbol.percent);
  var color = ThemeColor.gray;
  if (_percent > 0.0001) {
    color = ThemeColor.primary;
  } else if (_percent < -0.0001) {
    color = ThemeColor.red;
  }
  var title = (_percent * 100).toString() + '%';
  if (_percent > 0) {
    title = '+' + title;
  }

  return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
      height: 60,
      width: 200,
      child: Center(
          child: Column(
        children: <Widget>[
          Text(
            symbol.price,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12, color: color, fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: color),
          ),
        ],
      )));
}

//交易对行情信息
Widget buildSymbolVolume(Symbol symbol) {
  var color = ThemeColor.gray;
  return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
      height: 160,
      width: 130,
      child: Center(
          child: Column(
        children: <Widget>[
          Text(
            "高10",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24, color: color, fontWeight: FontWeight.bold),
          ),
          separationBoxWhite(),
          Text(
            "低9",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: color),
          ),
        ],
      )));
}
