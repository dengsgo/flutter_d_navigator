import 'package:flutter/material.dart';
import 'package:flutter_d_navigator/d_navigator.dart';

class ExtendsDNavigatorQuery extends DNavigatorQuery {
  ExtendsDNavigatorQuery({
    this.id,
    this.nickname,
    this.address,
    this.map,
  }) : super();

  final int id;
  final String nickname;
  final String address;
  final Map<String, int> map;
}

class PageA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page A"),
      ),
      body: Center(
        child: Text("Page A: 无参数"),
      ),
    );
  }
}

class PageB extends StatelessWidget {
  PageB(this.query);

  final DNavigatorQuery query;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page B"),
      ),
      body: Center(
        child: Text("Page B: DNavigatorQuery 对象参数传递，\n\nid:${query.id}"),
      ),
    );
  }
}

class PageC extends StatelessWidget {
  PageC(this.query);

  final ExtendsDNavigatorQuery query;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page C"),
      ),
      body: Center(
        child: Text("Page C: DNavigatorQuery 扩展对象参数传递\n\nid:${query.id}\nname:${query.nickname}\naddress:${query.address}"),
      ),
    );
  }
}

class PageD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page D"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            DNavigator.of(context)
                .setPushType(DNavigatorPushType.popAndPush)
                .pushNamed("/page-a", null);
          },
          child: Text("pop and push page A"),
        ),
      ),
    );
  }
}

class PageE extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page E"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            DNavigator.of(context)
                .setPushType(DNavigatorPushType.pushReplace)
                .pushNamed("/page-a", null);
          },
          child: Text("push replace Page A"),
        ),
      ),
    );
  }
}

class PageF extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page F"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            DNavigator.of(context).pop();
          },
          child: Text("back"),
        ),
      ),
    );
  }
}

class PageAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page Auth"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                DNavigator.of(context).pop(true);
              },
              child: Text("授权访问"),
            ),
            RaisedButton(
              onPressed: () {
                DNavigator.of(context).pop(false);
              },
              child: Text("禁止访问"),
            ),
          ],
        ),
      ),
    );
  }
}

