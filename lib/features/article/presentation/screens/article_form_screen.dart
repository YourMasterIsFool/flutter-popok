import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/commons/loading_overflay.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/article/domain/model/article_model.dart';
import 'package:pos_flutter/features/article/presentation/bloc/article_bloc.dart';
import 'package:pos_flutter/features/article/presentation/bloc/article_state.dart';
import 'package:pos_flutter/utils/get_base_64_formatted_file.dart';

class ArticleFormScreen extends StatefulWidget {
  const ArticleFormScreen({super.key, this.id = 0});
  final int id;

  @override
  State<ArticleFormScreen> createState() => _ArticleFormScreenState();
}

class _ArticleFormScreenState extends State<ArticleFormScreen> {
  late ArticleBloc _articleBloc;
  final titleController = TextEditingController();
  final deskripsiController = TextEditingController();
  String? file_path;
  FilePickerResult? filePicker;
  PlatformFile? file;
  // final imageController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _articleBloc = context.read<ArticleBloc>();
    if (widget.id != 0) {
      setDetail();
    }

    super.initState();
  }

  void setDetail() async {
    print('detail ${widget.id}' + _articleBloc.state.toString());
    await _articleBloc.detailArticleBloc(id: widget.id ?? 0);
    setState(() {
      titleController.text = _articleBloc.state.article?.title ?? '';
      deskripsiController.text = _articleBloc.state.article?.description ?? '';
      file_path = _articleBloc.state.article?.file_path;
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    deskripsiController.dispose();

    super.dispose();
  }

  Future<void> uploadGambar() async {
    final filePicker = await FilePicker.platform.pickFiles();
    setState(() {
      file = filePicker?.files.first;
    });
  }

  void createNewArticle() async {
    ArticleModel _schema = new ArticleModel(
        title: titleController.text,
        description: deskripsiController.text,
        file_path:
            file != null ? getBase64FormattedFile(file?.path ?? '') : null);

    if (widget.id == 0) {
      await _articleBloc.createArticleBloc(schema: _schema);
    } else {
      await _articleBloc.updateArticleBloc(id: widget.id ?? 0, schema: _schema);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArticleBloc, ArticleState>(
      bloc: _articleBloc,
      listener: (context, state) {
        // TODO: implement listener
        if (state is SuccessCreateArticle) {
          LoadingOverflay.of(context).close();
          Navigator.pop(context);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Berhasil Create article")));
        }
        if (state is LoadingCreateArticleState) {
          LoadingOverflay.of(context).open();
        }

        if (state is LoadingUpdateArticle) {
          LoadingOverflay.of(context).open();
        }

        if (state is SuccessUpdateArticle) {
          LoadingOverflay.of(context).close();

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Berhasil memperbaharui Artikel")));
          navigatorKey.currentState!.pop();
        }
        print('jancokkk $state');
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
                "${widget.id} ${widget.id == 0 ? 'Tambah' : 'Update'} Artikel"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: verticalPadding,
                  ),
                  Text(
                    "${widget.id == 0 ? 'Tambah' : 'Update'} Artikel \nBaru",
                    style: textTheme().bodyLarge,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: titleController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Judul Artikel tidak boleh kosong";
                              }
                            },
                            decoration:
                                InputDecoration(label: Text("Judul Artikel")),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          TextFormField(
                            minLines: 3,
                            maxLines: 5,
                            controller: deskripsiController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Deskripsi tidak boleh kosong";
                              }
                            },
                            decoration: InputDecoration(
                                label: Text("Deskripsi Artikel"),
                                alignLabelWithHint: true),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await uploadGambar();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade400
                                            .withOpacity(0.2),
                                        offset: Offset(0, 6),
                                        blurRadius: 12,
                                        spreadRadius: 2)
                                  ]),
                              height: 150.h,
                              width: double.infinity,
                              child: file != null
                                  ? Image.file(File(file?.path ?? ''))
                                  : file_path != null
                                      ? Image.network(
                                          '${dotenv.env["BASE_URL_API"]}${file_path}',
                                          width: double.infinity,
                                          height: 150.h,
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Upload Gambar"),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Icon(Icons.photo)
                                          ],
                                        ),
                            ),
                          ),
                          SizedBox(
                            height: verticalPadding * 1.5,
                          ),
                          TextButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  createNewArticle();
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      "${widget.id == 0 ? 'Tambah' : 'Update'} Artikel Baru"),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Icon(Icons.add)
                                ],
                              ))
                        ],
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
