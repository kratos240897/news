import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider_news/app/models/news_response.dart';
import 'package:provider_news/app/routes/router.dart';
import 'package:provider_news/app/widgets/custom_app_bar.dart';
import '../../widgets/custom_app_bar.dart';

class Detail extends StatelessWidget {
  final Articles article;
  const Detail({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                    onTap: () {
                      Navigator.pushNamed(context, AppRouter.WEB_VIEW,
                          arguments: article.url.toString());
                    },
                    icon: CupertinoIcons.globe),
                const SizedBox(height: 12.0),
                NewsBody(article: article, deviceHeight: deviceHeight)
              ],
            ),
          ),
        ));
  }
}

class NewsBody extends StatelessWidget {
  final Articles article;
  final double deviceHeight;
  const NewsBody({Key? key, required this.article, required this.deviceHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Material(
              borderRadius: BorderRadius.circular(20.0),
              elevation: 8.0,
              child: Container(
                height: deviceHeight * 0.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(article.urlToImage !=
                              null
                          ? article.urlToImage.toString()
                          : 'https://i.pinimg.com/originals/64/a9/1a/64a91a7a4c519e20dab92de9cf1d4447.jpg')),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 5.0, right: 5.0),
              child: Text(
                article.title,
                style: GoogleFonts.nunito(
                    fontSize: 20.0, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 5.0, right: 5.0),
              child: Text(
                article.description ?? '',
                style: GoogleFonts.nunito(
                    fontSize: 18.0, fontWeight: FontWeight.normal),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 5.0, right: 5.0),
              child: Text(
                article.content ?? '',
                style: GoogleFonts.nunito(
                    fontSize: 18.0, fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
