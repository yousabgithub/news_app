import 'package:cached_network_image/cached_network_image.dart';

import '../../app_localizations.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constants.dart';
import 'web_view_screen.dart';

class NewsItem extends StatelessWidget {
  final int index;

  final Map<String, dynamic> newsDetails;

  const NewsItem({
    super.key,
    required this.index,
    required this.newsDetails,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textContext = Theme.of(context).textTheme;
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 400),
      child: SlideAnimation(
        horizontalOffset: 300,
        child: FadeInAnimation(
          child: InkWell(
            onTap: () {
              navigatorTo(context, WebViewScreen(newsDetails['url']));
            },
            borderRadius: BorderRadius.circular(10.r),
            child: Card(
              child: SizedBox(
                height: 300.h,
                width: double.infinity,
                child: LayoutBuilder(
                  builder: (context, constraints) => Padding(
                    padding: EdgeInsets.only(top: 14.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.w, right: 10.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: constraints.maxHeight * 0.1,
                                child: Text(
                                  /// Handling some errors and nulls coming from Api
                                  '${newsDetails['author'] == null || newsDetails['author'].toString().contains('http') ? 'unknown'.translate(context) : newsDetails['author']}',
                                  style: textContext.titleSmall,

                                  overflow: TextOverflow.ellipsis,
                                  //  textDirection: defaultDirection,
                                ),
                              ),
                              Row(
                                children: [
                                  const Spacer(),
                                  SizedBox(
                                    height: constraints.maxHeight * 0.1,
                                    child: Text(
                                      newsDetails['publishedAt']
                                          .toString()
                                          .split('T')[0],
                                      style: textContext.titleLarge,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: constraints.maxHeight * 0.25,
                                child: Text(
                                  '${newsDetails['title']}',
                                  style: textContext.titleMedium,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  //textDirection: defaultDirection,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.r),
                            bottomRight: Radius.circular(10.r),
                          ),

                          /// Handling images when be  nulls coming from Api
                          /// by show another image local
                          child: newsDetails['urlToImage'] == null
                              ? Image.asset(
                                  'assets/images/imageError.png',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: constraints.maxHeight * 0.5,
                                )

                              /// Handling images when be error coming from Api
                              : CachedNetworkImage(
                                  imageUrl: newsDetails['urlToImage'],
                                  placeholder: (ctx, s) => Image.asset(
                                    'assets/images/loading.gif',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: constraints.maxHeight * 0.5,
                                  ),
                                  errorWidget: (ctx, s, _) => Image.asset(
                                    'assets/images/imageError.png',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: constraints.maxHeight * 0.5,
                                  ),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: constraints.maxHeight * 0.5,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
