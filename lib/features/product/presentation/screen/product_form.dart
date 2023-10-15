import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/commons/loading_overflay.dart';
import 'package:pos_flutter/commons/wrapper_lost_focus.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/product/domain/models/product_model.dart';
import 'package:pos_flutter/features/product/presentation/bloc/product_bloc.dart';
import 'package:pos_flutter/features/product/presentation/bloc/product_state.dart';
import 'package:pos_flutter/utils/get_base_64_formatted_file.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({super.key});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  Uint8List? fileBytes;
  FilePickerResult? filePicker;
  PlatformFile? file;

  LoadingOverflay? loadingOverflay;
  late ProductBloc _productBloc;

  @override
  void initState() {
    _productBloc = context.read<ProductBloc>();
    loadingOverflay = LoadingOverflay.of(context);
    super.initState();
  }

  final product_title = TextEditingController();
  final product_description = TextEditingController();
  final product_price = TextEditingController();

  Future<void> uploadGambar() async {
    filePicker = await FilePicker.platform.pickFiles();

    if (filePicker != null) {
      setState(() {
        file = filePicker?.files.first;
      });
    }
  }

  void createNewProductHandler() async {
    ProductModel productModel = ProductModel(
        product_title: product_title.text,
        product_description: product_description.text,
        product_price: double.parse(product_price.text),
        file_path: getBase64FormattedFile(file?.path));

    print('print ' + getBase64FormattedFile(file?.path));

    await _productBloc.createProductBloc(productModel);
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WrapperLostFocuse(
      child: BlocConsumer<ProductBloc, ProductState>(
        bloc: _productBloc,
        listener: (context, state) {
          // TODO: implement listener

          print('state product ' + state.toString());
          if (state is LoadingCreateProduct) {
            loadingOverflay?.open();
          } else if (state is SuccessCreateProduct) {
            loadingOverflay?.close();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.success)));
            navigatorKey.currentState!.pop();
          }

          // if (state is SuccessCreateProduct) {

          // }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Tambah Product"),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: verticalPadding / 2,
                    ),
                    Text(
                      "Buat Produk \nBaru",
                      style: textTheme().titleLarge,
                    ),
                    SizedBox(
                      height: verticalPadding / 2,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: product_title,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Nama Product tidak boleh kosong';
                                }
                              },
                              decoration:
                                  InputDecoration(label: Text("Nama Product")),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            TextFormField(
                              controller: product_description,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Nama Deskripsi tidak boleh kosong';
                                }
                              },
                              // onChanged: (value) {
                              //   setState(() {
                              //     product_description.text = value;
                              //   });
                              // },
                              maxLines: 5,
                              minLines: 4,
                              decoration: InputDecoration(
                                  label: Text("Deskripsi Product"),
                                  alignLabelWithHint: true),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            TextFormField(
                              controller: product_price,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Harga Product tidak boleh kosong';
                                }
                              },
                              // onChanged: (value) {
                              //   setState(() {
                              //     product_price.text = value;
                              //   });
                              // },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  label: Text("Harga Product"),
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
                                child: file == null
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text("Upload gambar"),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Icon(Icons.add_a_photo)
                                        ],
                                      )
                                    : Image.file(File(file?.path ?? '')),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10)),
                                height: 150.h,
                                width: double.infinity,
                              ),
                            ),
                            SizedBox(
                              height: verticalPadding,
                            ),
                            TextButton(
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.all(12.0))),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    createNewProductHandler();
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Tambah product"),
                                    SizedBox(
                                      width: horizontalPadding / 3,
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
      ),
    );
  }
}
