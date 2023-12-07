import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_flutter/commons/CustomSnackbar.dart';
import 'package:pos_flutter/commons/loading_overflay.dart';
import 'package:pos_flutter/config/secure_storage/secure_storage.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/pelatihan/domain/model/pelatihan_member.dart';
import 'package:pos_flutter/features/pelatihan/presentation/bloc/pelatihan_bloc.dart';
import 'package:pos_flutter/features/pelatihan/presentation/bloc/pelatihan_state.dart';
import 'package:pos_flutter/features/profile/domain/model/user_model.dart';
import 'package:pos_flutter/utils/formattingDate.dart';

class PelatihanDetailScreen extends StatefulWidget {
  const PelatihanDetailScreen({super.key, this.id});
  final int? id;

  @override
  State<PelatihanDetailScreen> createState() => _PelatihanDetailScreenState();
}

class _PelatihanDetailScreenState extends State<PelatihanDetailScreen> {
  late PelatihanBloc _pelatihanBloc;

  @override
  void initState() {
    _pelatihanBloc = context.read<PelatihanBloc>();
    if (widget.id != null) {
      _pelatihanBloc.getDetailPelatihan(widget.id ?? 0);
    }
    super.initState();
  }

  void requestJoinHandler() async {
    _pelatihanBloc.requestJoinPelatihan(widget.id ?? 0);
  }

