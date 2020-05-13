import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:flutter/material.dart';
import 'package:nkust_ap/pages/bus/bus_rule_page.dart';
import 'package:nkust_ap/pages/bus/bus_violation_records_page.dart';
import 'package:nkust_ap/utils/global.dart';

class BusPage extends StatefulWidget {
  static const String routerName = "/bus";
  final int initIndex;

  BusPage({this.initIndex = 0});

  @override
  BusPageState createState() => BusPageState();
}

class BusPageState extends State<BusPage> with SingleTickerProviderStateMixin {
  AppLocalizations app;

  TabController controller;

  int _currentIndex = 0;

  final List<Widget> _children = [
    BusReservePage(),
    BusReservationsPage(),
  ];

  @override
  void initState() {
    _currentIndex = widget.initIndex;
    controller =
        TabController(length: 2, initialIndex: widget.initIndex, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    app = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(app.bus),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                ApIcon.info,
                color: Colors.white,
              ),
              onPressed: () {
                ApUtils.pushCupertinoStyle(
                  context,
                  BusRulePage(),
                );
              })
        ],
      ),
      body: TabBarView(
        children: _children,
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        fixedColor: ApTheme.of(context).yellow,
        items: [
          BottomNavigationBarItem(
            icon: Icon(ApIcon.dateRange),
            title: Text(app.busReserve),
          ),
          BottomNavigationBarItem(
            icon: Icon(ApIcon.assignment),
            title: Text(app.busReservations),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      controller.animateTo(_currentIndex);
    });
  }
}
