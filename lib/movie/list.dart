// 导入需要的组件
import 'package:flutter/material.dart';

//导入异步请求
import 'package:dio/dio.dart';

//引入详情页
import './detail.dart';

Dio dio = new Dio();

//继承有数据的类
class MovieList extends StatefulWidget {
  //调用父类的构造函数,固定写法
  //MovieList(Key key) : super();
  MovieList({Key key, @required this.mt}) : super(key: key);

  //电影类型
  final String mt;
  @override
  _MovieListState createState() {
    // TODO: implement createState
    //throw UnimplementedError();

    return new _MovieListState();
  }
}

//有状态控件,必须结合一个状态管理类,来进行
//AutomaticKeepAliveClientMixin 左右切换的时候不会跑到顶部
class _MovieListState extends State<MovieList>
    with AutomaticKeepAliveClientMixin {
  //默认显示第一页数据
  int page = 1;
  //每页显示的数据条数
  int pagesize = 10;
  //电影列表数据
  var mlist = [];
  //总数据条数 ,实现分页的效果
  var total = 0; //没时间做

  //左右切换不滑动到顶部
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  //控件被创建的时候,会执行initState
  void initState() {
    super.initState();
    getMovieList();
  }

  //渲染当前这个HovieList 控件UI结构的
  @override
  Widget build(BuildContext context) {
    //Text("这是电影列表页面----" + widget.mt + "----- ${mlist.length}")
    return ListView.builder(
      itemCount: mlist.length,
      itemBuilder: (BuildContext ctx, int i) {
        //每次循环都拿到当前的电影Item项
        var mitem = mlist[i];
        return GestureDetector(
          onTap: () {
            print('asssss');
            //点击跳转详情
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext ctx) {
              return new MovieDetail(id: mitem['id'], title: mitem['title']);
            }));
          },
          child: Container(
            height: 200,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.black12))),
            child: Row(
              children: [
                Image.network(
                  mitem['images']['small'],
                  width: 130,
                  height: 180,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  height: 200,
                  child: Column(
                    //顶端贴边对其
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('电影名称: ${mitem['title']}'),
                      Text('上映年份: ${mitem['year']}年'),
                      Text('电影类型: ${mitem['genres'].join(', ')}'),
                      Text('豆瓣评分: ${mitem['rating']['average']}分'),
                      Text('电影名称: ${mitem['title']}')
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  getMovieList() async {
    // js中的模板字符串
    // 偏移量的计算公式 (page - 1) * pagesize
    int offset = (page - 1) * pagesize;
    var response = await dio.get(
        'http://www.liulongbin.top:3005/api/v2/movie/${widget.mt}?start=$offset&count=$pagesize');
    //'http://115.29.148.10:8989/categoryList');
    //服务器返回的真正数据
    var result = response.data;
    print("打印测试......");
    print(result);

    //设置到里面去,设置到状态里面去
    setState(() {
      //通过dio返回的数据,必须使用[] 中括号来访问
      mlist = result['subjects'];
      total = result['total'];
    });
  }
}
