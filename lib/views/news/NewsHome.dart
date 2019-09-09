import 'package:flutter/material.dart';
import '../../data/mock/m_newsHome.dart';

class NewsHome extends StatelessWidget {
  Widget build(BuildContext context) {
    var mock = new MNewsHome();
    return Scaffold(
      appBar: this._makeAppBar(mock.listChannel),
      body: this._makeList(mock.list),
    );
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
        title: this._makeSignSearch(),
        bottom: this._makeChannelListBar(listChannel),
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
          children: this._makeChannelList(listChannel),
        ),
      ),
      preferredSize: Size.fromHeight(50.0),
    );
  }

  _makeChannelList(listChannel) {
    List<Widget> list = [];
    for (int i = 0; i < listChannel.length; i++) {
      list.add(this._makeChannelItem(listChannel[i], i));
    }
    return list;
  }

  _makeChannelItem(text, index) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: index == 0
          ? this._makeSelectedChannel(text)
          : this._makeNormalChannel(text),
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
    return Container(
      color: Color.fromARGB(255, 242, 242, 242),
      child: ListView(
        children: this._makeListItem(list),
      ),
    );
  }

  _makeListItem(list) {
    List<Widget> listItem = [
      Container(padding: EdgeInsets.only(top: 10)),
    ];

    for (int i = 0; i < list.length; i++) {
      listItem.add(this._listItem(list[i]));
    }
    return listItem;
  }

  _listItem(item) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(top: 5),
      child: Column(
        children: <Widget>[
          this._listItemBody(item),
          this._listItemFooter(item),
        ],
      ),
    );
  }

  _listItemFooter(item) {
    int commentCount = item["comments_count"];
    String createtime = item["createtime"].split(" ")[0];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          item["user_account"]["nickname"],
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
              item["title"],
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
                image: item["article_images"][0],
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
