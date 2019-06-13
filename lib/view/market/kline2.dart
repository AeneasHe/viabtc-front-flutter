import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;
import 'package:candleline/candleline.dart';
import 'package:viabtc_front/model/model.dart';
import 'dart:convert';
import 'symbol.dart';
import 'package:viabtc_front/public.dart';

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
            backgroundColor: ThemeColor.blue, title: Text(widget.symbol.title)),
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
  final List<Tab> myTabs = <Tab>[
    Tab(text: '分时'),
    Tab(text: '15分'),
    Tab(text: '1小时'),
    Tab(text: '4小时'),
    Tab(text: '日线'),
    Tab(text: '周线'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      //标签导航
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          leading: Container(),
          title: buildSymbolInfo2(widget.symbol),
          bottom: TabBar(
            labelPadding: EdgeInsets.all(0),
            tabs: myTabs,
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: myTabs.map((Tab tab) {
            return KlineOnePage(duty: tab.text);
          }).toList(),
        ),
      ),
    );
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
    KlinePageBloc bloc = KlinePageBloc();
    bloc.setRectWidth(10); //设置蜡烛宽
    return CupertinoPageScaffold(
        // navigationBar: CupertinoNavigationBar(
        //   middle: Text(widget.duty),
        // ),
        child: Center(
            child: Container(
                margin: EdgeInsets.only(bottom: 50),
                child: KlinePage(bloc: bloc))));
  }
}

class KlinePageBloc extends KlineBloc {
  @override
  //重写init方法
  void initData() {
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
      this.updateDataList(list, "1");
    });
    super.initData();
  }
}

Future<String> loadAsset() async {
  return await rootBundle.loadString('mock/market.json');
}
