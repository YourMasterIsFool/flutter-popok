import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/article/domain/model/article_model.dart';
import 'package:pos_flutter/features/article/presentation/bloc/article_bloc.dart';
import 'package:pos_flutter/features/article/presentation/bloc/article_state.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late ArticleBloc _articleBloc;

  @override
  void initState() {
    _articleBloc = context.read<ArticleBloc>();
    _articleBloc.getListArticleBloc();
    _articleBloc.getListTopArticle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Artikel "),
        actions: [
          IconButton(
              onPressed: () {
                navigatorKey.currentState?.pushNamed('/article-form');
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding / 2),
              child: Text(
                "Article",
                style: textTheme().bodyLarge,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: BlocConsumer<ArticleBloc, ArticleState>(
                buildWhen: (prev, next) {
                  return (next is SuccessGetListArticle ||
                      next is LoadingGetArticleState);
                },
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is LoadingGetArticleState) {
                    return CircularProgressIndicator();
                  }

                  if (state is SuccessGetListArticle) {
                    return ListView.builder(
                      itemBuilder: (context, index) => ArticleWidget(
                        article: state.articles![index],
                      ),
                      itemCount: state.articles!.length,
                      shrinkWrap: true,
                      primary: false,
                    );
                  }

                  return Scaffold();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({
    super.key,
    required this.article,
  });
  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.h),
      child: GestureDetector(
        onTap: () {
          navigatorKey.currentState!.pushNamed('/article-detail',
              arguments: {'id': article.id}).then((value) {});
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                '${dotenv.env["BASE_URL_API"]}${article.file_path}',
                width: 150,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 12.w,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${article.title}"),
                    SizedBox(
                      height: 6.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          "${article.description}",
                          style: textTheme().bodySmall?.copyWith(
                                color: Colors.grey.shade600,
                                overflow: TextOverflow.ellipsis,
                              ),
                          maxLines: 2,
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      "23 Agustus 2020",
                      style: textTheme().bodySmall?.copyWith(
                          fontSize: 10.sp, color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
