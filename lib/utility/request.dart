import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;

// 第一个版本
class Request {
  static const String baseUrl = 'http://47.91.255.154:8080';

  // Request({String baseUrl = 'http://47.91.255.154:8080'}) {
  //   this.baseUrl = baseUrl;
  // }

  static Future<dynamic> get(
      {String url,
      Map<String, dynamic> params,
      Map<String, dynamic> headers}) async {
    //return Request.mock(url: url, params: params);
    var dio = Request.createDio(headers: headers);
    Response<Map> response = await dio.get(url, queryParameters: params);
    var _data = response.data;
    return _data;
  }

  static Future<dynamic> post(
      {String url, Map data, Map<String, dynamic> headers}) async {
    //return Request.mock(url: url, params: params);
    var dio = Request.createDio(headers: headers);
    Response<Map> response = await dio.post(url, data: data);
    var _data = response.data;
    return _data;
  }

  static Future<dynamic> mock({String url, Map params, Map headers}) async {
    var responseStr = await rootBundle.loadString('mock/$url.json');
    var responseJson = json.decode(responseStr);
    return responseJson;
  }

  static Dio createDio({Map<String, dynamic> headers}) {
    var options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 10000,
        receiveTimeout: 100000,
        // contentType: ContentType.json,
        // headers: {"Accept": "application/json"},
        responseType: ResponseType.json,
        headers: headers);
    return Dio(options);
  }
}

// 第两个版本
class Requests {
  String baseUrl;

  Requests({String baseUrl = 'http://47.91.255.154:8080'}) {
    this.baseUrl = baseUrl;
  }

  Future<dynamic> get(
      {String url,
      Map<String, dynamic> params,
      Map<String, dynamic> headers}) async {
    //return Request.mock(url: url, params: params);
    var dio = this.createDio(headers: headers);
    Response<Map> response = await dio.get(url, queryParameters: params);
    var _data = response.data;
    return _data;
  }

  Future<dynamic> post(
      {String url, Map data, Map<String, dynamic> headers}) async {
    //return Request.mock(url: url, params: params);
    var dio = this.createDio(headers: headers);
    Response<Map> response = await dio.post(url, data: data);
    var _data = response.data;
    return _data;
  }

  Future<dynamic> mock({String url, Map params, Map headers}) async {
    var responseStr = await rootBundle.loadString('mock/$url.json');
    var responseJson = json.decode(responseStr);
    return responseJson;
  }

  Dio createDio({Map<String, dynamic> headers}) {
    var options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 10000,
        receiveTimeout: 100000,
        // contentType: ContentType.json,
        responseType: ResponseType.json,
        headers: headers);
    return Dio(options);
  }
}
