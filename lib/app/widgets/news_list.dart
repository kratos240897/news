import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emojis/emojis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/models/news_response.dart';
import '../routes/router.dart';

class NewsList extends StatelessWidget {
  final List<Articles> articles;
  const NewsList({Key? key, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(5.sp),
        itemCount: articles.length,
        itemBuilder: ((_, index) {
          return NewsCard(articles: articles[index]);
        }));
  }
}

class NewsCard extends StatelessWidget {
  final List<String> newsTypes = [
    '${Emojis.fire} Hot',
    '${Emojis.lightBulb} Insightful',
    '${Emojis.cloudWithLightning} Latest',
    '${Emojis.axe} Breaking',
    '${Emojis.globeShowingEuropeAfrica} Economy'
  ];
  final Articles articles;
  NewsCard({Key? key, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() =>
          Navigator.pushNamed(context, PageRouter.DETAIL, arguments: articles)),
      child: Hero(
        tag: articles.hashCode,
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 5.sp),
          elevation: 12.sp,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.sp)),
          child: SizedBox(
            height: 0.40.sh,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.sp),
                    child: CachedNetworkImage(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.25,
                        errorWidget: (context, url, error) {
                          return CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl:
                                  'https://i.pinimg.com/originals/64/a9/1a/64a91a7a4c519e20dab92de9cf1d4447.jpg');
                        },
                        fit: BoxFit.cover,
                        imageUrl: articles.urlToImage != null
                            ? articles.urlToImage.toString()
                            : 'https://i.pinimg.com/originals/64/a9/1a/64a91a7a4c519e20dab92de9cf1d4447.jpg'),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 8.sp, right: 8.sp, bottom: 5.sp),
                  child: Text(
                    articles.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 5.sp),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 8.sp, right: 8.sp, bottom: 8.sp),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.grey.withAlpha(50), width: 1.5),
                          ),
                          child: CircleAvatar(
                            radius: 16.w,
                            backgroundImage: const CachedNetworkImageProvider(
                                'https://i.pinimg.com/474x/1d/a1/5f/1da15faba08158465c7bb9dbe86b7a82.jpg'),
                          ),
                        ),
                        SizedBox(width: 8.sp),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            articles.author ?? 'unknown',
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                color: Colors.black87,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        5.horizontalSpace,
                        Row(
                          children: [
                            Text(
                              '•',
                              style: GoogleFonts.poppins(
                                  color: Colors.black87,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            5.horizontalSpace,
                            Text(
                              newsTypes[Random().nextInt(newsTypes.length)],
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  color: Colors.black87,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
