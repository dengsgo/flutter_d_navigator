library d_navigator;

import 'package:flutter/widgets.dart';

/// push type enums
enum DNavigatorPushType {
  push,
  popAndPush,
  pushReplace,
}

/// query base object
/// If you want to customize the field, inherit this class and extend it yourself.
class DNavigatorQuery {
  DNavigatorQuery({
    this.id,
    this.mustAuthorize: false,
    this.heroTag: "",
  });

  final Object id;

  /// Built-in verification authorization field.
  /// The default is false.
  /// If set to true, you need to call setAuthorizedHandlerFunc in DNavigator
  /// to set the callback method.
  final bool mustAuthorize;

  /// Built-in hero animation tag.
  /// you can receive this parameter on the page you want to jump,
  /// passed to the Hero tag widget
  final String heroTag;
}

/// typedef params
typedef PageRoute<T> DQueryPageRoute<T extends Object>(DNavigatorQuery query);
typedef Future<bool> BoolCallback();
typedef Future<Object> ObjectCallback();

/// DNavigator class
/// To use this component, you need to register the page into the component first.
/// ```dart
/// DNavigator.registerNameRoute("/page-a", (DNavigatorQuery query) {
//    return new MaterialPageRoute(
//        builder: (BuildContext context) {
//          return PageB(query);
//        }
//    );
//  });
/// ```
/// Then you can use the goNamed method to jump to the page.
/// ```dart
/// DNavigator.of(context).goNamed("/page-a", DNavigatorQuery(
//      id: 10086,
//  ));
/// ```
///
class DNavigator {
  DNavigator(this.navigatorState) :
        assert(navigatorState != null),
        pushType = DNavigatorPushType.push;

  NavigatorState navigatorState;
  DNavigatorPushType pushType;

  BoolCallback _isAuthorizedHandler;
  ObjectCallback _goAuth;

  /// Routing map
  static Map<String, DQueryPageRoute> namedRoutesMapping = <String, DQueryPageRoute>{};

  /// Initialization component
  /// ```dart
  /// DNavigator.of(context);
  /// ```
  static DNavigator of(BuildContext context) {
    return DNavigator(Navigator.of(context));
  }

  /// Initialization component
  /// ```dart
  /// DNavigator.from(Navigator.of(context));
  /// ```
  static DNavigator from(NavigatorState state) {
    return DNavigator(state);
  }

  static void registerNameRoute(String name, DQueryPageRoute route) {
    namedRoutesMapping[name] = route;
  }

  DNavigator setPushType(DNavigatorPushType type) {
    pushType = type;
    return this;
  }

  Future<T> go<T extends Object>(PageRoute<T> route) async {
    switch (pushType) {
      case DNavigatorPushType.push:
        return await navigatorState.push(route);
        break;
      case DNavigatorPushType.popAndPush:
        if (navigatorState.canPop()) {
          navigatorState.pop();
        }
        return await navigatorState.push(route);
        break;
      case DNavigatorPushType.pushReplace:
        return await navigatorState.pushReplacement(route);
        break;
    }
    return await navigatorState.push(route);
  }

  DNavigator setAuthorizedHandlerFunc(BoolCallback isAuthorized, ObjectCallback goAuthPage) {
    _isAuthorizedHandler = isAuthorized ??  () => Future.value(true);
    _goAuth = goAuthPage ?? () => Future.value(true);
    return this;
  }

  Future<bool> _authHandler() async {
    if (await _isAuthorizedHandler()) {
      return true;
    }
    var r = await _goAuth();
    return r is bool && r;
  }

  Future<T> goNamed<T extends Object>(String name, DNavigatorQuery query) async {
    if (query !=null && query.mustAuthorize && !await _authHandler()) {
      return null;
    }

    return await go(namedRoutesMapping[name](query));
  }

  bool pop<T extends Object>([ T result ]) {
    return navigatorState.pop(result);
  }

}