  Map<String, dynamic> status(PelatihanMember? member) {
    if (member == null) {
      return {'color': Colors.grey.shade300, 'status': 'Belum Join'};
    }

    if (member?.acc == null) {
      return {
        'color': Colors.grey.shade300,
        'status': 'Menunggu disetujui admin'
      };
    }
    if (member.acc == 1) {
      return {'color': Colors.green.shade100, 'status': 'Sudah bergabung'};
    }

    if (member.acc == 2) {
      return {'color': Colors.red.shade100, 'status': 'Ditolak admin'};
    }

    return {'color': Colors.red.shade100, 'status': 'Ditolak admin'};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Pelatihan"),
      ),
      body: BlocConsumer<PelatihanBloc, PelatihanState>(
        buildWhen: (prev, next) {
          return (next is LoadingDetailPelatihan ||
              next is SuccessDetailPelatihan);
        },
        listener: (context, state) {
          // TODO: implement listener
          if (state is LoadingRequestJoinPelatihan) {
            LoadingOverflay.of(context).open();
          }
          if (state is SuccessRequestJoinPelatihan) {
            LoadingOverflay.of(context).close();
            ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar()
                .SuccessSnackbar(message: state.successMessage));
          }
          if (state is LoadingUpdateStatusMember) {
            LoadingOverflay.of(context).open();
          }
          if (state is SuccessUpdateStatusMember) {
            _pelatihanBloc.getDetailPelatihan(widget.id ?? 0);
            LoadingOverflay.of(context).close();
            ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar()
                .SuccessSnackbar(message: state.successMessage));
          }
        },
        builder: (context, state) {
          if (state is LoadingDetailPelatihan) {
            return Center(
              child: Container(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is SuccessDetailPelatihan) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: horizontalPadding / 2),
                child: FutureBuilder(
                    future: SecureStorage().getRole(),
                    builder: (context, snapshot) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 12.h,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 3),
                                      blurRadius: 20,
                                      spreadRadius: 1,
                                      color: Colors.grey.withOpacity(0.4))
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 12.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: Text(
                                      "Detail Pelatihan ",
                                      style: textTheme().titleLarge,
                                    )),
                                    snapshot.data == 'user'
                                        ? Container(
                                            child: Text(
                                              "${status(state.pelatihan.is_member)['status']}",
                                              style: textTheme()
                                                  .bodyMedium
                                                  ?.copyWith(fontSize: 8.sp),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12.w,
                                                vertical: 4.h),
                                            decoration: BoxDecoration(
                                                color: status(state.pelatihan
                                                    .is_member)['color'],
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                          )
                                        : Container(
                                            child: Text(
                                              "total member ${state.pelatihan.members?.length ?? 0}",
                                              style: textTheme()
                                                  .bodyMedium
                                                  ?.copyWith(fontSize: 8.sp),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12.w,
                                                vertical: 4.h),
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                          )
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Judul Pelatihan: ",
                                      style: textTheme()?.bodyMedium?.copyWith(
                                          color: Colors.grey.shade600),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Text(
                                      "${state.pelatihan.judul_pelatihan}",
                                      style: textTheme().titleMedium,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Deskripsi Pelatihan: ",
                                      style: textTheme()?.bodyMedium?.copyWith(
                                          color: Colors.grey.shade600),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Text(
                                      "${state.pelatihan.deskripsi}",
                                      style: textTheme().titleMedium,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Lokasi Pelatihan: ",
                                      style: textTheme()?.bodyMedium?.copyWith(
                                          color: Colors.grey.shade600),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Text(
                                      "${state.pelatihan.lokasi_pelatihan}",
                                      style: textTheme().titleMedium,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Tanggal Pelatihan: ",
                                      style: textTheme()?.bodyMedium?.copyWith(
                                          color: Colors.grey.shade600),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Text(
                                      "${formattingDate(date: state.pelatihan.tanggal_pelatihan)}",
                                      style: textTheme().titleMedium,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          snapshot.data == 'user' &&
                                  state.pelatihan.is_member == null
                              ? Container(
                                  width: double.infinity,
                                  child: TextButton(
                                      onPressed: () {
                                        requestJoinHandler();
                                      },
                                      child: Text("Daftar Pelatihan")),
                                )
                              : Container(),
                          snapshot.data == 'admin'
                              ? Container(
                                  margin: EdgeInsets.only(top: 12.h),
                                  child: ListView.builder(
                                    primary: false,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      UserModel? customer = state
                                          .pelatihan.members![index].customer;
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: horizontalPadding / 2,
                                            vertical: verticalPadding / 2),
                                        decoration:
                                            BoxDecoration(color: Colors.white),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 8.h),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                "Nama : ${state.pelatihan.members![index]}"),
                                                            SizedBox(
                                                              height: 2.h,
                                                            ),
                                                            Text(
                                                              "${customer?.name}",
                                                              style: textTheme()
                                                                  .titleMedium,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 8.h),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                "Nomor Telepon :"),
                                                            SizedBox(
                                                              height: 2.h,
                                                            ),
                                                            Text(
                                                              "${customer?.phone_number}",
                                                              style: textTheme()
                                                                  .titleMedium,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 8.h),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                "Jenis Kelamin :"),
                                                            SizedBox(
                                                              height: 2.h,
                                                            ),
                                                            Text(
                                                              "${customer?.jenis_kelamin ?? ''}",
                                                              style: textTheme()
                                                                  .titleMedium,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 8.h),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text("Alamat :"),
                                                            SizedBox(
                                                              height: 2.h,
                                                            ),
                                                            Text(
                                                              "${customer?.alamat}",
                                                              style: textTheme()
                                                                  .titleMedium,
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                state.pelatihan.members![index]
                                                            .acc ==
                                                        null
                                                    ? Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              _pelatihanBloc
                                                                  .updateStatusPelatihanMember(
                                                                      id: state
                                                                              .pelatihan
                                                                              .members![index]
                                                                              .id ??
                                                                          0,
                                                                      acc: 1)
                                                                  .then((value) {
                                                                _pelatihanBloc
                                                                    .getDetailPelatihan(
                                                                        widget.id ??
                                                                            0);
                                                              });
                                                            },
                                                            child: Icon(
                                                                Icons
                                                                    .check_circle,
                                                                color: Colors
                                                                    .green),
                                                          ),
                                                          SizedBox(
                                                            width: 4.w,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              _pelatihanBloc
                                                                  .updateStatusPelatihanMember(
                                                                      id: state
                                                                              .pelatihan
                                                                              .members![index]
                                                                              .id ??
                                                                          0,
                                                                      acc: 2)
                                                                  .then((value) {});
                                                            },
                                                            child: Icon(
                                                                Icons.cancel,
                                                                color:
                                                                    Colors.red),
                                                          )
                                                        ],
                                                      )
                                                    : Container(
                                                        child: Text(
                                                          "${status(state.pelatihan.members![index])['status']}",
                                                          style: textTheme()
                                                              .bodyMedium
                                                              ?.copyWith(
                                                                  fontSize:
                                                                      8.sp),
                                                        ),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    12.w,
                                                                vertical: 4.h),
                                                        decoration: BoxDecoration(
                                                            color: status(state
                                                                        .pelatihan
                                                                        .members![
                                                                    index])[
                                                                'color'],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100)),
                                                      )
                                              ],
                                            )
                                          ],
                                        ),
                                        margin: EdgeInsets.only(top: 12.h),
                                      );
                                    },
                                    itemCount:
                                        state.pelatihan.members?.length ?? 0,
                                  ),
                                )
                              : Container()
                        ],
                      );
                    }),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
