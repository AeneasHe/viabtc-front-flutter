import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;
import 'package:candleline/candleline.dart';
import 'package:viabtc_front/model/model.dart';
import 'dart:convert';
import 'symbol.dart';
import 'package:viabtc_front/public.dart';
import 'package:viabtc_front/exchange/viabtc.dart';

class KlinePages extends StatefulWidget {
  final Symbol symbol;
  KlinePages({Key key, @required this.symbol}) : super(key: key);
  @override
  _KlinePages createState() => _KlinePages();
}

class _KlinePages extends State<KlinePages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: ThemeColor.primary,
            title: Text(widget.symbol.title)),
        body: TabPage(symbol: widget.symbol));
  }
}

class TabPage extends StatefulWidget {
  final Symbol symbol;
  TabPage({Key key, @required this.symbol}) : super(key: key);

  @override
  _TabPage createState() => _TabPage();
}

class _TabPage extends State<TabPage> {
  int duty = 15;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFF000040),
        child: Column(
          children: <Widget>[
            separationBoxWhite(),
            Container(
                height: 45,
                child: SizedBox.expand(
                    child: CupertinoSegmentedControl<int>(
                  groupValue: duty,
                  children: {
                    1: Container(
                        child: Text(
                      '分时',
                      style: TextStyle(color: ThemeColor.gray),
                    )),
                    15: Container(
                        child: Text(
                      '15分',
                      style: TextStyle(color: ThemeColor.gray),
                    )),
                    60: Container(
                        child: Text(
                      '1小时',
                      style: TextStyle(color: ThemeColor.gray),
                    )),
                    240: Container(
                        child: Text(
                      '4小时',
                      style: TextStyle(color: ThemeColor.gray),
                    )),
                    1440: Container(
                        child: Text(
                      '日线',
                      style: TextStyle(color: ThemeColor.gray),
                    )),
                    10080: Container(
                        child: Text(
                      '周线',
                      style: TextStyle(color: ThemeColor.gray),
                    )),
                  },
                  pressedColor: Color(0xFF000040),
                  borderColor: ThemeColor.gray,
                  unselectedColor: Color(0xFF444455),
                  selectedColor: Color(0xFF00004A),
                  onValueChanged: (value) {
                    setState(() {
                      duty = value;
                    });
                  },
                ))),
            separationBoxWhite(),
            KlineOnePage(duty: duty.toString()),
          ],
        ));
  }
}

class KlineOnePage extends StatefulWidget {
  final String duty;
  KlineOnePage({Key key, @required this.duty}) : super(key: key);
  @override
  _KlineOnePage createState() => _KlineOnePage();
}

class _KlineOnePage extends State<KlineOnePage> {
  @override
  Widget build(BuildContext context) {
    KlinePageBloc bloc = KlinePageBloc(duty: widget.duty);
    bloc.setRectWidth(10.0); //设置蜡烛宽
    return Column(children: <Widget>[
      Text(widget.duty),
      Container(
          height: 500,
          margin: EdgeInsets.only(bottom: 50),
          child: KlinePage(bloc: bloc)),
    ]);
  }
}

class KlinePageBloc extends KlineBloc {
  String duty;
  KlinePageBloc({Key key, @required this.duty});

  //重写init方法
  @override
  void initData() {
    Future<Map<String, dynamic>> future = Viabtc.kline(int.parse(duty));
    future.then((value) {
      MarketData marketData = MarketData.fromJson(value);
      List<KlineData> list = List<KlineData>();
      for (var item in marketData.data) {
        list.add(KlineData(
            date: item.date,
            open: item.open,
            close: item.close,
            high: item.high,
            low: item.low,
            vol: item.vol));
      }
      //数据返回后调用 updateDataList(list);
      this.updateDataList(list, duty);
    });

    super.initData();
  }

  initDataFromMock() {
    Future<String> future = loadAsset();
    future.then((value) {
      final parseJson = json.decode(value);
      MarketData marketData = MarketData.fromJson(parseJson);
      List<KlineData> list = List<KlineData>();
      for (var item in marketData.data) {
        list.add(KlineData(
            open: item.open,
            close: item.close,
            high: item.high,
            low: item.low,
            vol: item.vol));
      }
      //数据返回后调用 updateDataList(list);
      this.updateDataList(list, duty);
    });
    super.initData();
  }
}

Future<String> loadAsset() async {
  return await rootBundle.loadString('mock/market.json');
}
