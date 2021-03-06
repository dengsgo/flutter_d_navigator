# DNavigator

基于 Flutter Navigator 的扩展导航组件。它解决了 Navigator 无法传递参数的缺点，同时增加了权限验证的页面跳转逻辑，使得页面管理更加方便。  
Extended navigation component based on Flutter Navigator. It solves the shortcomings of Navigator's inability to pass parameters, and increases the page jump logic for permission verification, making page management more convenient.   


## Feature

- 支持页面的注册，通过别名的方式进行访问；  
- 页面之间支持参数传递；  
- 支持自定义复杂的页面参数；  
- 内置权限验证逻辑，方便页面跳转鉴权(比如必须登录才能访问);  
- 与 Navigator 组件不互斥，可以在一个项目中同时使用。（PS：DNavigator注册的路由在 Navigator 中不能使用，反之亦然）  
  
  

- Support registration of the page, access by means of aliases;  
- Support for parameter passing between pages;  
- Support for custom complex page parameters;  
- Built-in permission verification logic to facilitate page jump authentication (such as having to log in to access);  
- Not mutually exclusive with the Navigator component, can be used simultaneously in one project. (PS: The route registered by DNavigator cannot be used in Navigator, and vice versa)  

## Getting Started

在 `pubspec.yaml` 中添加依赖：  
```yaml
  flutter_d_navigator: ^0.1.5
```
然后执行 `flutter packages get` 即可.  

## Snapshot  
[demo snapshot](snapshot/demo.mp4)  


## Usage  

```dart 
import 'package:flutter_d_navigator/flutter_d_navigator.dart';

/// code 

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();

    // 注册页面，只需注册一次
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

void registerRouter() {
  DNavigator.registerNameRoute("/page-a", (_) {
    return new MaterialPageRoute(
        builder: (BuildContext context) {
          return PageA();
        }
    );
  });

  DNavigator.registerNameRoute("/page-b", (DNavigatorQuery query) {
    return new MaterialPageRoute(
        builder: (BuildContext context) {
          return PageB(query);
        }
    );
  });

  DNavigator.registerNameRoute("/page-c", (DNavigatorQuery query) {
    return new MaterialPageRoute(
        builder: (BuildContext context) {
          return PageC(query);
        }
    );
  });

  DNavigator.registerNameRoute("/page-d", (_) {
    return new MaterialPageRoute(
        builder: (BuildContext context) {
          return PageD();
        }
    );
  });

  DNavigator.registerNameRoute("/page-e", (_) {
    return new MaterialPageRoute(
        builder: (BuildContext context) {
          return PageE();
        }
    );
  });

  DNavigator.registerNameRoute("/page-f", (_) {
    return new MaterialPageRoute(
        builder: (BuildContext context) {
          return PageF();
        }
    );
  });

  DNavigator.registerNameRoute("/page-auth", (_) {
    return new MaterialPageRoute(
        builder: (BuildContext context) {
          return PageAuth();
        }
    );
  });
}

/// code


```

跳转页面：

```dart 
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
    DNavigator.of(context).pushNamed("/page-a", null);
  }

  goPageB() {
    DNavigator.of(context).pushNamed("/page-b", DNavigatorQuery(
      id: 10086,
    ));
  }

  goPageC() {
    DNavigator.of(context).pushNamed("/page-c", ExtendsDNavigatorQuery(
      id: 10086,
      nickname: "中国移动",
      address: "移动通信上海分公司",
      map: <String, int> {
        "hello": 1,
      },
    ));
  }

  goPageD() {
    DNavigator.of(context).pushNamed("/page-d", null);
  }

  goPageE() {
    DNavigator.of(context).pushNamed("/page-e", null);
  }

  goPageFWithoutAuth() {
    DNavigator.of(context).pushNamed("/page-f", null);
  }

  goPageFWithAuth() {
    BoolCallback isAuthorized = () => Future.value(false);
    ObjectCallback goAuthPage = () async {
      return await DNavigator.of(context).pushNamed("/page-auth", null);
    };
    DNavigator.of(context)
        .setAuthorizedHandlerFunc(isAuthorized, goAuthPage)
        .pushNamed("/page-f", DNavigatorQuery(mustAuthorize: true,));
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

```


## Feedback  

如果使用过程出现了bug或者有什么建议意见，请让我知道 [issue](https://github.com/dengsgo/flutter_d_navigator/issues)。  

If there is a bug in the process or if you have any suggestions, please let me know.



## License  

[Apache License](LICENSE)
