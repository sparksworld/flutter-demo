import 'package:flutterdemo/module.dart';
import 'package:flutterdemo/widgets/index.dart';

class MyPage extends StatefulWidget {
  final Function callback;
  MyPage({this.callback});

  @override
  State<StatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  void onChangeEvent() {
    eventBus.fire(SwitchTab(0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '个人中心',
            // style: TextStyle(color: Theme.of(context).tabBarTheme.labelStyle.color),
          ),
          // iconTheme: IconThemeData(color: Colors.white),
          elevation: 0.0,
          brightness: Brightness.dark,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/setting');
              },
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).primaryIconTheme.color,
              ),
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
                    // 顶部栏
                    new Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 220.0,
                          color: Colors.white,
                        ),
                        ClipPath(
                          clipper: new TopBarClipper(
                              MediaQuery.of(context).size.width, 200.0),
                          child: new SizedBox(
                            width: double.infinity,
                            height: 200.0,
                            child: new Container(
                              width: double.infinity,
                              height: 240.0,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        // 名字
                        Container(
                          margin: new EdgeInsets.only(top: 40.0),
                          child: new Center(
                            child: new Text(
                              'Spark',
                              style: new TextStyle(
                                  fontSize: 30.0, color: Colors.white),
                            ),
                          ),
                        ),
                        // 图标
                        Container(
                          margin: new EdgeInsets.only(top: 100.0),
                          child: new Center(
                              child: new Container(
                            width: 100.0,
                            height: 100.0,
                            child: new PreferredSize(
                              child: new Container(
                                child: new ClipOval(
                                  child: new Container(
                                    color: Colors.white,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MyHome(tabActiveIndex: 1),
                                          ),
                                          (Route<dynamic> route) => false,
                                        );
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "http://via.placeholder.com/150x150",
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          )),
                                        ),
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              preferredSize: new Size(80.0, 80.0),
                            ),
                          )),
                        ),
                      ],
                    ),
                    // 内容
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.all(10.0),
                      child: Card(
                          color: Colors.blue,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                MyListItem(
                                  icon: Icon(
                                    Icons.supervised_user_circle,
                                    color: Colors.white,
                                  ),
                                  title: "qq",
                                  titleColor: Colors.white,
                                  describe: '228436652',
                                  describeColor: Colors.white,
                                  onPressed: () {
                                    // launch(
                                    //     'mqqopensdkapi://bizAgent/qm/qr?url=http%3A%2F%2Fqm.qq.com%2Fcgi-bin%2Fqm%2Fqr%3Ffrom%3Dapp%26p%3Dandroid%26k%3DMNLtkvnn4n28UIB0gEgm2-WBmqmGWk0Q');
                                  },
                                ),
                                MyListItem(
                                  icon: Icon(
                                    Icons.http,
                                    color: Colors.white,
                                  ),
                                  title: "github",
                                  titleColor: Colors.white,
                                  describe: 'https://github.com/xuelongqy',
                                  describeColor: Colors.white,
                                  onPressed: () {
                                    // launch('https://github.com/xuelongqy');
                                  },
                                )
                              ],
                            ),
                          )),
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.all(10.0),
                      child: Card(
                          color: Colors.green,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                MyListItem(
                                  icon: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                  title: "name",
                                  titleColor: Colors.white,
                                  describe: 'spark',
                                  describeColor: Colors.white,
                                ),
                                MyListItem(
                                  icon: Icon(
                                    Icons.youtube_searched_for,
                                    color: Colors.white,
                                  ),
                                  title: "age",
                                  titleColor: Colors.white,
                                  describe: "18 years old",
                                  describeColor: Colors.white,
                                ),
                                MyListItem(
                                  icon: Icon(
                                    Icons.location_city,
                                    color: Colors.white,
                                  ),
                                  title: "city",
                                  titleColor: Colors.white,
                                  describe: "shangqiu",
                                  describeColor: Colors.white,
                                )
                              ],
                            ),
                          )),
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.all(10.0),
                      child: Card(
                          color: Colors.teal,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                MyListItem(
                                  icon: Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                  ),
                                  title: "phone",
                                  titleColor: Colors.white,
                                  describe: '18888888888',
                                  describeColor: Colors.white,
                                ),
                                MyListItem(
                                  icon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  title: "email",
                                  titleColor: Colors.white,
                                  describe: 'spark.xiaoyu@qq.com',
                                  describeColor: Colors.white,
                                  onPressed: () {},
                                )
                              ],
                            ),
                          )),
                    ),
                  ]),
                ),
              ],
            ),
          ],
        ));
  }
}

// 顶部栏裁剪
class TopBarClipper extends CustomClipper<Path> {
  // 宽高
  double width;
  double height;

  TopBarClipper(this.width, this.height);

  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(width, 0.0);
    path.lineTo(width, height / 2);
    path.lineTo(0.0, height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
