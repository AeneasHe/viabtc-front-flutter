import 'package:flutter/material.dart';
import 'package:candleline/bloc/KlineBloc.dart';
import 'package:candleline/common/BlocProvider.dart';
import 'package:candleline/model/KlineModel.dart';
import 'package:flutter/foundation.dart';
import 'package:date_format/date_format.dart';

//网格线
class KlineSeparateView extends StatelessWidget {
  KlineSeparateView({Key key, @required this.type});
  final int type; //0为蜡烛图网格，1为流量图网格

  @override
  Widget build(BuildContext context) {
    KlineBloc klineBloc = BlocProvider.of<KlineBloc>(context);
    return StreamBuilder(
        stream: klineBloc.outCurrentKlineList,
        builder: (BuildContext context, AsyncSnapshot<List<Market>> snapshot) {
          List<Market> tmpList = snapshot.data ?? [Market(0, 0, 0, 0, 0, 0)];
          return CustomPaint(
              size: Size.infinite,
              painter: _SeparateViewPainter(
                type: type,
                data: tmpList,
                // data: klineList,
                lineWidth: 0.5,
                rectWidth: klineBloc.rectWidth,
                klineDuty: klineBloc.klineDuty,
                dateMax: klineBloc.dateMax,
                dateMin: klineBloc.dateMin,
                max: klineBloc.priceMax,
                min: klineBloc.priceMin,
                maxVolume: klineBloc.volumeMax,
                ma: [
                  klineBloc.priceMa1,
                  klineBloc.priceMa2,
                  klineBloc.priceMa3,
                  klineBloc.volumeMa1,
                  klineBloc.volumeMa2
                ],
                lineColor: new Color.fromRGBO(255, 255, 255, 0.4), //网格线颜色透明度
              ));
        });
  }
}

class _SeparateViewPainter extends CustomPainter {
  _SeparateViewPainter(
      {Key key,
      @required this.data,
      @required this.klineDuty,
      @required this.dateMax,
      @required this.dateMin,
      @required this.max,
      @required this.min,
      @required this.maxVolume,
      @required this.ma,
      @required this.rectWidth,
      this.lineWidth = 1.0,
      this.lineColor = Colors.grey,
      this.type});

  final List<Market> data;
  final double lineWidth;
  final Color lineColor;
  final String klineDuty;
  final int dateMax;
  final int dateMin;
  final double max;
  final double min;
  final double maxVolume;
  final List<double> ma;
  final double rectWidth;
  final int type;

  @override
  void paint(Canvas canvas, Size size) {
    if (max == null || min == null) {
      return;
    }

    if (type == 0) {
      drawPriceLine(canvas, size); //价格线
    } else {
      drawVolumeLine(canvas, size); //交易量线
    }
  }

  drawText(Canvas canvas, Offset offset, String text,
      {Color color = Colors.grey}) {
    TextPainter textPainter = new TextPainter(
        text: new TextSpan(
            text: text,
            style: new TextStyle(
                color: color, fontSize: 10.0, fontWeight: FontWeight.normal)),
        textDirection: TextDirection.ltr);
    textPainter.layout();
    textPainter.paint(canvas, offset);
  }

