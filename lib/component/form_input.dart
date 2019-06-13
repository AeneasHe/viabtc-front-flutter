import 'package:flutter/material.dart';
import 'package:viabtc_front/public.dart';

//表单组件

//输入
Widget buildInput(String title, TextEditingController value) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      color: ThemeColor.paper,
      borderRadius: BorderRadius.circular(5),
    ),
    child: TextField(
      controller: value,
      style: TextStyle(fontSize: 14, color: ThemeColor.darkGray),
      decoration: InputDecoration(
        hintText: title,
        hintStyle: TextStyle(color: ThemeColor.gray),
        border: InputBorder.none,
      ),
    ),
  );
}

//按钮
Widget buildButton(String title, action) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: ThemeColor.primary,
    ),
    height: 40,
    child: FlatButton(
      onPressed: () {
        action();
      },
      child: Text(
        title,
        style: TextStyle(fontSize: 16, color: ThemeColor.white),
      ),
    ),
  );
}

Widget longButton(String title, action) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: ThemeColor.primary,
    ),
    height: 40,
    child: SizedBox.expand(
        child: FlatButton(
      onPressed: action,
      child: Text(
        title,
        style: TextStyle(fontSize: 16, color: Color(0xffffffff)),
      ),
    )),
  );
}

//盒子
Widget buildBox(String title) {
  return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ThemeColor.primary,
      ),
      height: 35,
      width: 80,
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: ThemeColor.primary),
        ),
      ));
}

//分割线
Widget separationLine() {
  return Container(
    height: 1,
    color: ThemeColor.lightGray,
    margin: EdgeInsets.only(left: 60),
  );
}

//分割线
Widget separationVeticalLine() {
  return Container(
    height: 1,
    color: ThemeColor.lightGray,
    margin: EdgeInsets.only(left: 60),
  );
}

//分割box
Widget separationBox() {
  return Container(
    height: 10,
    color: ThemeColor.lightGray,
  );
}

//分割box
Widget separationBoxWhite() {
  return Container(
    height: 10,
  );
}

Widget buildCell(String title, String iconName, VoidCallback onPressed) {
  return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              color: ThemeColor.white,
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: <Widget>[
                  Image.asset(iconName),
                  SizedBox(width: 30),
                  Text(title, style: TextStyle(fontSize: 18)),
                  Expanded(child: Container()),
                  Image.asset(
                    'assets/arrow_right.png',
                    color: ThemeColor.golden,
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
}
