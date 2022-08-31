import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider_news/app/routes/router.dart';
import 'package:provider_news/app/widgets/custom_app_bar.dart';
import 'package:share_plus/share_plus.dart';
import '../../data/models/news_response.dart';
import '../../widgets/custom_app_bar.dart';

class Detail extends StatelessWidget {
  final Articles article;
  const Detail({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 12.0, right: 12.0, bottom: 8.0, top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                    onTapLeft: () {
                      Navigator.pop(context);
                    },
                    onTapRight: () {
                      Navigator.pushNamed(context, PageRouter.WEB_VIEW,
                          arguments: article.url.toString());
                    },
                    onTapShare: () async {
                      await Share.share('Check out this article ' + article.url);
                    },
                    icon: Icons.link),
                const SizedBox(height: 15.0),
                NewsBody(article: article)
              ],
            ),
          ),
        ));
  }
}

class NewsBody extends StatelessWidget {
  final Articles article;
  const NewsBody({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: Column(
            children: [
              Hero(
                tag: article.hashCode,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  elevation: 8.0,
                  child: Container(
                    height: 0.40.sh,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            article.urlToImage != null
                                ? article.urlToImage.toString()
                                : 'https://i.pinimg.com/originals/64/a9/1a/64a91a7a4c519e20dab92de9cf1d4447.jpg',
                          )),
                    ),
                  ),
                ),
              ),
              15.verticalSpace,
              Text(
                article.title,
                style: GoogleFonts.poppins(
                    fontSize: 16.sp, fontWeight: FontWeight.w700),
              ),
              12.verticalSpace,
              Text(
                article.description ?? '',
                style: GoogleFonts.poppins(
                    fontSize: 14.sp, fontWeight: FontWeight.normal),
              ),
              12.verticalSpace,
              Text(
                article.content ?? '',
                style: GoogleFonts.poppins(
                    fontSize: 14.sp, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