  drawPriceLine(Canvas canvas, Size size) {
    const double h0 = 20; //从上往下的起始偏移
    double height = size.height - h0; //绘图位置
    double width = size.width;

    Paint linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth;

    //水平线，从上往下
    double heightOffset = height / 4;
    canvas.drawLine(Offset(0, h0), Offset(width, h0), linePaint); //第1根
    canvas.drawLine(Offset(0, heightOffset + h0),
        Offset(width, heightOffset + h0), linePaint); //第2根
    canvas.drawLine(Offset(0, heightOffset * 2 + h0),
        Offset(width, heightOffset * 2 + h0), linePaint); //第3根
    canvas.drawLine(Offset(0, heightOffset * 3 + h0),
        Offset(width, heightOffset * 3 + h0), linePaint); //第4根
    canvas.drawLine(Offset(0, height - 1 + h0), Offset(width, height - 1 + h0),
        linePaint); //第5根

    String _ma5 = ma[0] == null ? '' : ma[0].toStringAsPrecision(5);
    String _ma10 = ma[1] == null ? '' : ma[1].toStringAsPrecision(5);
    String _ma30 = ma[2] == null ? '' : ma[2].toStringAsPrecision(5);

    drawText(canvas, Offset(10, 0), 'MA5:' + _ma5, color: Colors.yellow);
    drawText(canvas, Offset(90, 0), 'MA10:' + _ma10, color: Colors.greenAccent);
    drawText(canvas, Offset(170, 0), 'MA30:' + _ma30, color: Colors.purple);

    //水平标签
    double priceOffset = (max - min) / 4;
    double origin = width - max.toStringAsPrecision(7).length * 6; //标签水平左偏移

    drawText(canvas, Offset(origin, h0 + 5), max.toStringAsPrecision(7));
    drawText(canvas, Offset(origin, heightOffset + h0 + 5),
        (min + priceOffset * 3).toStringAsPrecision(7));
    drawText(canvas, Offset(origin, heightOffset * 2 + h0 + 5),
        (min + priceOffset * 2).toStringAsPrecision(7));
    drawText(canvas, Offset(origin, heightOffset * 3 + h0 + 5),
        (min + priceOffset).toStringAsPrecision(7));
    drawText(
        canvas, Offset(origin, height + h0 - 20), min.toStringAsPrecision(7));

    int count = (data.length ~/ 4).toInt() + 1;

    //最多几条线
    int maxLineNumber = 0;
    if (data.length < 4) {
      maxLineNumber = 4;
    }

    //竖直线
    for (var i = 4; i >= maxLineNumber; i--) {
      canvas.drawLine(Offset((i * count - 1.5) * rectWidth, 15),
          Offset((i * count - 1.5) * rectWidth, height + h0), linePaint);
    }
  }

  drawVolumeLine(Canvas canvas, Size size) {
    const double h0 = 20; //从上往下的起始偏移

    double height = size.height - h0;
    double width = size.width;

    Paint linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth;

    int count = (data.length ~/ 4).toInt() + 1;

    double heightOffset = height / 2;
    //水平线
    //canvas.drawLine(Offset(0, h0), Offset(width, h0), linePaint);
    canvas.drawLine(Offset(0, 2 * heightOffset + h0),
        Offset(width, 2 * heightOffset + h0), linePaint);
    //水平标签
    double origin = width - max.toStringAsPrecision(7).length * 6;
    drawText(canvas, Offset(origin, 5), maxVolume.toStringAsPrecision(7));

    String _ma5 = ma[3] == null ? '' : ma[3].toStringAsPrecision(5);
    String _ma10 = ma[4] == null ? '' : ma[4].toStringAsPrecision(5);

    drawText(canvas, Offset(10, 0), 'MA5:' + _ma5, color: Colors.yellow);
    drawText(canvas, Offset(90, 0), 'MA10:' + _ma10, color: Colors.greenAccent);

    int dateOffset = ((dateMax - dateMin) / 4).ceil();
    //绘制竖线及时间轴
    DateTime _date;

    //最多几条线
    int maxLineNumber = 0;
    if (data.length < 4) {
      maxLineNumber = 4;
    }
    // print(count);
    for (var i = 4; i >= maxLineNumber; i--) {
      canvas.drawLine(Offset((i * count - 1.5) * rectWidth, 0),
          Offset((i * count - 1.5) * rectWidth, height + h0), linePaint);

      _date = DateTime.fromMillisecondsSinceEpoch(
          (dateMin + i * dateOffset) * 1000);
      String _dateS = myFormatDate(_date, klineDuty);
      drawText(
          canvas,
          Offset(
              (i * count - 1.5) * rectWidth - _dateS.length * 3, height + h0),
          _dateS);
    }
  }

  @override
  bool shouldRepaint(_SeparateViewPainter old) {
    return data != null;
  }
}

String myFormatDate(DateTime date, String duty) {
  int _duty;
  if (duty != null) {
    _duty = int.parse(duty);
  } else {
    _duty = 1;
  }

  if (_duty < 5) {
    return formatDate(date, [HH, ':', nn]);
  } else if (_duty >= 1440) {
    return formatDate(date, [mm, '-', dd]);
  } else {
    return formatDate(date, [mm, '-', dd, ' ', HH, ':', nn]);
  }
}
