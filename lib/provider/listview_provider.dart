import 'package:Practice/service/get_article_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ListViewProvider extends ChangeNotifier {
  final List<Article> articleList = [];

  void getArticleList() {
    GetArticleService service = GetArticleService();
    service.fetchArticleList().then((response) {
      response.forEach((element) {
        articleList.add(element);
      });
      notifyListeners();
    });
  }
}
