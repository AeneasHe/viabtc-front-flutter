import 'package:viabtc_front/public.dart';

class Viabtc {
  static Future<Map<String, dynamic>> kline(int period) async {
    var timestamp = new DateTime.now().millisecondsSinceEpoch;
    var limit = 30;
    // var period = 1;
    var endTime = (timestamp / 1000).ceil();
    var startTime = endTime - limit * period * 60;
    var data = {
      'method': 'market.kline',
      'params': ["ETHUSDT", startTime, endTime, period * 60],
      'id': timestamp,
    };
    var response = await Request.post(url: "", data: data);
    var _data = response['result'];
    var _result = _data
        .map((d) => {
              "date": d[0],
              "open": double.parse(d[1]),
              "high": double.parse(d[3]),
              "low": double.parse(d[4]),
              "close": double.parse(d[2]),
              "vol": double.parse(d[5])
            })
        .toList();
    return {'data': _result};
  }

  static Future<Map<String, dynamic>> depth() async {
    var timestamp = new DateTime.now().millisecondsSinceEpoch;
    var limit = 30;
    var interval = "0";
    var data = {
      'method': 'order.depth',
      'params': ["ETHUSDT", limit, interval],
      'id': timestamp,
    };
    var response = await Request.post(url: "", data: data);
    var _data = response['result'];

    var _asks = _data['asks']
        .map((d) => [double.parse(d[0]), double.parse(d[1])])
        .toList();
    var _bids = _data['bids']
        .map((d) => [double.parse(d[0]), double.parse(d[1])])
        .toList();

    return {'asks': _asks, 'bids': _bids};
  }

  static Future<Map<String, dynamic>> marketStatusToday() async {
    var timestamp = new DateTime.now().millisecondsSinceEpoch;
    var data = {
      'method': 'market.status_today',
      'params': ["ETHUSDT"],
      'id': timestamp,
    };
    var response = await Request.post(url: "", data: data);
    var _data = response['result'];

    print(_data);
    return _data;
  }
}
