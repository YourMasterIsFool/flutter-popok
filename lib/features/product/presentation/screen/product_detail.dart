import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:pos_flutter/commons/modal_container.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/product/domain/models/product_model.dart';
import 'package:pos_flutter/features/product/presentation/bloc/product_bloc.dart';
import 'package:pos_flutter/features/product/presentation/bloc/product_state.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.id});
  final int id;
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late ProductBloc _productBloc;

  final alamatController = TextEditingController();

  int quantity = 1;

  @override
  void initState() {
    _productBloc = context.read<ProductBloc>();
    _productBloc.getProductDetail(widget.id);
    super.initState();
  }

  Future<void> openModalPayment(
      {required BuildContext context,
      required ProductModel productModel}) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        context: context,
        builder: (context) => ModalContainer(
            height: 500,
            title: "Lanjutkan Pembayaran",
            child: StatefulBuilder(
              builder: (context, parentState) {
                return Column(
                  children: [
                    Form(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // decoration: BoxDecoration(
                          //     color: Colors.black,
                          //     borderRadius: BorderRadius.circular(100)),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (quantity > 1) {
                                    parentState(() {
                                      quantity -= 1;
                                    });
                                  }
                                },
                                child: Container(
                                  child: Icon(
                                    FontAwesome5.minus,
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 4.0),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  "${quantity}",
                                  style: textTheme()
                                      .bodyMedium
                                      ?.copyWith(color: Colors.black),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  parentState(() {
                                    quantity += 1;
                                  });
                                },
                                child: Container(
                                  child: Icon(
                                    FontAwesome5.plus,
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 4.0),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        TextField(
                          maxLines: 5,
                          minLines: 4,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            label: Text("isi alamat kamu"),
                          ),
                          controller: alamatController,
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        TextButton(
                            style: ButtonStyle(),
                            onPressed: () {},
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Proses pembayaran"),
                                  Text(
                                      " Rp. ${productModel.product_price * quantity}")
                                ],
                              ),
                            ))
                      ],
                    ))
                  ],
                );
              },
            )));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is LoadingGetDetailProduct) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is SuccessGetDetailProduct) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () => openModalPayment(
                    context: context, productModel: state.product),
                label: Row(
                  children: [
                    Text("Beli     Rp. ${state.product.product_price}")
                  ],
                )),
            appBar: AppBar(
              title: Text(state.product.product_title),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    '${dotenv.env['BASE_URL_API']}${state.product.file_path}',
                    width: double.infinity,
                    fit: BoxFit.cover,
                    height: 350.h,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${state.product.product_title}",
                          style: textTheme().bodyMedium,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          "Rp. ${state.product.product_price}",
                          style:
                              textTheme().titleLarge?.copyWith(fontSize: 20.sp),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          state.product.product_description,
                          style: textTheme().bodyMedium?.copyWith(
                              color: Colors.grey.shade600, height: 1.5),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }

        return Scaffold(
          body: Text("${widget.id}"),
        );
      },
    );
  }
}
