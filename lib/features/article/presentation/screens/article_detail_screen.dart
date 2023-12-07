import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/commons/CustomSnackbar.dart';
import 'package:pos_flutter/commons/loading_overflay.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/article/presentation/bloc/article_bloc.dart';
import 'package:pos_flutter/features/article/presentation/bloc/article_state.dart';
import 'package:pos_flutter/utils/formattingDate.dart';

import '../../../../config/secure_storage/secure_storage.dart';

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({super.key, required this.id});
  final int id;

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  late ArticleBloc _articleBloc;

  String? role_name;

  void getRoleUser() async {
    role_name = await SecureStorage().getRole();
  }

  @override
  void initState() {
    _articleBloc = context.read<ArticleBloc>();
    _articleBloc.detailArticleBloc(id: widget.id);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getRoleUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArticleBloc, ArticleState>(
      buildWhen: (prev, next) {
        return (next is LoadingDetailArticle ||
            next is SuccessGetDetailArticle);
      },
      listener: (context, state) {
        // TODO: implement listener
        if (state is LoadingDeleteArticle) {
          LoadingOverflay.of(context).open();
        }
        if (state is SuccessDeleteArticle) {
          LoadingOverflay.of(context).close();
          ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackbar().SuccessSnackbar(message: state.success));
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is LoadingDetailArticle) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is SuccessGetDetailArticle) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Detail Artikel"),
              actions: role_name == 'admin'
                  ? [
                      IconButton(
                        onPressed: () {
                          navigatorKey.currentState?.pushNamed('/article-form',
                              arguments: {'id': widget.id}).then((value) async {
                            await _articleBloc.detailArticleBloc(id: widget.id);
                          });
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () async {
                          await _articleBloc.deleteArticleBloc(id: widget.id);
                        },
                        icon: Icon(
                          FontAwesome.trash,
                          color: Colors.red,
                        ),
                      ),
                    ]
                  : null,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    "${dotenv.env['BASE_URL_API']}${state.article.file_path}",
                    height: 400.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.article.title,
                          style: textTheme().titleLarge,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          formattingDate(date: state.article.updated_at),
                          style:
                              textTheme().bodySmall?.copyWith(fontSize: 10.sp),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Text(
                          state.article.description,
                          style: textTheme().bodyMedium?.copyWith(
                              color: Colors.grey.shade700, height: 1.6),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
