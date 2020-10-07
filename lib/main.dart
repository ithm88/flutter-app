import 'package:flutter/material.dart';

//导入 电影列表页面
import './movie/list.dart';

//主渲染口
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '古专用',
      //这个是主题颜色
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
      ),
      //这个是首页组件
      home: MyHomeDemo(),
    );
  }
}

class MyHomeDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 在Flutter中,每个空间,都是一个类
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          //导航条控件
          appBar: AppBar(
            title: Text("古邦杰手写豆瓣"),
            centerTitle: true,
            // 右侧行为按钮
            actions: <Widget>[
              //一个按钮,一个图标
              IconButton(icon: Icon(Icons.search), onPressed: () {})
            ],
          ),
          //侧标栏区域
          drawer: Drawer(
            child: ListView(
              //上下左右padding都是0
              padding: EdgeInsets.all(0),
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text("古邦杰"),
                  accountEmail: Text("842529824@qq.com"),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://tva1.sinaimg.cn/crop.235.690.1201.1201.180/006eq2Aqjw8f9u6jw15w1j31hh1o27cq.jpg?KID=imgbed,tva&Expires=1601529259&ssig=yK%2FvBmohgd"),
                  ),
                  //美化当前控件的
                  decoration: BoxDecoration(
                      //背景图片
                      image: DecorationImage(
                          //平铺
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://www-x-jrw888-x-cn.img.abc188.com/images/timg.jpg"))),
                ),
                ListTile(
                  title: Text("用户反馈"),
                  trailing: Icon(Icons.feedback),
                ),
                ListTile(
                  title: Text("系统设置"),
                  trailing: Icon(Icons.settings),
                ),
                ListTile(
                  title: Text("我要发布"),
                  trailing: Icon(Icons.send),
                ),
                //分割线控件
                Divider(
                  color: Colors.red,
                ),
                ListTile(
                  title: Text("注销"),
                  trailing: Icon(Icons.exit_to_app),
                )
              ],
            ),
          ),
          //底部的tabBar
          bottomNavigationBar: Container(
            //美化当前的Container 盒子
            decoration: BoxDecoration(color: Colors.black),
            //一般高度都是50
            height: 50,
            child: TabBar(
              //设置文本不占高度
              labelStyle: TextStyle(height: 0, fontSize: 10),
              tabs: [
                Tab(
                  icon: Icon(Icons.movie_filter),
                  text: '正在热映',
                ),
                Tab(
                  icon: Icon(Icons.movie_creation),
                  text: '即将上映',
                ),
                Tab(
                  icon: Icon(Icons.local_movies),
                  text: '正在热映',
                ),
              ],
            ),
          ),
          //页面主体
          body: TabBarView(
            children: [
              //Text("aaa"),
              MovieList(
                mt: 'in_theaters',
              ),
              MovieList(
                mt: 'coming_soon',
              ),
              MovieList(
                mt: 'top250',
              ),
            ],
          )),
    );
  }
}
