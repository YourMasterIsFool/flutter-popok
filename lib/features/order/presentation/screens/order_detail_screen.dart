import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:pos_flutter/commons/CustomSnackbar.dart';
import 'package:pos_flutter/commons/loading_overflay.dart';
import 'package:pos_flutter/config/secure_storage/secure_storage.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/order/models/order_model.dart';
import 'package:pos_flutter/features/order/presentation/bloc/order_bloc.dart';
import 'package:pos_flutter/features/order/presentation/bloc/order_state.dart';
import 'package:pos_flutter/features/profile/presentation/bloc/user_bloc.dart';
import 'package:pos_flutter/features/profile/presentation/bloc/user_state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../commons/modal_container.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key, this.id});
  final int? id;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late OrderBloc _orderBloc;
  late UserBloc _userBloc;

  @override
  void initState() {
    _orderBloc = context.read<OrderBloc>();
    _userBloc = context.read<UserBloc>();
    _userBloc.getUserAdminBloc();
    if (widget.id != null) {
      _orderBloc.getDetailOrderBloc(id: widget.id);
    }
    super.initState();
  }

  Color colorStatus(int status) {
    Color colors = Colors.transparent;

    switch (status) {
      case 1:
        colors = Colors.grey.shade600;
        break;
      case 2:
        colors = Colors.orange.shade600;
        break;

      case 3:
        colors = Colors.blue.shade600;
      case 4:
        colors = Colors.indigo.shade600;
      case 5:
        colors = Colors.green.shade600;
        break;
    }
    return colors;
  }

  void openWhatsapp(String number) async {
    String phone = number.replaceFirst('0', '+62');
    String waUrl = "https://api.whatsapp.com/send?phone=$phone}";
    if (Platform.isAndroid) {
      waUrl = "https://api.whatsapp.com/send?phone=$phone";
    }

    await launchUrl(Uri.parse(waUrl));
  }

  void openWhatsappOrder(
      {required OrderModel order, required String phoneNumberAdmin}) async {
    String phone = phoneNumberAdmin.replaceFirst('0', '+62');

    String text = '';
    text += "nama product = ${order.product?.product_title} \n";
    text += "quantity =  ${order.quantity} \n";
    text += "total = Rp. ${order.quantity * order.price} \n";
    text += "nama customer =  ${order.customer?.name ?? ''} \n";
    text += "alamat customer =  ${order.alamat ?? order.customer?.alamat}";

    String waUrl = "https://api.whatsapp.com/send?phone=$phone}&text=${text}";
    if (Platform.isAndroid) {
      waUrl = "https://api.whatsapp.com/send?phone=$phone&text=${text}";
    }

    await launchUrl(Uri.parse(waUrl));
  }

  Future<void> updateStatusHandler(
      {required int id, required int status}) async {
    await _orderBloc.updateStatusOrder(id: id, data: {'status': status});
  }

  Future<void> showMenuHandler({
    required int id,
    required int donasi_status,
  }) async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => StatefulBuilder(
            builder: (context, parentState) => ModalContainer(
                title: "Update Status",
                child: FutureBuilder(
                    future: SecureStorage().getRole(),
                    builder: (context, snapshot) {
                      return Column(
                        children: [
                          snapshot.data == 'admin'
                              ? TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) => states.contains(
                                                      MaterialState.pressed)
                                                  ? Colors.grey.shade200
                                                  : Colors.white),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.grey.shade800)),
                                  onPressed: () async {
                                    await updateStatusHandler(
                                        id: id, status: 2);
                                  },
                                  child: Row(
                                    children: [
                                      Text("Update status sudah dibayar")
                                    ],
                                  ))
                              : Container(),
                          snapshot.data == 'kurir'
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.resolveWith(
                                                    (states) => states.contains(
                                                            MaterialState
                                                                .pressed)
                                                        ? Colors.grey.shade200
                                                        : Colors.white),
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.grey.shade800)),
                                        onPressed: () async {
                                          await updateStatusHandler(
                                              id: id, status: 3);
                                        },
                                        child: Row(
                                          children: [Text("Dijemput kurir")],
                                        )),
                                    TextButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.resolveWith(
                                                    (states) => states.contains(
                                                            MaterialState
                                                                .pressed)
                                                        ? Colors.grey.shade200
                                                        : Colors.white),
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.grey.shade800)),
                                        onPressed: () async {
                                          await updateStatusHandler(
                                              id: id, status: 4);
                                        },
                                        child: Row(
                                          children: [Text("Diantar Kurir")],
                                        )),
                                    TextButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.resolveWith(
                                                    (states) => states.contains(
                                                            MaterialState
                                                                .pressed)
                                                        ? Colors.grey.shade200
                                                        : Colors.white),
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.grey.shade800)),
                                        onPressed: () async {
                                          await updateStatusHandler(
                                              id: id, status: 5);
                                        },
                                        child: Row(
                                          children: [Text("Order Selesai")],
                                        )),
                                  ],
                                )
                              : Container(),
                        ],
                      );
                    }))));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Detail Pesanan"),
            ),
            body: BlocConsumer<OrderBloc, OrderState>(
              buildWhen: (prev, next) {
                return (next is SuccessGetDetailOrder ||
                    next is LoadingDetailOrder);
              },
              listener: (context, state) {
                // TODO: implement listener
                if (state is LoadingUpdateOrderStatus) {
                  LoadingOverflay.of(context).open();
                }
                if (state is SuccessUpdateOrderStatus) {
                  LoadingOverflay.of(context).close();
                  ScaffoldMessenger.of(context).showSnackBar(
                      CustomSnackbar().SuccessSnackbar(message: state.success));
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (state is LoadingDetailOrder) {
                  return Center(
                    child: Container(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (state is SuccessGetDetailOrder) {
                  return Builder(builder: (context) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(color: Colors.white),
                            margin: EdgeInsets.only(top: 12.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: horizontalPadding / 2,
                                vertical: verticalPadding / 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Detail Pesanan",
                                      style: textTheme().titleLarge,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          child: Text(
                                            "${state.order.status?.status}",
                                            style: textTheme()
                                                .bodySmall
                                                ?.copyWith(
                                                    color: colorStatus(state
                                                            .order
                                                            .status
                                                            ?.code ??
                                                        1),
                                                    fontSize: 10.sp),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.w, vertical: 4.h),
                                          decoration: BoxDecoration(
                                              color: colorStatus(state
                                                          .order.status?.code ??
                                                      1)
                                                  .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                        ),
                                        snapshot.data != 'user'
                                            ? Container(
                                                margin:
                                                    EdgeInsets.only(left: 4.w),
                                                child: GestureDetector(
                                                    // onPressed: () {},
                                                    onTap: () async {
                                                      showMenuHandler(
                                                          id: state.order.id ??
                                                              0,
                                                          donasi_status: state
                                                                  .order
                                                                  .status
                                                                  ?.code ??
                                                              0);
                                                    },
                                                    child:
                                                        Icon(Icons.more_vert)),
                                              )
                                            : Container()
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        "${dotenv.env['BASE_URL_API']}${state.order.product?.file_path}",
                                        width: 75,
                                        height: 75,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4.h, vertical: 4.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${state.order.product?.product_title}",
                                              style: textTheme().bodyMedium,
                                            ),
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            Text(
                                              "Rp. ${state.order.product?.product_price}",
                                              style: textTheme()
                                                  .titleLarge
                                                  ?.copyWith(),
                                            ),
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Jumlah",
                                                  style: textTheme().bodyMedium,
                                                ),
                                                Text(
                                                  "${state.order.quantity}",
                                                  style:
                                                      textTheme().titleMedium,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Total: ",
                                      style: textTheme().bodyMedium?.copyWith(
                                          color: Colors.grey.shade600),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Divider(),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Text(
                                      "Rp ${state.order.quantity * state.order.price}",
                                      style: textTheme().titleLarge,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                TextButton(
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.grey.shade800),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.grey.shade100),
                                    ),
                                    onPressed: () async {
                                      String googleUrl =
                                          'https://www.google.com/maps/search/?api=1&query=${state.order.latitude ?? ""},${state.order.longitude ?? ""}';
                                      await launchUrl(Uri.parse(googleUrl));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Lokasi Pengantaran"),
                                        SizedBox(
                                          width: 12.w,
                                        ),
                                        SvgPicture.asset(
                                          'assets/svgs/location-svgrepo-com.svg',
                                          width: 20,
                                          height: 20,
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          snapshot.data == 'user'
                              ? BlocBuilder<UserBloc, UserState>(
                                  builder: (context, adminState) {
                                    if (adminState is LoadingGetUserAdmin) {
                                      return Container(
                                        width: 30,
                                        height: 30,
                                        child: CircularProgressIndicator(),
                                      );
                                    }

                                    if (adminState is SuccessGetUserAdmin) {
                                      return GestureDetector(
                                        onTap: () {
                                          openWhatsappOrder(
                                              order: state.order,
                                              phoneNumberAdmin: adminState
                                                      .admin.phone_number ??
                                                  '0');
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: horizontalPadding / 2,
                                              vertical: verticalPadding / 2),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  "Hubungi Admin Lewat Whatsapp"),
                                              SizedBox(
                                                width: 6.w,
                                              ),
                                              Icon(FontAwesome.whatsapp,
                                                  color: Colors.green)
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.white),
                                        ),
                                      );
                                    }
                                    return Container();
                                  },
                                )
                              : Container(),
                          snapshot.data != 'user'
                              ? Container(
                                  width: double.infinity,
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  padding: EdgeInsets.symmetric(
                                      vertical: verticalPadding / 2,
                                      horizontal: horizontalPadding / 2),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Customer detail",
                                        style: textTheme().titleLarge,
                                      ),
                                      SizedBox(
                                        height: 12.h,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Nama Customer:",
                                            style: textTheme()
                                                .bodyMedium
                                                ?.copyWith(
                                                    color:
                                                        Colors.grey.shade600),
                                          ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Text(
                                            "${state.order.customer?.name}",
                                            style: textTheme()
                                                .bodyMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Alamat Customer:",
                                            style: textTheme()
                                                .bodyMedium
                                                ?.copyWith(
                                                    color:
                                                        Colors.grey.shade600),
                                          ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Text(
                                            "${state.order.customer?.alamat ?? ''}",
                                            style: textTheme()
                                                .bodyMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Nomor Handphone:",
                                            style: textTheme()
                                                .bodyMedium
                                                ?.copyWith(
                                                    color:
                                                        Colors.grey.shade600),
                                          ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Text(
                                            "${state.order.customer?.phone_number ?? ''}",
                                            style: textTheme()
                                                .bodyMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 24.h,
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            openWhatsapp(state.order.customer
                                                    ?.phone_number ??
                                                '0');
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                  "Hubungi customer lewat whatsapp"),
                                              SizedBox(
                                                width: 8.w,
                                              ),
                                              Icon(FontAwesome.whatsapp,
                                                  color: Colors.green)
                                            ],
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                          ))
                                    ],
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    );
                  });
                }

                return Container();
              },
            ),
          );
        }

        return Container();
      },
      future: SecureStorage().getRole(),
    );
  }
}
