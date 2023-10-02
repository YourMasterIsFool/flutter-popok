import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Artikel "),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Top Read Article",
                style: textTheme().titleMedium,
              ),
            ),
            _topReadArticle(),
            _listArticle()
          ],
        ),
      ),
    );
  }

  Widget _listArticle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Artikel",
            style: textTheme().titleMedium,
          ),
          SizedBox(
            height: verticalPadding / 2,
          ),
          ListView.builder(
            itemBuilder: (context, index) => articleCard(),
            shrinkWrap: true,
            primary: false,
            itemCount: 4,
          )
        ],
      ),
    );
  }

  Widget articleCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 75,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
          ),
          SizedBox(
            width: 12.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: verticalPadding / 6,
              ),
              Text(
                "Test Article",
                style: textTheme().titleSmall,
              ),
              SizedBox(
                height: verticalPadding / 8,
              ),
              Text(
                "2 januari 2023",
                style: textTheme().bodySmall?.copyWith(fontSize: 8.sp),
              )
            ],
          )
        ]),
      ),
    );
  }

  Widget _topReadArticle() {
    return Container(
      padding: EdgeInsets.only(left: 12.h),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: verticalPadding / 2,
          ),
          Container(
            height: 150.h,
            child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                primary: true,
                itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: GestureDetector(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150.w,
                              height: 75.h,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            SizedBox(
                              height: verticalPadding / 3,
                            ),
                            Text(
                              "Controh Article",
                              style: textTheme()
                                  .titleSmall
                                  ?.copyWith(fontSize: 14.0),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "2 Januari 2023",
                              style: textTheme()
                                  .bodySmall
                                  ?.copyWith(fontSize: 12.0),
                            )
                          ],
                        ),
                      ),
                    )),
          )
        ],
      ),
    );
  }
}
