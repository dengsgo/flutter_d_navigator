import 'package:flutter/material.dart';
import 'package:d_navigator/d_navigator.dart';
import 'page.dart';
import 'register_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();

    registerRouter();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'DNavigator Demo'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
  }

  goPageA() {
    DNavigator.of(context).goNamed("/page-a", null);
  }

  goPageB() {
    DNavigator.of(context).goNamed("/page-b", DNavigatorQuery(
      id: 10086,
    ));
  }

  goPageC() {
    DNavigator.of(context).goNamed("/page-c", ExtendsDNavigatorQuery(
      id: 10086,
      nickname: "中国移动",
      address: "移动通信上海分公司",
      map: <String, int> {
        "hello": 1,
      },
    ));
  }

  goPageD() {
    DNavigator.of(context).goNamed("/page-d", null);
  }

  goPageE() {
    DNavigator.of(context).goNamed("/page-e", null);
  }

  goPageFWithoutAuth() {
    DNavigator.of(context).goNamed("/page-f", null);
  }

  goPageFWithAuth() {
    BoolCallback isAuthorized = () => Future.value(false);
    ObjectCallback goAuthPage = () async {
      return await DNavigator.of(context).goNamed("/page-auth", null);
    };
    DNavigator.of(context)
        .setAuthorizedHandlerFunc(isAuthorized, goAuthPage)
        .goNamed("/page-f", DNavigatorQuery(mustAuthorize: true,));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: goPageA,
              child: Text("Page A：无参数传递"),
            ),
            RaisedButton(
              onPressed: goPageB,
              child: Text("Page B：DNavigatorQuery对象参数传递"),
            ),
            RaisedButton(
              onPressed: goPageC,
              child: Text("Page C：DNavigatorQuery 扩展对象参数传递"),
            ),
            RaisedButton(
              onPressed: goPageD,
              child: Text("Page D：pop and push"),
            ),
            RaisedButton(
              onPressed: goPageE,
              child: Text("Page E：push replace"),
            ),
            RaisedButton(
              onPressed: goPageFWithoutAuth,
              child: Text("Page F：无需认证"),
            ),
            RaisedButton(
              onPressed: goPageFWithAuth,
              child: Text("Page F：需要认证"),
            ),
          ],
        ),
      ),
    );
  }
}
