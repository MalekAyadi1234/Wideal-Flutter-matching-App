import 'package:flutter/material.dart';
import 'package:wideal/config/api.dart';
import 'package:wideal/main.dart';
import 'package:wideal/model/server/arrived.dart';
import 'package:wideal/model/server/cancel.dart';
import 'package:wideal/model/server/getOrders.dart';
import 'package:wideal/ui/main/home/home.dart';
import 'package:wideal/ui/main/orders/orders.dart';
import 'package:wideal/widget/easyDialog2.dart';
import 'package:wideal/widget/ibutton3.dart';
import 'package:wideal/widget/skinRoute.dart';
import '../mainscreen.dart';
import 'map.dart';
import 'widgets.dart';

class OrderDetailsScreen extends StatefulWidget {
  final Function(String) onBack;
  OrderDetailsScreen({Key? key, required this.onBack}) : super(key: key);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  _arrived() {
    _waits(true);
    curbSidePickupArrived(idOrder, account.token, _arrivedSuccess, _error);
  }

  _cancel() {
    _waits(true);
    cancelOrder(idOrder, account.token, _cancelSuccess, _error);
  }

  _openCancel() {
    _dialogBody = Column(
      children: [
        Text(
          strings.get(320),
          style: theme.text14,
        ),

        /// "Are you sure?",
        SizedBox(
          height: 40,
        ),
        Row(
          children: [
            Expanded(
                child: IButton3(
                    color: Colors.red,
                    text: strings.get(321),

                    /// "Cancel order",
                    textStyle: theme.text14boldWhite,
                    pressButton: () {
                      setState(() {
                        _show = 0;
                      });
                      _cancel();
                    })),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: IButton3(
                    color: theme.colorPrimary,
                    text: strings.get(322),

                    /// No
                    textStyle: theme.text14boldWhite,
                    pressButton: () {
                      setState(() {
                        _show = 0;
                      });
                    })),
          ],
        )
      ],
    );

