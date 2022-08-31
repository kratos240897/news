import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:provider_news/app/screens/search/search_provider.dart';
import 'package:provider_news/app/widgets/bordered_box_button.dart';

import '../../data/models/news_response.dart';
import '../../widgets/news_list.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late SearchProvider provider;
  late List<Articles> articles;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    provider = Provider.of<SearchProvider>(context, listen: false);
    articles = provider.articles;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<SearchProvider>(
          builder: (_, provider, child) {
            return Column(
              children: [
                Material(
                  elevation: 8.0,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: BorderedBoxButton(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            icon: CupertinoIcons.back),
                      ),
                      SearchAppBar(
                          provider: provider,
                          searchController: searchController),
                      const SizedBox(height: 8.0),
                      TrendingSearches(
                          provider: provider,
                          searchController: searchController),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
                SearchResults(provider: provider, articles: articles)
              ],
            );
          },
        ),
      ),
    );
  }
}

class SearchResults extends StatelessWidget {
  final SearchProvider provider;
  final List<Articles> articles;
  const SearchResults(
      {Key? key, required this.provider, required this.articles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return provider.isLoading == true
        ? const Expanded(
            child: Center(child: CircularProgressIndicator.adaptive()),
          )
        : Expanded(child: NewsList(articles: articles));
  }
}

class TrendingSearches extends StatelessWidget {
  final SearchProvider provider;
  final TextEditingController searchController;
  final List<String> trendingTopics = [
    'Apple',
    'Microsoft',
    'Amazon',
    'Facebook',
    'Stocks',
    'Wealth'
  ];
  TrendingSearches(
      {Key? key, required this.provider, required this.searchController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '# Trending 🔥',
            style: GoogleFonts.poppins(fontSize: 16.sp),
          ),
          4.verticalSpace,
          Wrap(
            spacing: 5.0,
            runSpacing: 2.0,
            verticalDirection: VerticalDirection.down,
            alignment: WrapAlignment.start,
            children: trendingTopics.map((e) {
              return ElevatedButton.icon(
                  icon: Icon(
                    FontAwesomeIcons.hashtag,
                    color: Colors.white,
                    size: 12.h,
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 4.0,
                      primary: CupertinoColors.activeBlue,
                      shape: const StadiumBorder()),
                  onPressed: () {
                    searchController.text = e;
                    provider.search(e);
                  },
                  label: Text(
                    e,
                    style: GoogleFonts.openSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ));
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class SearchAppBar extends StatefulWidget {
  final SearchProvider provider;
  final TextEditingController searchController;
  const SearchAppBar(
      {Key? key, required this.provider, required this.searchController})
      : super(key: key);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  final _searchFocusNode = FocusNode();
  bool cancelVisible = false;

  @override
  void initState() {
    _searchFocusNode.addListener(() {
      bool hasFocus = _searchFocusNode.hasFocus;
      if (hasFocus) {
        setState(() {
          cancelVisible = true;
        });
      } else {
        setState(() {
          cancelVisible = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: TextField(
                  controller: widget.searchController,
                  focusNode: _searchFocusNode,
                  autocorrect: false,
                  onSubmitted: (_) {
                    if (widget.searchController.text.toString().isEmpty) {
                      return;
                    } else {
                      widget.provider
                          .search(widget.searchController.text.toString());
                    }
                  },
                  style:
                      GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black),
                  decoration: InputDecoration(
                      hintStyle: GoogleFonts.poppins(color: Colors.grey),
                      hintText: 'Starting searching news...',
                      border: InputBorder.none),
                ),
              ),
            ),
          ),
          8.horizontalSpace,
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeInCubic,
              switchOutCurve: Curves.easeInOutCubic,
              child: cancelVisible
                  ? Padding(
                      padding: EdgeInsets.only(right: 5.w),
                      child: GestureDetector(
                        onTap: () {
                          widget.searchController.clear();
                          FocusScope.of(context).unfocus();
                        },
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.poppins(fontSize: 14.sp),
                        ),
                      ),
                    )
                  : const SizedBox.shrink())
        ],
      ),
    );
  }
}
