import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Article {
  String id;
  String title;
  String createdAt;
  Map<String, dynamic> user;
  String url;

  Article({
    this.id,
    this.title,
    this.createdAt,
    this.user,
    this.url,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json["id"].toString(),
      title: json["title"],
      createdAt: json["created_at"],
      user: json["user"],
      url: json["url"],
    );
  }
}

class GetArticleService {
  // http リクエストのエラーをキャッチする関数
  Function get onError => (error) {
        return error;
      };

  Future<List<Article>> fetchArticleList() async {
    List<Article> articleList = [];
    final response = await http.get("https://qiita.com/api/v2/items?page=1&per_page=5");

    List responseBody = jsonDecode(response.body);

    responseBody.forEach((element) {
      articleList.add(Article.fromJson(element));
    });

    return articleList;
  }
}
