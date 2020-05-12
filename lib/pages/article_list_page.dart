import 'package:Practice/listview_widget/article_list_widget.dart';
import 'package:Practice/provider/listview_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticleListPage extends StatelessWidget {
  final ListViewProvider listViewProvider = ListViewProvider();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Qiita一覧表示アプリ",
          style: TextStyle(color: Colors.green[300]),
        ),
        backgroundColor: Colors.pink[100],
      ),
      body: Center(child: ArticleListWidget()),
    );
  }
}
