import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider_news/app/routes/router.dart';
import 'package:provider_news/app/widgets/custom_app_bar.dart';
import 'package:share_plus/share_plus.dart';
import '../../data/models/news_response.dart';

class Detail extends StatelessWidget {
  final Articles article;
  const Detail({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                left: 12.sp, right: 12.sp, bottom: 8.sp, top: 8.sp),
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
                      await Share.share(
                          'Check out this article ' + article.url);
                    },
                    icon: Icons.link),
                15.verticalSpace,
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
          padding: EdgeInsets.only(left: 5.sp, right: 5.sp),
          child: Column(
            children: [
              Hero(
                tag: article.hashCode,
                child: Material(
                  borderRadius: BorderRadius.circular(20.sp),
                  elevation: 8.sp,
                  child: Container(
                    height: 0.40.sh,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.sp),
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
