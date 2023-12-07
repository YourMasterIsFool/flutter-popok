import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/commons/CustomSnackbar.dart';
import 'package:pos_flutter/commons/loading_overflay.dart';
import 'package:pos_flutter/commons/modal_container.dart';
import 'package:pos_flutter/config/secure_storage/secure_storage.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/order/models/order_model.dart';
import 'package:pos_flutter/features/order/presentation/bloc/order_bloc.dart';
import 'package:pos_flutter/features/order/presentation/bloc/order_state.dart';
import 'package:pos_flutter/features/product/domain/models/product_model.dart';
import 'package:pos_flutter/features/product/presentation/bloc/product_bloc.dart';
import 'package:pos_flutter/features/product/presentation/bloc/product_state.dart';
import 'package:pos_flutter/utils/getLocation.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.id});
  final int id;
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late ProductBloc _productBloc;
  late OrderBloc _orderBloc;
  late final alamatController = TextEditingController();
  String? latitude;
  String? longitude;

  int quantity = 1;

  @override
  void initState() {
    _productBloc = context.read<ProductBloc>();
    _productBloc.getProductDetail(widget.id);
    _orderBloc = context.read<OrderBloc>();
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
            title: "Isi Detail Pemesanan",
            child: StatefulBuilder(
              builder: (context, parentState) {
                return BlocConsumer<OrderBloc, OrderState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is LoadingCreateOrder) {
                      LoadingOverflay.of(context).open();
                    }
                    if (state is SuccessCreateOrder) {
                      LoadingOverflay.of(context).close();
                      ScaffoldMessenger.of(context).showSnackBar(
                          CustomSnackbar()
                              .SuccessSnackbar(message: state.success));
                      navigatorKey.currentState?.pushNamed('/order-detail',
                          arguments: {'id': state.order.id});
                    }
                  },
                  builder: (context, state) {
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
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
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
                                          borderRadius:
                                              BorderRadius.circular(100)),
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
                                onPressed: () async {
                                  await getLocation().then((value) {
                                    print(value.toString());
                                    parentState(() {
                                      longitude = value.longitude.toString();
                                      latitude = value.latitude.toString();
                                    });
                                  });
                                },
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.black),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.grey.shade200)),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svgs/location-svgrepo-com.svg',
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                    Text("Atur Lokasi Kamu")
                                  ],
                                )),
                            longitude != null
                                ? GestureDetector(
                                    onTap: () async {
                                      String googleUrl =
                                          'https://www.google.com/maps/search/?api=1&query=${latitude ?? ""},${longitude ?? ""}';
                                      await launchUrl(Uri.parse(googleUrl));
                                    },
                                    child: Container(
                                      height: 75,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: EdgeInsets.only(
                                          top: 12.h, bottom: 12.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                              "Open lokasi kamu di google maps"),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Icon(FontAwesome5.map)
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              height: 12.h,
                            ),
                            TextButton(
                                style: ButtonStyle(),
                                onPressed: () async {
                                  await productPaymentHandler();
                                },
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
                );
              },
            ))).then((value) {
      setState(() {
        longitude = null;
        latitude = null;
        quantity = 1;
      });
    });
  }

  Future<void> productPaymentHandler() async {
    OrderModel schema = OrderModel(
      quantity: quantity,
      price: _productBloc.state.product?.product_price ?? 0,
      product_id: widget.id,
      alamat: alamatController.text,
      latitude: latitude,
      longitude: longitude,
    );

    await _orderBloc.createOrderBloc(schema: schema);
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
              title: Text("Detail Produk"),
              actions: [
                FutureBuilder(
                  future: SecureStorage().getRole(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data == 'admin'
                          ? Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      navigatorKey.currentState!.pushNamed(
                                          '/product-form',
                                          arguments: {'id': widget.id});
                                    },
                                    icon: Icon(FontAwesome5.edit)),
                                SizedBox(
                                  width: 8.w,
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      FontAwesome5.trash,
                                      color: errorColor,
                                    ))
                              ],
                            )
                          : Container();
                    }

                    return Container();
                  },
                )
              ],
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
                        Row(
                          children: [Text("Stok: ${state.product.stok}")],
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
