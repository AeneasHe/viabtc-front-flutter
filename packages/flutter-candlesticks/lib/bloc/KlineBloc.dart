import 'package:rxdart/rxdart.dart';
import 'package:candleline/common/BlocProvider.dart';
import 'package:candleline/model/KlineModel.dart';
import 'package:candleline/manager/KlineDataCalculateManager.dart';
import 'dart:math';
import 'package:candleline/model/KlineData.dart';

class KlineBloc extends BlocBase {
  BehaviorSubject<List<Market>> _klineListController =
      BehaviorSubject<List<Market>>();
  PublishSubject<List<Market>> _klineCurrentListController =
      PublishSubject<List<Market>>();

  Sink<List<Market>> get _inklineList => _klineListController.sink;
  Stream<List<Market>> get outklineList => _klineListController.stream;

  Sink<List<Market>> get _inCurrentKlineList =>
      _klineCurrentListController.sink;
  Stream<List<Market>> get outCurrentKlineList =>
      _klineCurrentListController.stream;

  //存储要画图的局部k线数据
  List<Market> klineList = List();
  //存储所有的k线数据
  List<Market> stringList = List();
  //k线周期
  String klineDuty;

  //当前k线滑到的位置
  int currentIndex = 0;
  //当前线宽
  double rectWidth = 7.0;
  double screenWidth = 375;

  //当前显示的最大最小值数据
  int dateMax;
  int dateMin;
  double priceMax;
  double priceMin;
  double volumeMax;
  double priceMa1;
  double priceMa2;
  double priceMa3;
  double volumeMa1;
  double volumeMa2;

  KlineBloc() {
    initData();
  }

  void initData() {}
  @override
  void dispose() {
    _klineListController.close();
  }

  void updateDataList(List<KlineData> dataList, String duty) {
    if (dataList != null && dataList.length > 0) {
      stringList.clear();
      for (var item in dataList) {
        Market data = Market(
            item.date, item.open, item.high, item.low, item.close, item.vol);
        stringList.add(data);
      }
      //计算Ma均线
      stringList = KlineDataCalculateManager.calculateKlineData(
          ChartType.MA, stringList);
      _inklineList.add(stringList);
      klineDuty = duty;
    }
  }

  //设置屏幕宽
  void setScreenWith(double width) {
    screenWidth = width;
    double count = screenWidth / rectWidth;
    int num = count.toInt();
    getSubKlineList(0, num);
  }

//从数据集中取出局部数据
  void getSubKlineList(int from, int to) {
    List<Market> list = this.stringList;
    //var sublist = list.sublist(from, to - 1);
    if (to > list.length) {
      to = list.length;
    }
    var sublist = list.sublist(from, to);
    klineList = sublist;
    calculateLimit();
    _inCurrentKlineList.add(klineList);
  }

  //设置蜡烛宽
  void setRectWidth(double width) {
    if (width > 25.0 || width < 2.0) {
      return;
    }
    rectWidth = width;
  }

  //计算最大最小值
  void calculateLimit() {
    int _dateMax = 0;
    int _dateMin = 9999999999999;
    double _priceMax = -double.infinity;
    double _priceMin = double.infinity;
    double _volumeMax = -double.infinity;
    int ln = klineList.length - 1;
    for (var i in klineList) {
      _volumeMax = max(i.volumeto, _volumeMax);
      _dateMax = max(_dateMax, i.date);
      _dateMin = min(_dateMin, i.date);
      _priceMax = max(_priceMax, i.high);
      _priceMin = min(_priceMin, i.low);

      if (i.priceMa1 != null) {
        _priceMax = max(_priceMax, i.priceMa1);
        _priceMin = min(_priceMin, i.priceMa1);
      }
      if (i.priceMa2 != null) {
        _priceMax = max(_priceMax, i.priceMa2);
        _priceMin = min(_priceMin, i.priceMa2);
      }
      if (i.priceMa3 != null) {
        _priceMax = max(_priceMax, i.priceMa3);
        _priceMin = min(_priceMin, i.priceMa3);
      }
    }
    dateMax = _dateMax;
    dateMin = _dateMin;
    priceMax = _priceMax;
    priceMin = _priceMin;
    volumeMax = _volumeMax;
    if (ln > 0) {
      priceMa1 = klineList[ln].priceMa1;
      priceMa2 = klineList[ln].priceMa2;
      priceMa2 = klineList[ln].priceMa3;
      volumeMa1 = klineList[ln].volMa1;
      volumeMa2 = klineList[ln].volMa2;
    } else {
      priceMa1 = 0;
      priceMa2 = 0;
      priceMa2 = 0;
      volumeMa1 = 0;
      volumeMa2 = 0;
    }
  }
}
