import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:viabtc_front/public.dart';

Widget boxDepth() {
  return Center(
      child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            // color: ThemeColor.red,
          ),
          height: 400,
          width: 160,
          child: Column(children: [
            separationBoxWhite(),
            buildDepthHead('价格', '数量'),
            Column(
              children: buildDepthSell(),
            ),
            Row(children: [buildPriceInfo("9.5", "65.55")]),
            Column(
              children: buildDepthBuy(),
            )
          ])));
}

Widget buildDepthHead(String price, String volume) {
  return Row(
    children: <Widget>[
      SizedBox(height: 30, width: 60, child: Text(price)),
      SizedBox(height: 30, width: 60, child: Text(volume)),
    ],
  );
}

Widget buildPriceInfo(String price, String cnyPrice) {
  var color = getColor(price);
  return Container(
      padding: const EdgeInsets.only(top: 0, bottom: 10),
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            price,
            style: TextStyle(
                fontSize: 20, color: color, fontWeight: FontWeight.bold),
          ),
          Text(
            "～" + cnyPrice + "CNY",
            style: TextStyle(
                fontSize: 16,
                color: ThemeColor.gray,
                fontWeight: FontWeight.bold),
          ),
        ],
      )));
}

List<Widget> buildDepthSell() {
  var data = [
    ['10.6', '300.0'],
    ['10.5', '300.0'],
    ['10.4', '100.0'],
    ['10.3', '210.0'],
    ['10.2', '200.0'],
    ['10.1', '100.0']
  ];
  return data.map((d) => buildDepthItem(d[0], d[1], ThemeColor.red)).toList();
}

List<Widget> buildDepthBuy() {
  var data = [
    ['9.6', '300.0'],
    ['9.5', '100.0'],
    ['9.4', '200.0'],
    ['9.3', '200.0'],
    ['9.2', '100.0'],
    ['9.1', '200.0']
  ];
  return data.map((d) => buildDepthItem(d[0], d[1], ThemeColor.green)).toList();
}

Widget buildDepthItem(String price, String volume, Color color) {
  return Row(
    children: <Widget>[
      SizedBox(
          height: 20,
          width: 60,
          child: Text(
            price,
            style: TextStyle(color: color),
          )),
      SizedBox(height: 20, width: 60, child: Text(volume))
    ],
  );
}

Color getColor(String number) {
  var _number = double.parse(number);
  var color = ThemeColor.gray;
  if (_number > 0.0001) {
    color = ThemeColor.primary;
  } else if (_number < -0.0001) {
    color = ThemeColor.red;
  }
  return color;
}
