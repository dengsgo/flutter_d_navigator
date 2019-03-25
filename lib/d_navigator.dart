library d_navigator;

import 'package:flutter/widgets.dart';

enum DNavigatorPushType {
  push,
  popAndPush,
  pushReplace,
}

class DNavigatorQuery {
  DNavigatorQuery({
    this.id,
    this.mustAuthorize: false,
    this.heroTag: "",
  });

  final Object id;
  final bool mustAuthorize;
  final String heroTag;
}

typedef PageRoute<T> DQueryPageRoute<T extends Object>(DNavigatorQuery query);
typedef Future<bool> BoolCallback();
typedef Future<Object> ObjectCallback();

class DNavigator {
  DNavigator(this.navigatorState) :
        assert(navigatorState != null),
        pushType = DNavigatorPushType.push;

  NavigatorState navigatorState;
  DNavigatorPushType pushType;

  BoolCallback _isAuthorizedHandler;
  ObjectCallback _goAuth;

  static Map<String, DQueryPageRoute> namedRoutesMapping = <String, DQueryPageRoute>{};

  static DNavigator of(BuildContext context) {
    return DNavigator(Navigator.of(context));
  }

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
