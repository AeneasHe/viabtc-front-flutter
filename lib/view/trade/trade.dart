import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:viabtc_front/public.dart';
import 'package:viabtc_front/view/trade/box_trade.dart';
import 'package:viabtc_front/view/trade/box_depth.dart';

class TradePage extends StatefulWidget {
  @override
  _TradePage createState() => _TradePage();
}

class _TradePage extends State<TradePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: ThemeColor.white,
          middle: Text("交易"),
          trailing: Icon(CupertinoIcons.add),
        ),
        resizeToAvoidBottomInset: false,
        child: Material(
            child: Center(
          child: Container(
              // margin: const EdgeInsets.only(top: 80),
              child: Column(children: [
            separationBoxWhite(),
            Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.format_align_left,
                        color: ThemeColor.gray, size: 18),
                    Text(
                      "BTC/USDT",
                      style: TextStyle(
                          color: ThemeColor.gray,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w900),
                    )
                  ],
                )),
            Row(children: [BoxTrade(), boxDepth()]),
            separationBoxWhite()
          ])),
        )));
  }

  Widget buildBar() {
    final Map<int, Widget> myTabs = {
      1: SizedBox(
          width: 80,
          height: 38,
          child: Text(
            '分时',
            style: TextStyle(
              color: Colors.black,
              fontSize: 17.0,
            ),
          )),
      15: SizedBox(
          width: 80,
          height: 38,
          child: Text(
            '15分',
            style: TextStyle(
              color: Colors.black,
              fontSize: 17.0,
            ),
          ))
    };
    return Container(
        height: 40,
        child: CupertinoSegmentedControl<int>(
          children: myTabs,
          pressedColor: ThemeColor.red,
          borderColor: Colors.black,
          onValueChanged: (value) {
            print(value);
          },
        ));
  }
}
