import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:viabtc_front/public.dart';
import 'package:viabtc_front/view/home/home.dart';
import 'package:viabtc_front/view/market/market.dart';
import 'package:viabtc_front/view/trade/trade.dart';
import 'package:viabtc_front/view/asset/asset.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ViaBTC',
      theme: ThemeData.light(), //浅色主题
      home: TopPage(),
    );
  }
}

class TopPage extends StatefulWidget {
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      //底部选项卡
      tabBar: CupertinoTabBar(
        currentIndex: 2,
        backgroundColor: CupertinoColors.lightBackgroundGray,
        activeColor: ThemeColor.primary,
        items: [
          BottomNavigationBarItem(
            title: Text('首页'),
            icon: Image(
              image: AssetImage("assets/icon/home.png"),
              width: 28.0,
              height: 28.0,
              color: null,
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
            ),
            activeIcon: Image(
              image: AssetImage("assets/icon/home-active.png"),
              width: 28.0,
              height: 28.0,
              color: ThemeColor.primary,
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
            ),
          ),
          BottomNavigationBarItem(
            title: Text('行情'),
            icon: Image(
              image: AssetImage("assets/icon/quotations.png"),
              width: 28.0,
              height: 28.0,
              color: null,
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
            ),
            activeIcon: Image(
              image: AssetImage("assets/icon/quotations-active.png"),
              width: 28.0,
              height: 28.0,
              color: ThemeColor.primary,
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
            ),
          ),
          BottomNavigationBarItem(
            title: Text('交易'),
            icon: Image(
              image: AssetImage("assets/icon/trade.png"),
              width: 28.0,
              height: 28.0,
              color: null,
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
            ),
            activeIcon: Image(
              image: AssetImage("assets/icon/trade-active.png"),
              width: 28.0,
              height: 28.0,
              color: ThemeColor.primary,
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
            ),
          ),
          BottomNavigationBarItem(
            title: Text('资产'),
            icon: Image(
              image: AssetImage("assets/icon/asset.png"),
              width: 28.0,
              height: 28.0,
              color: null,
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
            ),
            activeIcon: Image(
              image: AssetImage("assets/icon/asset-active.png"),
              width: 28.0,
              height: 28.0,
              color: ThemeColor.primary,
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        //选项卡绑定的视图
        return CupertinoTabView(
          builder: (context) {
            switch (index) {
              case 0:
                return HomePage();
                break;
              case 1:
                return MarketPage();
                break;
              case 2:
                return TradePage();
                break;
              case 3:
                return AssetPage();
                break;
              default:
                return Container();
            }
          },
        );
      },
    );
  }
}
