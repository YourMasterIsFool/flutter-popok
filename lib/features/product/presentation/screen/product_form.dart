import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
  const ProductFormScreen({super.key, this.id});
  final int? id;

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  Uint8List? fileBytes;
  FilePickerResult? filePicker;
  PlatformFile? file;

  LoadingOverflay? loadingOverflay;
  final product_title = TextEditingController();
  final product_description = TextEditingController();
  final product_price = TextEditingController();
  late ProductBloc _productBloc;

  @override
  void initState() {
    _productBloc = context.read<ProductBloc>();
    loadingOverflay = LoadingOverflay.of(context);

    if (widget.id != null) {
      getDetailData();
    }
    super.initState();
  }

  @override
  void dispose() {
    product_description.dispose();
    product_title.dispose();
    product_price.dispose();
    super.dispose();
  }

  void getDetailData() async {
    await _productBloc.getProductDetail(widget.id ?? 0);
    product_description.text =
        _productBloc.state.product?.product_description ?? '';
    product_price.text =
        _productBloc.state.product?.product_price.toString() ?? '';

    product_title.text = _productBloc.state.product?.product_title ?? '';
  }

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

          // if (state is LoadingGetDetailProduct) {
          //     loadingOverflay?.open();
          //   }

          //   if (state is SuccessGetDetailProduct) {
          //     loadingOverflay?.close();
          //   }

          // if (state is SuccessCreateProduct) {

          // }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  "${widget.id == null ? 'Tambah Product' : 'Update Product'}"),
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
                                child: file != null
                                    ? Image.file(File(file?.path ?? ''))
                                    : state.product?.file_path != null
                                        ? Image.network(
                                            '${dotenv.env["BASE_URL_API"]}${state.product?.file_path}',
                                            width: double.infinity,
                                            height: double.infinity,
                                          )
                                        : Column(
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
                                          ),
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
                                    Text(
                                        "${widget.id == null ? 'Tambah product' : 'Edit Product'}"),
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
