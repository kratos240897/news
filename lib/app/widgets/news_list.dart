import 'package:cached_network_image/cached_network_image.dart';
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
        padding: const EdgeInsets.all(5.0),
        itemCount: articles.length,
        itemBuilder: ((_, index) {
          return NewsCard(articles: articles[index]);
        }));
  }
}

class NewsCard extends StatelessWidget {
  final Articles articles;
  const NewsCard({Key? key, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() =>
          Navigator.pushNamed(context, PageRouter.DETAIL, arguments: articles)),
      child: Hero(
        tag: articles.hashCode,
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          elevation: 12.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: SizedBox(
            height: 0.40.sh,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
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
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 5.0),
                  child: Text(
                    articles.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 5.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 8.0),
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
                        const SizedBox(width: 8.0),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            articles.author ?? 'unknown',
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        Row(
                          children: [
                            Text(
                              '•',
                              style: GoogleFonts.poppins(
                                  color: Colors.grey,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              '3 hours ago',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  color: Colors.grey,
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
