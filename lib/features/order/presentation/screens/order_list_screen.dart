import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/commons/modal_container.dart';
import 'package:pos_flutter/config/secure_storage/secure_storage.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/order/models/order_model.dart';
import 'package:pos_flutter/features/order/models/order_status_model.dart';
import 'package:pos_flutter/features/order/presentation/bloc/order_bloc.dart';
import 'package:pos_flutter/features/order/presentation/bloc/order_state.dart';
import 'package:pos_flutter/features/order/presentation/bloc/order_status_bloc.dart';
import 'package:pos_flutter/features/order/presentation/bloc/order_status_state.dart';
import 'package:pos_flutter/utils/formattingDate.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  late OrderBloc _orderBloc;
  late OrderStatusBloc _orderStatusBloc;
  final statusController = TextEditingController();

  @override
  void initState() {
    _orderBloc = context.read<OrderBloc>();
    _orderBloc.getListOrderBloc();

    _orderStatusBloc = context.read<OrderStatusBloc>();
    _orderStatusBloc.getListOrderStatusBloc();
    statusController.addListener(() {
      _orderBloc.getListOrderBloc(
          params: {'status': int.parse(statusController.text)});
    });
    super.initState();
  }

  @override
  void dispose() {
    statusController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Kamu"),
      ),
      body: BlocConsumer<OrderBloc, OrderState>(
        bloc: _orderBloc,
        buildWhen: (prev, next) {
          return (next is SuccessGetListOrder || next is LoadingGetListOrder);
        },
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is LoadingGetListOrder) {
            return Center(
              child: Container(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is SuccessGetListOrder) {
            return FutureBuilder(
                future: SecureStorage().getRole(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Container(
                          //   height: 100,
                          //   child: BlocBuilder<OrderStatusBloc,
                          //           OrderStatusState>(
                          //       bloc: _orderStatusBloc,
                          //       builder: (context, orderStatusState) {
                          //         if (orderStatusState
                          //             is LoadingGetListOrderStatus) {
                          //           return Container(
                          //             margin: EdgeInsets.only(top: 12.h),
                          //             width: 30,
                          //             height: 30,
                          //             child: CircularProgressIndicator(),
                          //           );
                          //         }

                          //         if (orderStatusState
                          //             is SuccessGetListOrderStatus) {
                          //           return ListView.builder(
                          //             itemBuilder: (context, index) {
                          //               OrderStatusModel status =
                          //                   orderStatusState
                          //                       .listOrderStatus[index];
                          //               return Container(
                          //                 margin: EdgeInsets.only(left: 12.w),
                          //                 child: GestureDetector(
                          //                   onTap: () {
                          //                     setState(() {
                          //                       statusController.text =
                          //                           status.code.toString();
                          //                     });
                          //                   },
                          //                   child: Container(
                          //                     child: Text("${status.status}"),
                          //                     padding: EdgeInsets.symmetric(
                          //                         horizontal: 16.w,
                          //                         vertical: 8.h),
                          //                     decoration: BoxDecoration(
                          //                         borderRadius:
                          //                             BorderRadius.circular(
                          //                                 100),
                          //                         color: statusController
                          //                                     .text ==
                          //                                 status.code.toString()
                          //                             ? Colors.grey.shade200
                          //                             : Colors.transparent,
                          //                         border: Border.all(
                          //                             color: statusController
                          //                                         .text ==
                          //                                     status.code
                          //                                         .toString()
                          //                                 ? Colors.transparent
                          //                                 : Colors
                          //                                     .grey.shade400)),
                          //                   ),
                          //                 ),
                          //               );
                          //             },
                          //             itemCount: orderStatusState
                          //                 .listOrderStatus.length,
                          //             scrollDirection: Axis.horizontal,
                          //             primary: false,
                          //             shrinkWrap: true,
                          //           );
                          //         }

                          //         return Container();
                          //       }),
                          // ),

                          ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              OrderModel order = state.orders[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      navigatorKey.currentState?.pushNamed(
                                          '/order-detail',
                                          arguments: {'id': order.id});
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: horizontalPadding / 2,
                                          vertical: verticalPadding / 2),
                                      decoration:
                                          BoxDecoration(color: Colors.white),
                                      child: Stack(children: [
                                        GestureDetector(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "${formattingDate(date: order.created_at)}",
                                                    style: textTheme()
                                                        .bodySmall
                                                        ?.copyWith(
                                                            color: Colors
                                                                .grey.shade600),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color: colorStatus(order
                                                                    .status
                                                                    ?.code ??
                                                                1)
                                                            .withOpacity(0.2)),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 6.w,
                                                            vertical: 4.h),
                                                    child: Text(
                                                      "${order.status?.status}",
                                                      style: textTheme()
                                                          .bodySmall
                                                          ?.copyWith(
                                                              color: colorStatus(
                                                                  order.status
                                                                          ?.code ??
                                                                      1),
                                                              fontSize: 10.sp),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 4.h,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.network(
                                                      '${dotenv.env["BASE_URL_API"]}${order.product?.file_path}',
                                                      width: 75,
                                                      height: 75,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8.w,
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical:
                                                                  verticalPadding /
                                                                      4),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "${order.product?.product_title}",
                                                            style: textTheme()
                                                                .bodyMedium,
                                                          ),
                                                          SizedBox(
                                                            height: 4.h,
                                                          ),
                                                          Text(
                                                            "Rp. ${order.product?.product_price}",
                                                            style: textTheme()
                                                                .titleMedium,
                                                          ),
                                                          SizedBox(
                                                            height: 4.h,
                                                          ),
                                                          Text(
                                                              "Quantity: ${order.quantity}"),
                                                          SizedBox(
                                                            height: 4.h,
                                                          ),
                                                          snapshot.data ==
                                                                  'admin'
                                                              ? Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                        "Customer"),
                                                                    Text(
                                                                        "${order.customer_id}")
                                                                  ],
                                                                )
                                                              : Container()
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ]),
                                    ),
                                  ),
                                ],
                              );
                            },
                            itemCount: state.orders.length,
                          ),
                        ],
                      ),
                    );
                  }
                  return Container();
                });
          }

          return Container();
        },
      ),
    );
  }
}
