import 'package:Practice/service/get_article_service.dart';
import 'package:flutter/material.dart';

class ArticleListWidget extends StatefulWidget {
  @override
  ArticleListWidgetState createState() => ArticleListWidgetState();
}

class ArticleListWidgetState extends State<ArticleListWidget> {
  final List<Article> articleList = [];

  Widget build(BuildContext context) {
    return SizedBox(
      width: 800,
      height: 800,
      child: articleList.length < 1
          ? Card()
          : ListView.builder(
              shrinkWrap: true,
              itemCount: articleList.length,
              itemBuilder: (_, index) {
                return creatArticleCard(articleList[index]);
              }),
    );
  }

  @override
  initState() {
    super.initState();
    fechPost();
  }

  void fechPost() {
    GetArticleService service = GetArticleService();
    service.fetchArticleList().then(
          (response) => response.forEach((article) {
            setState(() {
              articleList.add(article);
              print(article.title);
            });
          }),
        );
  }

  Widget creatArticleCard(Article article) {
    Widget articleCard = Container(
      width: 300,
      height: 200,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              child: Image.network(article.user["profile_image_url"], scale: 0.1),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Text(
                      article.title,
                      style: TextStyle(
                        fontSize: 32,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      article.user["name"] ?? "noName",
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return articleCard;
  }
}
