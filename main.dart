import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'components/tile.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Yoro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Hello Yoro'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Offset leftTilesOffset = Offset(1, 0);
  Offset rightTilesOffset = Offset(-1, 0);
  double height = 0;
  bool toRefresh = false;
  static Random _random = Random();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  // late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animationController.forward();
    super.initState();
  }

  //Functions for refresh controller
  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1200));
    _refreshController.refreshCompleted();
    if (_animationController.status == AnimationStatus.completed) {
      _animationController.reset();
      _animationController.forward();
      setState(() {
        _random = new Random();
      });
    }
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1200));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        header: WaterDropHeader(
          idleIcon: Icon(Icons.south),
        ),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            if (index.isOdd) {
              return Tile(
                model: models[_random.nextInt(7) + 1],
                offset: leftTilesOffset,
                leftPadding: 64,
                rightPadding: 8,
                animation: _animationController,
              );
            }
            return Tile(
              model: models[_random.nextInt(7) + 1],
              offset: rightTilesOffset,
              leftPadding: 8,
              rightPadding: 64,
              animation: _animationController,
            );
          },
          itemCount: 3,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
