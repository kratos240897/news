import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';
import 'package:provider_news/app/widgets/news_list.dart';
import '../../routes/router.dart';
import '../../widgets/bordered_box_button.dart';
import '../../widgets/custom_showcase.dart';
import 'home_provider.dart';

class HomeView extends StatefulWidget {
  final VoidCallback openDrawer;
  const HomeView({Key? key, required this.openDrawer}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late HomeProvider provider;
  final topicsController = GroupButtonController(selectedIndex: 0);

  final scaffoldKey = GlobalKey();
  final keyOne = GlobalKey();
  final keyTwo = GlobalKey();
  final keyThree = GlobalKey();

  @override
  void initState() {
    provider = Provider.of<HomeProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.getNews();
      //ShowCaseWidget.of(context)?.startShowCase([keyOne, keyTwo, keyThree]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Consumer<HomeProvider>(builder: (_, provider, child) {
            return Stack(children: [
              Container(
                color: Colors.grey[100],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    elevation: 8.sp,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.sp),
                        bottomRight: Radius.circular(20.sp)),
                    child: Column(
                      children: [
                        HeaderAppBar(
                          key1: keyOne,
                          key2: keyTwo,
                          openDrawer: widget.openDrawer,
                        ),
                        6.verticalSpace,
                        TopicsWidget(
                          provider: provider,
                          topicsController: topicsController,
                        ),
                        8.verticalSpace
                      ],
                    ),
                  ),
                  Expanded(
                      child: NewsList(
                    articles: provider.articles,
                  ))
                ],
              )
            ]);
          }),
        ));
  }
}

class TopicsWidget extends StatelessWidget {
  const TopicsWidget({
    Key? key,
    required this.provider,
    required this.topicsController,
  }) : super(key: key);

  final HomeProvider provider;
  final GroupButtonController topicsController;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        margin: EdgeInsets.only(top: 5.sp, left: 12.sp, right: 12.sp),
        height: 40.h,
        color: Colors.white,
        duration: const Duration(milliseconds: 400),
        curve: Curves.bounceInOut,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: GroupButton(
            controller: topicsController,
            isRadio: true,
            options: GroupButtonOptions(
                textPadding: EdgeInsets.all(4.sp),
                spacing: 5.sp,
                groupingType: GroupingType.row,
                direction: Axis.horizontal,
                selectedColor: CupertinoColors.activeBlue,
                unselectedTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    fontFamily: GoogleFonts.beVietnamPro().fontFamily),
                selectedTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    fontFamily: GoogleFonts.beVietnamPro().fontFamily),
                unselectedColor: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.sp)),
            onSelected: (_, index, __) async {
              provider.setSelectedTopic(index);
            },
            buttons: provider.topics,
          ),
        ));
  }
}

class HeaderAppBar extends StatelessWidget {
  final GlobalKey key1;
  final GlobalKey key2;
  final VoidCallback openDrawer;
  const HeaderAppBar(
      {Key? key,
      required this.key1,
      required this.key2,
      required this.openDrawer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomShowCase(
            globalKey: key1,
            title: 'Tap here',
            description: 'To access menu',
            isCircleBorder: true,
            child: IconButton(
                onPressed: () {
                  openDrawer();
                },
                icon: const Icon(Icons.menu)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.grey.withAlpha(50), width: 1.5),
                    ),
                    child: CircleAvatar(
                      radius: 25.w,
                      backgroundImage: const CachedNetworkImageProvider(
                          'https://i.pinimg.com/474x/1d/a1/5f/1da15faba08158465c7bb9dbe86b7a82.jpg'),
                    ),
                  ),
                  8.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back! 👋🏻',
                        style: GoogleFonts.poppins(fontSize: 14.sp),
                      ),
                      Text(
                        'Surya',
                        style: GoogleFonts.poppins(
                            fontSize: 16.sp, fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: CustomShowCase(
                  globalKey: key2,
                  title: 'Tap here',
                  description: 'to search some news',
                  isCircleBorder: true,
                  child: BorderedBoxButton(
                      onTap: () {}, icon: FontAwesomeIcons.bell),
                ),
              )
            ],
          ),
          15.verticalSpace,
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, PageRouter.SEARCH);
            },
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5.sp),
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                height: 40.h,
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12.sp)),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 20.h,
                    ),
                    8.horizontalSpace,
                    Text('Search for articles...',
                        style: GoogleFonts.poppins(
                            color: Colors.grey, fontSize: 14.sp))
                  ],
                )),
          )
        ],
      ),
    );
  }
}
