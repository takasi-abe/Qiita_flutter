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
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 50,
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                          article.user["profile_image_url"],
                          scale: 3.0,
                        ),
                        fit: BoxFit.fill),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      article.title,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    userName("@ ${article.user["name"]}")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return articleCard;
  }

  Widget userName(String userName) {
    Widget userNameText;
    TextStyle textStyle = TextStyle(fontSize: 12, color: Colors.black);
    if (userName == "@ ") {
      userName = "noName";
      textStyle.color.withOpacity(1.0);
    }

    userNameText = Text(
      userName,
      style: textStyle,
    );
    return userNameText;
  }
}
