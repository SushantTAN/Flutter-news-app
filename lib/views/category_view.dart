import 'package:flutter/material.dart';
import 'package:flutternews/helper/data.dart';
import 'package:flutternews/models/article_model.dart';
import 'package:flutternews/helper/news.dart';
import 'package:flutternews/views/article_view.dart';

class CategoryView extends StatefulWidget {

  final String category;
  CategoryView({this.category});

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {

  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCategoryNews();
  }

   getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.share,))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),

      body:  _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ) 
      : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              //blogs
                   Container(
                    child: ListView.builder(
                      itemCount: articles.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index){
                        return BlogTile(
                          imageUrl: articles[index].urlToImage,
                          title: articles[index].title,
                          desc: articles[index].description,
                          url: articles[index].url,
                        );
                      }
                      ),
                  ),
            ],
            )
        ),
      ),
      );
  }
}

class BlogTile extends StatelessWidget {

  final String imageUrl, title, desc, url;
  BlogTile({@required this.imageUrl, @required this.title, @required this.desc, @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ArticleView(
            blogUrl: url,
          )
        ));
      },
          child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl)
              ),
            SizedBox(height: 8,),
            Text(title, style: TextStyle(
              fontSize: 19,
              color: Colors.black87,
              fontWeight: FontWeight.w600
            ),),
            Text(desc, style: TextStyle(
              color: Colors.black54,
            ),),
          ],
          ),
      ),
    );
  }
}