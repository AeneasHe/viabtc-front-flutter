import 'package:flutter/material.dart';
//import 'package:candleline/bloc/KlineBloc.dart';
//import 'package:candleline/common/BlocProvider.dart';
//import 'package:candleline/model/KlineModel.dart';
import 'package:candleline/view/KlineCandleView.dart';
import 'package:candleline/view/KlineColumnarView.dart';
import 'package:candleline/view/KlineSolideView.dart';
import 'package:candleline/view/KlineSeparateView.dart';

class KlineSingleView extends StatelessWidget {
  KlineSingleView({
    Key key,
    @required this.type,
  });
  final int type;

  @override
  Widget build(BuildContext context) {
    if (type == 0) {
      //K线价格部分
      return Container(
        color: Color(0xFF000040), //顶部背景色
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            KlineSeparateView(type: 0), //网格线
            KlineCandleView(), //蜡烛图
            KlineSolideView(type: 0), //MA5均线
            KlineSolideView(type: 1), //MA10均线
            KlineSolideView(type: 2) //MA30均线
          ],
        ),
      );
    } else {
      //K线交易量部分
      return Container(
        color: Color(0xFF00004A), //底部背景色
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            KlineSeparateView(type: 1), //网格线
            KlineColumnarView(), //流量图
            KlineSolideView(type: 0), //MA5均线
            KlineSolideView(type: 1), //MA10均线
          ],
        ),
      );
    }
  }
}
