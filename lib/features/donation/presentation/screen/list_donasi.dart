import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/commons/loading_overflay.dart';
import 'package:pos_flutter/commons/modal_container.dart';
import 'package:pos_flutter/config/secure_storage/secure_storage.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/donation/model/donasi_model.dart';
import 'package:pos_flutter/features/donation/presentation/bloc/donasi_bloc.dart';
import 'package:pos_flutter/features/donation/presentation/bloc/donasi_state.dart';
import 'package:pos_flutter/utils/formattingDate.dart';
import 'package:url_launcher/url_launcher.dart';

class ListDonasiScreen extends StatefulWidget {
  const ListDonasiScreen({super.key});

  @override
  State<ListDonasiScreen> createState() => _ListDonasiScreenState();
}

class _ListDonasiScreenState extends State<ListDonasiScreen> {
  late DonasiBloc _donasiBloc;
  bool canCreate = false;
  String role_name = '';

  final _scaffoldKey = GlobalKey<ScaffoldState>(); //
  @override
  void initState() {
    _donasiBloc = context.read<DonasiBloc>();
    _donasiBloc.getListDonasi();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      canCreateHandler();
    });
  }

  canCreateHandler() async {
    var role = await SecureStorage().getRole();

    setState(() {
      role_name = role ?? '';
    });

    print("role_name" + role_name.toString());
    if ((role_name != null) && role_name == 'user') {
      setState(() {
        canCreate = true;
      });
      return;
    }
    canCreate = false;
    return;
  }

  Color colorStatus(int status) {
    Color colors = Colors.transparent;

    switch (status) {
      case 0:
        colors = Colors.grey.shade600;
        break;
      case 1:
        colors = Colors.orange.shade600;
        break;

      case 2:
        colors = Colors.blue.shade600;
      case 3:
        colors = Colors.red.shade600;
      case 4:
        colors = Colors.green.shade600;
        break;
    }
    return colors;
  }

  Future<void> showModalBottom({
    int status = 0,
    int donasi_id = 0,
    // String? role_name = '',
  }) async {
    await showModalBottomSheet(
        context: _scaffoldKey.currentState!.context,
        builder: (context) => ModalContainer(
            title: "Action ${donasi_id}",
            child: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    role_name == 'admin' && status == 0
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                child: TextButton(
                                    style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.black),
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) => (states.contains(
                                                        MaterialState.pressed)
                                                    ? Colors.grey.shade200
                                                    : Colors.transparent))),
                                    onPressed: () async {
                                      await _donasiBloc.updateStatusDonasi(
                                          donasi_id, 1);
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svgs/courir.svg',
                                          width: 20,
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Text("Ajukan ke kurir")
                                      ],
                                    )),
                              ),
                              Container(
                                width: double.infinity,
                                child: TextButton(
                                    style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.black),
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) => (states.contains(
                                                        MaterialState.pressed)
                                                    ? Colors.grey.shade200
                                                    : Colors.transparent))),
                                    onPressed: () {},
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(FontAwesome.hand_paper_o,
                                            size: 20),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Text("Ditolak Admin")
                                      ],
                                    )),
                              ),
                            ],
                          )
                        : Container(),
                    role_name == 'user'
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                child: TextButton(
                                    style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.black),
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) => (states.contains(
                                                        MaterialState.pressed)
                                                    ? Colors.grey.shade200
                                                    : Colors.transparent))),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      navigatorKey.currentState!.pushNamed(
                                          '/form-donate',
                                          arguments: {'id': donasi_id});
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(FontAwesome.edit),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Text("Edit")
                                      ],
                                    )),
                              ),
                            ],
                          )
                        : Container(),
                    role_name == 'kurir'
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              status == 1
                                  ? Container(
                                      width: double.infinity,
                                      child: TextButton(
                                          style: ButtonStyle(
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.black),
                                              backgroundColor:
                                                  MaterialStateProperty.resolveWith(
                                                      (states) => (states
                                                              .contains(
                                                                  MaterialState
                                                                      .pressed)
                                                          ? Colors.grey.shade200
                                                          : Colors
                                                              .transparent))),
                                          onPressed: () async {
                                            await _donasiBloc
                                                .updateStatusDonasi(
                                                    donasi_id, 2);
                                          },
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/svgs/paket-svgrepo-com.svg',
                                                width: 20,
                                                height: 20,
                                              ),
                                              SizedBox(
                                                width: 8.w,
                                              ),
                                              Text("sedang diambil kurir")
                                            ],
                                          )),
                                    )
                                  : Container(),
                              status == 2
                                  ? Container(
                                      width: double.infinity,
                                      child: TextButton(
                                          style: ButtonStyle(
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.black),
                                              backgroundColor:
                                                  MaterialStateProperty.resolveWith(
                                                      (states) => (states
                                                              .contains(
                                                                  MaterialState
                                                                      .pressed)
                                                          ? Colors.grey.shade200
                                                          : Colors
                                                              .transparent))),
                                          onPressed: () async {
                                            await _donasiBloc
                                                .updateStatusDonasi(
                                                    donasi_id, 4);
                                          },
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/svgs/delivery-man-svgrepo-com.svg',
                                                height: 20,
                                                width: 20,
                                              ),
                                              SizedBox(
                                                width: 8.w,
                                              ),
                                              Text("Sudah Diambil Kurir")
                                            ],
                                          )),
                                    )
                                  : Container(),
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: verticalPadding * 2,
                    )
                  ],
                );
              },
            )));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DonasiBloc, DonasiState>(
      bloc: _donasiBloc,
      buildWhen: (prev, next) {
        return (next is SuccessGetListDonasi);
      },
      listener: (context, state) {
        // TODO: implement listener
        if (state is LoadingUpdateStatus) {
          LoadingOverflay.of(context).open();
        } else if (state is SuccessUpdateStatus) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Success update status")));
          LoadingOverflay.of(context).close();
        }
      },
      builder: (context, state) {
        if (state is LoadingDonasiState) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is SuccessGetListDonasi) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text("Donasi $role_name"),
              actions: [
                canCreate
                    ? IconButton(
                        onPressed: () {
                          navigatorKey.currentState?.pushNamed('/form-donate');
                        },
                        icon: Icon(Icons.add))
                    : Container()
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Donasi Kamu",
                      style: textTheme().titleLarge,
                    ),
                    SizedBox(
                      height: verticalPadding / 2,
                    ),
                    ListView.builder(
                      itemBuilder: (context, index) =>
                          donasiCard(donasiModel: state.listDonasi[index]),
                      itemCount: state.listDonasi.length,
                      primary: false,
                      shrinkWrap: true,
                    )
                  ],
                ),
              ),
            ),
          );
        }

        return Scaffold();
      },
    );
  }

  Widget donasiCard({DonasiModel? donasiModel}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding / 2, vertical: verticalPadding / 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/svgs/diaper-svgrepo-com.svg',
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tanggal donasi: ",
                        style: textTheme().titleSmall,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        '${formattingDate(date: donasiModel?.date_donasi)}',
                        style: textTheme().bodySmall,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                        child: Text(
                          "${donasiModel?.status_donasi}",
                          style: textTheme().bodySmall?.copyWith(
                              color: colorStatus(donasiModel?.status_id ?? 0)),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: colorStatus(donasiModel?.status_id ?? 0)
                              .withOpacity(0.2),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 6.w,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await showModalBottom(
                        status: donasiModel?.status_id ?? 0,
                        donasi_id: donasiModel?.id ?? 0,
                      );
                    },
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.grey.shade500,
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 6.h,
          ),
          Divider(),
          SizedBox(
            height: 6.h,
          ),
          Text(
            "Jumlah Donasi :",
            style: textTheme().titleMedium,
          ),
          SizedBox(
            height: verticalPadding / 4,
          ),
          Text(
            "${donasiModel?.jumlah_donasi} ${donasiModel?.latitude}",
          ),
          SizedBox(
            height: verticalPadding / 3,
          ),
          Text(
            "Lokasi Donasi: ",
            style: textTheme().titleMedium?.copyWith(fontSize: 14.sp),
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            "${donasiModel?.alamat_donasi}",
            style: textTheme().bodySmall?.copyWith(color: Colors.grey.shade600),
          ),
          SizedBox(
            height: 12.h,
          ),
          Container(
            width: double.infinity,
            child: TextButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all(Colors.grey.shade800),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.grey.shade200)),
                onPressed: () async {
                  String googleUrl =
                      'https://www.google.com/maps/search/?api=1&query=${donasiModel?.latitude},${donasiModel?.longitude}';
                  final Uri _url = Uri.parse('https://flutter.dev');
                  await launchUrl(Uri.parse(googleUrl));

                  // String googleUrl =
                  //     'https://www.google.com/maps/search/?api=1&query=${latitude},${longitude}';
                  // final Uri _url =
                  //     Uri.parse('https://flutter.dev');
                  // await launchUrl(Uri.parse(googleUrl));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/location-svgrepo-com.svg',
                      width: 20,
                      height: 20,
                    ),
                    Text(
                      'buka lokasi di map',
                    )
                    // Text("${google_coordinate}")
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
