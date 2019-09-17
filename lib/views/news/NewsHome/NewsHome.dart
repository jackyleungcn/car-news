import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import './NewsHome.service.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewsHome extends StatefulWidget {
  @override
  _NewsHome createState() => new _NewsHome();
}

class _NewsHome extends State<NewsHome> {
  var data = [];
  var channel = [];
  var _score = "-1";
  var _tagId = "-1";

  RefreshController _refreshController = RefreshController();

  @override
  initState() {
    super.initState();
    _init();
  }

  void _init() async {
    await _getChennel();
    _getList();
  }

  void _onRefresh() async {
    _score = "-1";
    await _getList();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await _getList();
    setState(() {
      _refreshController.loadComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _makeAppBar(channel),
      body: Container(
        color: Color.fromARGB(255, 242, 242, 242),
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropHeader(
            complete: Text("又有新内容啦 ^.^ ~"),
          ),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("上拉加载");
              } else if (mode == LoadStatus.loading) {
                body = Text("正在加载...");
              } else if (mode == LoadStatus.failed) {
                body = Text("加载失败！点击重试！");
              } else if (mode == LoadStatus.canLoading) {
                body = Text("松手，加载更多!");
              } else {
                body = Text("没有更多数据了!");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: _makeList(data),
        ),
      ),
    );
  }

  /*
   * 网络请求
   */

  _getChennel() async {
    var res = await $service.getChannel();
    channel = res.result;
    _tagId = channel[0].id.toString();
  }

  _getList() async {
    var res = await $service.getList(score: _score, tagId: _tagId);
    if(_score == "-1") data = [];
    setState(() {
      var _newsList = res.result.news?.list;
      if(_newsList == null) return;
      for (var i = 0; i < _newsList.length; i++) {
        data.add(_newsList[i]);
      }
      _score = _newsList[_newsList.length - 1].score;
    });
  }

  /*
   * AppBar
   */
  _makeAppBar(listChannel) {
    return PreferredSize(
      preferredSize: Size.fromHeight(90.0),
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: _makeSignSearch(),
        bottom: _makeChannelListBar(listChannel),
      ),
    );
  }

  _makeSignSearch() {
    return Container(
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                child: Text(
                  "签到",
                  style: TextStyle(fontSize: 12),
                ),
                color: Colors.red,
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                width: 250,
                color: Color.fromARGB(255, 242, 242, 242),
                padding: EdgeInsets.fromLTRB(10, 7, 10, 7),
                child: Text(
                  "搜索框",
                  style: TextStyle(
                      fontSize: 12, color: Color.fromARGB(255, 176, 176, 176)),
                ),
              ),
            ),
            flex: 1,
          )
        ],
      ),
    );
  }

  _makeChannelListBar(listChannel) {
    return PreferredSize(
      child: Container(
        height: 35,
        padding: EdgeInsets.only(left: 10),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: _makeChannelList(listChannel),
        ),
      ),
      preferredSize: Size.fromHeight(50.0),
    );
  }

  _makeChannelList(listChannel) {
    List<Widget> list = [];
    for (int i = 0; i < listChannel.length; i++) {
      list.add(_makeChannelItem(listChannel[i].tag, listChannel[i].id));
    }
    return list;
  }

  _makeChannelItem(text, id) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _tagId = id.toString();
          _refreshController.requestRefresh();
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 20),
        child: id.toString() == _tagId
            ? _makeSelectedChannel(text)
            : _makeNormalChannel(text),
      ),
    );
  }

  _makeNormalChannel(text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black38,
        fontSize: 14,
      ),
    );
  }

  _makeSelectedChannel(text) {
    return Column(
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(1),
            child: Container(
              width: 12,
              height: 5,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  /*
   * list
   */

  _makeList(list) {
    return ListView.builder(
      itemBuilder: (c, i) => _listItem(list[i]),
      itemCount: list.length,
    );
  }

  _listItem(item) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return WebviewScaffold(
                url: "https://res.youcheyihou.com/auto_home_mobile/news/" +
                    item.id.toString(),
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(40.0),
                  child: AppBar(),
                ),
                withZoom: true,
                withLocalStorage: true,
                hidden: true,
                initialChild: Container(
                  color: Colors.black12,
                  child: const Center(
                    child: Text('加载中.....'),
                  ),
                ),
              );
            },
          ),
        );
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(top: 5),
        child: Column(
          children: <Widget>[
            _listItemBody(item),
            _listItemFooter(item),
          ],
        ),
      ),
    );
  }

  _listItemFooter(item) {
    int commentCount = item.commentsCount;
    String createtime = item.createtime.split(" ")[0];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          item.userAccount != null
              ? item.userAccount.nickname
              : "服务端数据错误：【无名氏】",
          style: TextStyle(
              color: Color.fromARGB(255, 178, 178, 178), fontSize: 12),
        ),
        Text(
          "$commentCount 评论  ·  $createtime",
          style: TextStyle(
              color: Color.fromARGB(255, 178, 178, 178), fontSize: 12),
        ),
      ],
    );
  }

  _listItemBody(item) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 180,
            child: Text(
              item.title,
              maxLines: 3,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: 110,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: FadeInImage.assetNetwork(
                placeholder: "images/default.png",
                image: item.articleImages[0],
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
