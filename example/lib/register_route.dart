import 'package:flutter/material.dart';
import 'package:flutter_d_navigator/flutter_d_navigator.dart';
import 'page.dart';

void registerRouter() {
  DNavigator.registerNameRoute("/page-a", (_) {
    return new MaterialPageRoute(builder: (BuildContext context) {
      return PageA();
    });
  });

  DNavigator.registerNameRoute("/page-b", (DNavigatorQuery query) {
    return new MaterialPageRoute(builder: (BuildContext context) {
      return PageB(query);
    });
  });

  DNavigator.registerNameRoute("/page-c", (DNavigatorQuery query) {
    return new MaterialPageRoute(builder: (BuildContext context) {
      return PageC(query);
    });
  });

  DNavigator.registerNameRoute("/page-d", (_) {
    return new MaterialPageRoute(builder: (BuildContext context) {
      return PageD();
    });
  });

  DNavigator.registerNameRoute("/page-e", (_) {
    return new MaterialPageRoute(builder: (BuildContext context) {
      return PageE();
    });
  });

  DNavigator.registerNameRoute("/page-f", (_) {
    return new MaterialPageRoute(builder: (BuildContext context) {
      return PageF();
    });
  });

  DNavigator.registerNameRoute("/page-auth", (_) {
    return new MaterialPageRoute(builder: (BuildContext context) {
      return PageAuth();
    });
  });
}