    setState(() {
      _show = 1;
    });
  }

  _cancelSuccess() {
    _waits(false);
    for (var item in ordersData)
      if (item.orderid == idOrder) {
        item.status = "6";
        setState(() {});
        return;
      }
  }

  _arrivedSuccess() {
    _waits(false);
    for (var item in ordersData)
      if (item.orderid == idOrder) {
        item.arrived = "true";
        setState(() {});
        return;
      }
  }

  _error(String err) {
    _waits(false);
    openDialog("${strings.get(128)} $err"); // "Something went wrong. ",
  }

  bool _wait = false;

  _waits(bool value) {
    _wait = value;
    if (mounted) setState(() {});
  }

  double windowWidth = 0.0;
  double windowHeight = 0.0;

  @override
  void dispose() {
    route.disposeLast();
    super.dispose();
  }

  @override
  void initState() {
    account.addCallback(this.hashCode.toString(), callback);
    super.initState();
  }

  callback(bool reg) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: theme.colorBackground,
        body: Directionality(
            textDirection: strings.direction,
            child: Stack(
              children: <Widget>[
                skinHeader(
                    context, widget.onBack, strings.get(119)), // "My Orders",

                Container(
                  margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: MediaQuery.of(context).padding.top + 40),
                  child: Container(
                    child: ListView(
                      padding: EdgeInsets.only(top: 0),
                      children: _body(),
                    ),
                  ),
                ),

                if (_wait) skinWait(context, false),

                IEasyDialog2(
                  setPosition: (double value) {
                    _show = value;
                  },
                  getPosition: () {
                    return _show;
                  },
                  color: theme.colorGrey,
                  body: _dialogBody,
                  backgroundColor: theme.colorBackground,
                ),
              ],
            )));
  }

  bool viewDetails = true;

  redraw() {
    if (mounted) setState(() {});
  }

  _body() {
    List<Widget> list = [];
    var height = windowWidth * 0.3;

    list.add(SizedBox(
      height: 20,
    ));
    int _status = 1;

    for (var item in ordersData) {
      if (item.orderid == idOrder) {
        _status = int.parse(item.status);
        list.add(skinOrderCard(
          item.orderid,
          (String id, String hero) {
            viewDetails = !viewDetails;
            redraw();
          },
          windowWidth,
          height,
          "$serverImages${item.image}",
          item.name,
          item.restaurant,
          item.date,
          basket.makePriceString(item.total),
          "${strings.get(195)}${item.orderid}",
          item.statusName,
        )); // Id #

        if (viewDetails)
          addOrdersDetails(list, ordersData, idOrder, windowWidth);

        var maxStatus = _getMaxStatus(item.ordertimes);

        list.add(SizedBox(
          height: 35,
        ));

        list.add(itemTextPastOrder(
            "${strings.get(120)}", (maxStatus >= 1))); //  "Order received",
        list.add(itemOrdersDivider(_getStatusTime(item.ordertimes, 1)));
        list.add(itemTextPastOrder(
            "${strings.get(121)}", (maxStatus >= 2))); // Order preparing",
        list.add(itemOrdersDivider(_getStatusTime(item.ordertimes, 2)));
        list.add(itemTextPastOrder(
            "${strings.get(122)}", (maxStatus >= 3))); // Order ready
        list.add(itemOrdersDivider(_getStatusTime(item.ordertimes, 3)));

        if (item.curbsidePickup != "true") {
          list.add(itemTextPastOrder(
              "${strings.get(123)}", (maxStatus >= 4))); // On the way
          list.add(IntrinsicHeight(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ordersDivider(),
              Expanded(
                  child: Column(
                children: [
                  Text(
                    _getStatusTime(item.ordertimes, 4),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: windowWidth / 2,
                      child: IButton3(
                          enable: ((_status == 3 || _status == 4) &&
                              item.driver != '0'),
                          color: ((_status == 3 || _status == 4) &&
                                  item.driver != '0')
                              ? theme.colorPrimary
                              : Colors.grey.withAlpha(140),
                          text: strings.get(305), // Show order on map
                          textStyle: theme.text14boldWhite,
                          pressButton: _pressButtonOnTheMap))
                ],
              ))
            ],
          )));
        }

        var status = _getStatusTime(item.ordertimes, 5);
        if (status.isEmpty) status = _getStatusTime(item.ordertimes, 10);
        list.add(
            itemTextPastOrder("${strings.get(124)}", _status == 5)); // Delivery
        list.add(Text(
          status,
          textAlign: TextAlign.center,
        ));

        /*
        8     Rejected by Driver.
        9     Activate by Driver
        10    Complete by Driver
        12    Customer Arrived
        15    Set Driver
         */

        if (_status == 6) {
          // cancelled
          list.add(SizedBox(
            height: 20,
          ));
          list.add(Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  Icon(Icons.cancel, color: Colors.red, size: 30),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    strings.get(196),
                    style: theme.text18bold,
                  ),
                  Text(
                    _getStatusTime(item.ordertimes, 6),
                    style: theme.text14,
                  ),
                ],
              )));
        } else {
          if (_status >= 3) {
            if (item.curbsidePickup == "true") {
              list.add(SizedBox(
                height: 25,
              ));
              if (item.arrived == "true") {
                list.add(Container(
                  alignment: Alignment.center,
                  child: Text(
                    strings.get(204),
                    style: theme.text18bold,
                  ), // "Notification send...",
                ));
              } else
                list.add(Container(
                    width: windowWidth / 2,
                    child: IButton3(
                        color: theme.colorPrimary,
                        text: strings.get(203), // "I've arrived",
                        textStyle: theme.text14boldWhite,
                        pressButton: _arrived)));
            }
          }
        }
        list.add(SizedBox(
          height: 5,
        ));
        if (_status != 5 && _status != 6 && item.arrived != "true")
          list.add(Container(
              width: windowWidth / 2,
              child: IButton3(
                  color: theme.colorPrimary,
                  text: strings.get(84), // "Cancel",
                  textStyle: theme.text14boldWhite,
                  pressButton: _openCancel)));
        break;
      }
    }

    list.add(SizedBox(
      height: 100,
    ));

    return list;
  }

  _getStatusTime(List<OrderTimes> times, int status) {
    for (var time in times) if (time.status == status) return time.createdAt;
    return "";
  }

  int _getMaxStatus(List<OrderTimes> times) {
    var ret = 0;
    for (var time in times) {
      if (time.status > ret && time.status != 6) ret = time.status;
    }
    return ret;
  }

  double _show = 0;
  Widget _dialogBody = Container();

  openDialog(String _text) {
    _dialogBody = Column(
      children: [
        Text(
          _text,
          style: theme.text14,
        ),
        SizedBox(
          height: 40,
        ),
        IButton3(
            color: theme.colorPrimary,
            text: strings.get(155), // Cancel
            textStyle: theme.text14boldWhite,
            pressButton: () {
              setState(() {
                _show = 0;
              });
            }),
      ],
    );
    setState(() {
      _show = 1;
    });
  }

  _pressButtonOnTheMap() {
    for (var item in ordersData)
      if (item.orderid == idOrder) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MapTrackingScreen(item: item),
          ),
        );
      }
  }
}
