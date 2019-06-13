import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:viabtc_front/public.dart';
import 'symbol.dart';
import 'kline.dart';

class MarketPage extends StatefulWidget {
  @override
  _MarketPage createState() => _MarketPage();
}

class _MarketPage extends State<MarketPage> {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'USDT'),
    Tab(text: 'BTC'),
    Tab(text: 'ETH'),
    Tab(text: 'CNY'),
  ];

  @override
  Widget build(BuildContext context) {
    final List<Symbol> symbolList = <Symbol>[
      new Symbol('BTC/USDT', '4000', '0.10'),
      new Symbol('ETH/USDT', '4000', '-0.10'),
      new Symbol('PFC/USDT', '4000', '0.0'),
      new Symbol('EOS/USDT', '4000', '0.05'),
    ];

    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("行情"),
        ),
        child: MaterialApp(
          home: DefaultTabController(
            length: myTabs.length,
            child: Scaffold(
              appBar: AppBar(
                //添加导航栏
                backgroundColor: Colors.white,
                bottom: TabBar(
                  tabs: myTabs,
                  labelColor: ThemeColor.primary,
                  indicatorColor: ThemeColor.primary,
                ),
              ),
              //添加导航视图
              body: TabBarView(
                children: myTabs.map((Tab tab) {
                  return SymbolListPage(
                    symbols: symbolList,
                  );
                }).toList(),
              ),
            ),
          ),
        ));
  }
}

//每个区的交易对列表
class SymbolListPage extends StatelessWidget {
  final List<Symbol> symbols;
  SymbolListPage({Key key, @required this.symbols}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: symbols.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(symbols[index].title),
            title: Center(child: Text(symbols[index].price)),
            trailing: buildColorBox(symbols[index].percent),
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                    builder: (context) => KlinePages(symbol: symbols[index])),
              );
            },
          );
        });
  }
}
