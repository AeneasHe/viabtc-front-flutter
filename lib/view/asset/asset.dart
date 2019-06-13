import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:viabtc_front/exchange/viabtc.dart';
import 'package:viabtc_front/public.dart';

class AssetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeColor.primary,
        appBar: AppBar(
          backgroundColor: ThemeColor.primary,
          title: Text("资产"), //中间标题
        ),
        body: Material(child: AssetListPage()));
  }
}

class AssetListPage extends StatefulWidget {
  @override
  _AssetListPageState createState() => new _AssetListPageState();
}

class _AssetListPageState extends State<AssetListPage> {
  int _assetType = 1;

  Widget buildTabButton() {
    return CupertinoSegmentedControl<int>(
      borderColor: ThemeColor.primary,
      selectedColor: ThemeColor.secondary,
      unselectedColor: ThemeColor.primary,
      pressedColor: ThemeColor.secondary,
      groupValue: _assetType,
      children: {
        1: Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Text(
            "币币账户",
            style: TextStyle(color: ThemeColor.white),
          ),
        ),
        2: Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(
            "合约账户",
            style: TextStyle(color: ThemeColor.white),
          ),
        ),
      },
      onValueChanged: (value) {
        setState(() {
          _assetType = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ThemeColor.primary,
        child: ListView(children: <Widget>[
          Container(
              color: ThemeColor.primary,
              child: Column(children: [
                buildAssetSummary(),
                buildOperationButton(),
              ])),
          separationBoxWhite(),
          buildTabButton(),
          separationBoxWhite(),
          buildAssetList()
        ]));
  }
}

Widget buildAssetList() {
  var assetList = [
    ['BTC', '10', '12.0', '22.0'],
    ['ETH', '100', '100.0', '200.0'],
    ['EOS', '30.0', '30.0', '60.0'],
    ['BTC', '10', '12.0', '22.0'],
    ['ETH', '100', '100.0', '200.0'],
    ['EOS', '30.0', '30.0', '60.0'],
    ['BTC', '10', '12.0', '22.0'],
    ['ETH', '100', '100.0', '200.0'],
    ['EOS', '30.0', '30.0', '60.0'],
    ['BTC', '10', '12.0', '22.0'],
    ['ETH', '100', '100.0', '200.0'],
    ['EOS', '30.0', '30.0', '60.0']
  ];
  return Container(
      color: ThemeColor.white,
      child: Column(
          children: assetList
              .map((asset) => Card(
                  margin: const EdgeInsets.only(top: 1),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(5),
                    leading: Container(
                        child: Column(children: [
                      Text(asset[0],
                          style: TextStyle(
                              color: ThemeColor.primary, fontSize: 18)),
                      Text('冻结',
                          style:
                              TextStyle(color: ThemeColor.gray, fontSize: 12)),
                      Text(asset[1],
                          style: TextStyle(
                              color: ThemeColor.primary, fontSize: 12)),
                    ])),
                    title: Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(children: [
                          Text('可用',
                              style: TextStyle(
                                  color: ThemeColor.gray, fontSize: 10)),
                          Text(asset[2],
                              style: TextStyle(
                                  color: ThemeColor.primary, fontSize: 10)),
                        ])),
                    trailing: Container(
                        child: Column(children: [
                      Image(
                        image: AssetImage("assets/icon/right-arrow.png"),
                        width: 24.0,
                        height: 24.0,
                        color: null,
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                      ),
                      Text('折合',
                          style:
                              TextStyle(color: ThemeColor.gray, fontSize: 10)),
                      Text(asset[3],
                          style: TextStyle(
                              color: ThemeColor.primary, fontSize: 10)),
                    ])),
                    onTap: () => {},
                  )))
              .toList()));
}

Widget buildOperationButton() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: FlatButton(
          color: ThemeColor.secondary,
          child: Text(
            '冲币',
            style: TextStyle(color: ThemeColor.lightGray),
          ),
          onPressed: () {},
        ),
      ),
      Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: FlatButton(
            color: ThemeColor.secondary,
            child: Text(
              '提币',
              style: TextStyle(color: ThemeColor.lightGray),
            ),
            onPressed: () {},
          )),
      Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: FlatButton(
            color: ThemeColor.secondary,
            child: Text(
              '划币',
              style: TextStyle(color: ThemeColor.lightGray),
            ),
            onPressed: () {},
          )),
    ],
  );
}

Widget buildAssetSummary() {
  return Container(
    padding: const EdgeInsets.only(left: 20, top: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '总账户资产折合(BTC)',
          style: TextStyle(color: ThemeColor.lightGray),
        ),
        separationBoxWhite(),
        Row(
          children: <Widget>[
            Text(
              '0.03',
              style: TextStyle(color: ThemeColor.lightGray),
            ),
            Text('~1590 CNY', style: TextStyle(color: ThemeColor.lightGray))
          ],
        )
      ],
    ),
  );
}
