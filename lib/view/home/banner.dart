import 'package:flutter/material.dart';
import 'package:banner_view/banner_view.dart';
import 'package:viabtc_front/public.dart';

class BannerViewPage extends StatefulWidget {
  @override
  _BannerViewPageState createState() => new _BannerViewPageState();
}

class _BannerViewPageState extends State<BannerViewPage> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Container(
        alignment: Alignment.center,
        height: 200.0,
        child: this._bannerView(),
      ),
    );
  }

  BannerView _bannerView() {
    // var pre = 'https://raw.githubusercontent.com/yangxiaoweihn/Assets/master';
    // List<Pair<String, Color>> param = [
    //   Pair.create('$pre/cars/car_0.jpg', ThemeColor.lightGray),
    //   Pair.create('$pre/cartoons/ct_0.jpg', ThemeColor.lightGray),
    //   Pair.create('$pre/pets/cat_1.jpg', ThemeColor.lightGray),
    //   Pair.create('$pre/scenery/s_1.jpg', ThemeColor.lightGray),
    //   Pair.create('$pre/cartoons/ct_1.jpg', ThemeColor.lightGray),
    // ];

    List<Pair<String, Color>> param = [
      Pair.create('assets/img/tangyixin.jpg', ThemeColor.lightGray),
      Pair.create('assets/img/tang.jpg', ThemeColor.lightGray),
      Pair.create('assets/img/tangyixin.jpg', ThemeColor.lightGray),
      Pair.create('assets/img/tang.jpg', ThemeColor.lightGray),
    ];

    return new BannerView(
      BannerItemFactory.banners(param),
      indicatorMargin: 10.0,
      intervalDuration: Duration(seconds: 5),
      //指示条
      indicatorNormal: new Container(
        width: 5.0,
        height: 5.0,
        decoration: new BoxDecoration(
          color: ThemeColor.gray,
          shape: BoxShape.rectangle,
        ),
      ),
      //当前选中的指示条
      indicatorSelected: new Container(
        width: 15.0,
        height: 5.0,
        decoration: new BoxDecoration(
          color: ThemeColor.primary,
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.all(
            new Radius.circular(5.0),
          ),
        ),
      ),
      // //指示条样式
      // indicatorBuilder: (context, indicator) {
      //   Widget cc = new Container(
      //     padding: new EdgeInsets.symmetric(
      //       horizontal: 20.0,
      //     ),
      //     height: 44.0,
      //     width: double.infinity,
      //     color: Colors.grey[300],
      //     child: indicator,
      //   );
      //   return new Opacity(
      //     opacity: 0.5,
      //     child: cc,
      //   );
      // },
    );
  }
}

BannerView _bannerView0() {
  List<Pair<String, Color>> param = [
    Pair.create('1', Colors.red[500]),
    Pair.create('2', Colors.green[500]),
    Pair.create('3', Colors.blue[500]),
    Pair.create('4', Colors.yellow[500]),
    Pair.create('5', Colors.purple[500]),
  ];

  return new BannerView(
    BannerItemFactory.banners(param),
    intervalDuration: Duration(seconds: 5),
  );
}

class Pair<F, S> {
  F first;
  S second;
  Pair(F first, S second) {
    this.first = first;
    this.second = second;
  }
  static Pair<F, S> create<F, S>(F first, S second) {
    return new Pair(first, second);
  }
}

class BannerItemFactory {
  static List<Widget> banners(List<Pair<String, Color>> param) {
    TextStyle style = new TextStyle(
      fontSize: 70.0,
      color: Colors.white,
    );

    Widget _bannerText(Color color, String text) {
      return new Container(
        alignment: Alignment.center,
        height: double.infinity,
        color: color,
        child: new Text(
          text,
          style: style,
        ),
      );
    }

    Widget _bannerImage(Color color, String url) {
      return new Container(
        alignment: Alignment.center,
        height: double.infinity,
        color: color,
        child: new Image.network(
          url,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    Widget _bannerAsset(Color color, String url) {
      return new Container(
        alignment: Alignment.center,
        height: double.infinity,
        color: color,
        child: new Image.asset(
          url,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    List<Widget> _renderBannerItem(List<Pair<String, Color>> param) {
      return param.map((item) {
        final text = item.first;
        final color = item.second;
        if (text.startsWith('http://') || text.startsWith('https://')) {
          return _bannerImage(color, text);
        } else if (text.startsWith('assets/')) {
          return _bannerAsset(color, text);
        } else {
          _bannerText(color, text);
        }
      }).toList();
    }

    return _renderBannerItem(param);
  }
}
