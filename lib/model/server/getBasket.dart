import 'package:wideal/model/dprint.dart';
import 'package:wideal/config/api.dart';
import 'package:wideal/model/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

getBasket(String uid, Function(BasketResponse) callback,
    Function(String) callbackError) async {
  try {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': "application/json",
      'Authorization': "Bearer $uid",
    };

    String body = '{}';
    var url = "${serverPath}getBasket";
    var response = await http
        .post(Uri.parse(url), headers: requestHeaders, body: body)
        .timeout(const Duration(seconds: 30));

    dprint(url);
    dprint('Response status: ${response.statusCode}');
    dprint('Response body: ${response.body}');

    if (response.statusCode == 401) return callbackError("401");
    if (response.statusCode == 200) {
      var jsonResult = json.decode(response.body);
      if (jsonResult["error"] == "0") {
        BasketResponse ret = BasketResponse.fromJson(jsonResult);
        callback(ret);
        //callback(ret.order, ret.orderdetails, ret.currency, ret.defaultTax, ret.fee, ret.percent);
      } else
        callbackError("error=${jsonResult["error"]}");
    } else
      callbackError("statusCode=${response.statusCode}");
  } catch (ex) {
    callbackError(ex.toString());
  }
}

class BasketResponse {
  String error;
  String ver;
  String currency;
  double defaultTax;
  OrderData? order;
  List<OrderDetailsData> orderdetails;
  double fee;
  String percent;
  String perkm;

  BasketResponse(
      {required this.error,
      required this.order,
      required this.orderdetails,
      required this.currency,
      required this.defaultTax,
      required this.fee,
      required this.percent,
      required this.ver,
      required this.perkm});
  factory BasketResponse.fromJson(Map<String, dynamic> json) {
    var _order;
    if (json['order'] != null) _order = OrderData.fromJson(json['order']);
    List<OrderDetailsData> _orderdetails = [];
    if (json['orderdetails'] != null) {
      var items = json['orderdetails'];
      var t = items.map((f) => OrderDetailsData.fromJson(f)).toList();
      _orderdetails = t.cast<OrderDetailsData>().toList();
    }
    return BasketResponse(
      error: json['error'].toString(),
      defaultTax: toDouble(json['default_tax'].toString()),
      currency: json['currency'].toString(),
      order: _order,
      orderdetails: _orderdetails,
      fee: toDouble(json['fee'].toString()),
      percent: json['percent'].toString(),
      perkm: (json['perkm'] == null) ? "" : json['perkm'].toString(),
      ver: (json['ver'] == null) ? '1' : json['ver'].toString(),
    );
  }
}

class OrderData {
  String id;
  String user;
  String driver;
  String status;
  String pstatus;
  int tax;
  String hint;
  String active;
  String restaurant;
  String method;
  String total;
  String fee;

  OrderData(
      {required this.id,
      required this.user,
      required this.driver,
      required this.status,
      required this.pstatus,
      required this.tax,
      required this.hint,
      required this.active,
      required this.restaurant,
      required this.method,
      required this.total,
      required this.fee});
  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json['id'].toString(),
      user: json['user'].toString(),
      driver: json['driver'].toString(),
      status: json['status'].toString(),
      pstatus: json['pstatus'].toString(),
      tax: toInt(json['tax'].toString()),
      hint: json['hint'].toString(),
      active: json['active'].toString(),
      restaurant: json['restaurant'].toString(),
      method: json['method'].toString(),
      total: json['total'].toString(),
      fee: json['fee'].toString(),
    );
  }
}

class OrderDetailsData {
  String id;
  String order;
  String food;
  int count;
  double foodprice;
  String extras;
  String extrascount;
  String extrasprice;
  String foodid;
  String extrasid;
  String image;
  String category;

  OrderDetailsData(
      {required this.id,
      required this.order,
      required this.food,
      required this.count,
      required this.foodprice,
      required this.extras,
      required this.extrascount,
      required this.extrasprice,
      required this.foodid,
      required this.extrasid,
      required this.image,
      required this.category});
  factory OrderDetailsData.fromJson(Map<String, dynamic> json) {
    return OrderDetailsData(
      id: json['id'].toString(),
      order: json['order'].toString(),
      food: json['food'].toString(),
      count: toInt(json['count'].toString()),
      foodprice: toDouble(json['foodprice'].toString()),
      extras: json['extras'].toString(),
      extrascount: json['extrascount'].toString(),
      extrasprice: json['extrasprice'].toString(),
      foodid: json['foodid'].toString(),
      extrasid: json['extrasid'].toString(),
      image: json['image'].toString(),
      category: json['category'].toString(),
    );
  }
}
