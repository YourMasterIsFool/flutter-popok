import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/commons/CustomSnackbar.dart';
import 'package:pos_flutter/commons/loading_overflay.dart';
import 'package:pos_flutter/commons/modal_container.dart';
import 'package:pos_flutter/commons/wrapper_lost_focus.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/donation/model/donasi_model.dart';
import 'package:pos_flutter/features/donation/presentation/bloc/donasi_bloc.dart';
import 'package:pos_flutter/features/donation/presentation/bloc/donasi_state.dart';
import 'package:pos_flutter/utils/formattingDate.dart';
import 'package:pos_flutter/utils/getLocation.dart';
import 'package:url_launcher/url_launcher.dart';

class DonationFormScreen extends StatefulWidget {
  const DonationFormScreen({super.key, this.id});
  final int? id;

  @override
  State<DonationFormScreen> createState() => _DonationFormScreenState();
}

class _DonationFormScreenState extends State<DonationFormScreen> {
  final alamatDonasiController = TextEditingController();
  final jumlahDonasiController = TextEditingController();
  final dateDonasiController = TextEditingController();
  String? latitude;
  String? longitude;
  String? google_coordinate = '';

  DateTime? dateDonasi = null;

  late DonasiBloc donasiBloc;

  late LoadingOverflay loadingOverflay;

  @override
  void initState() {
    donasiBloc = context.read<DonasiBloc>();
    if (widget.id != null) {
      getDetailDonasi();
    }
    loadingOverflay = LoadingOverflay.of(context);
    super.initState();
  }

  void getDetailDonasi() async {
    await donasiBloc.getDetailDonasiBloc(widget.id);
    setState(() {
      alamatDonasiController.text =
          donasiBloc.state.donasiModel?.alamat_donasi ?? '';
      jumlahDonasiController.text =
          donasiBloc.state.donasiModel?.jumlah_donasi.toString() ?? '';

      dateDonasi = donasiBloc.state.donasiModel?.date_donasi;
    });

    print(donasiBloc?.state?.donasiModel);
  }

  final _formKey = GlobalKey<FormState>();

  void createDonasiHandler() async {
    DonasiModel donasiModel = new DonasiModel(
        latitude: latitude,
        longitude: longitude,
        jumlah_donasi: double.parse(jumlahDonasiController.text),
        date_donasi: dateDonasi,
        alamat_donasi: alamatDonasiController.text);

    if (widget.id == null) {
      await donasiBloc.createDonasi(donasiModel).then((value) {});
    } else {
      await donasiBloc.updateDonasi(donasiModel, widget.id).then((value) {});
    }
  }

  Future<void> showDatePickerHandler({required BuildContext context}) async {
    await showDatePicker(
            context: context,
            initialDate: dateDonasi ?? DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(9999))
        .then((value) => setState(() {
              dateDonasi = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return WrapperLostFocuse(
      child: BlocConsumer<DonasiBloc, DonasiState>(
        listener: (context, state) {
          if (state is LoadingCreateDonasi) {
            LoadingOverflay.of(context).open();
          }
          if (state is SuccessCreateDonasi) {
            LoadingOverflay.of(context).close();

            ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackbar().SuccessSnackbar(message: state.success));

            navigatorKey.currentState?.pop();
            // navigatorKey.currentState?.pop();
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Buat Donasi "),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: horizontalPadding / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: verticalPadding / 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Buat Donasi \nPopok",
                          style:
                              textTheme().titleLarge?.copyWith(fontSize: 24.0),
                        ),
                        TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => ModalContainer(
                                    title: "Panduan Donasi Popok",
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: horizontalPadding / 2,
                                          vertical: verticalPadding / 3),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("1. "),
                                              SizedBox(
                                                width: 6.w,
                                              ),
                                              Expanded(
                                                child: Text(
                                                    "Popok dibersihkan dari BAB/PUB terlebih dulu"),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("2. "),
                                              SizedBox(
                                                width: 6.w,
                                              ),
                                              Expanded(
                                                child: Text(
                                                    "Isi Gel Di keluarkan dari Kain popok lalu kain direndam dengan air Sabun"),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("3. "),
                                              SizedBox(
                                                width: 6.w,
                                              ),
                                              Expanded(
                                                child: Text(
                                                    "Setelah. Bersih dari Gel, Kain popok dicuci seperti mencuci baju"),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("4. "),
                                              SizedBox(
                                                width: 6.w,
                                              ),
                                              Expanded(
                                                child: Text(
                                                    "setelah dibilas baru Keringkan Di panas Sinar Matahari"),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("5. "),
                                              SizedBox(
                                                width: 6.w,
                                              ),
                                              Expanded(
                                                child: Text(
                                                    "Setelah Kering Masukan Ke Kardus dan dibungkus dengan Rapat."),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )));
                          },
                          child: Text("Panduan"),
                          style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.grey.shade200)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: verticalPadding,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _formInput(
                                isNumber: true,
                                controller: jumlahDonasiController,
                                label: "Jumlah Donasi"),
                            SizedBox(
                              height: verticalPadding / 2,
                            ),
                            // _formInput(
                            //     controller: alamatDonasiController,
                            //     label: "Alamat Lengkap Donasi"),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pilih Tanggal Donasi",
                                  style: textTheme().bodySmall,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                        style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.black),
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.grey.shade300),
                                            padding: MaterialStateProperty.all(
                                                EdgeInsets.symmetric(
                                                    horizontal:
                                                        horizontalPadding /
                                                            2))),
                                        onPressed: () => showDatePickerHandler(
                                            context: context),
                                        child: Row(
                                          children: [
                                            Icon(Icons.date_range),
                                            SizedBox(
                                              width: horizontalPadding / 8,
                                            ),
                                            Text(
                                              dateDonasi == null
                                                  ? 'Tanggal Donasi'
                                                  : formattingDate(
                                                      date: dateDonasi),
                                              style: textTheme().bodySmall,
                                            )
                                          ],
                                        ))
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            TextFormField(
                              controller: alamatDonasiController,
                              minLines: 3,
                              maxLines: 4,
                              decoration: InputDecoration(
                                  alignLabelWithHint: true,
                                  label: Text("Alamat Lengkap Donasi")),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),

                            Container(
                              width: double.infinity,
                              child: TextButton(
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.grey.shade800),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.grey.shade200)),
                                  onPressed: () async {
                                    await getLocation().then((value) async {
                                      setState(() {
                                        latitude = value.latitude.toString();
                                        longitude = value.longitude.toString();
                                      });

                                      // String googleUrl =
                                      //     'https://www.google.com/maps/search/?api=1&query=${latitude},${longitude}';
                                      // final Uri _url =
                                      //     Uri.parse('https://flutter.dev');
                                      // await launchUrl(Uri.parse(googleUrl));
                                    });
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svgs/location-svgrepo-com.svg',
                                        width: 20,
                                        height: 20,
                                      ),
                                      Text(
                                          "${latitude == null ? 'cari lokasi kamu' : 'Update Lokasi'}"),
                                      // Text("${google_coordinate}")
                                    ],
                                  )),
                            ),
                            latitude != null
                                ? Container(
                                    margin: EdgeInsets.only(top: 12.h),
                                    child: GestureDetector(
                                      onTap: () async {
                                        String googleUrl =
                                            'https://www.google.com/maps/search/?api=1&query=${latitude ?? ""},${longitude ?? ""}';
                                        await launchUrl(Uri.parse(googleUrl));
                                      },
                                      child: Row(children: [
                                        Icon(Icons.map),
                                        SizedBox(
                                          width: 12.w,
                                        ),
                                        Text(
                                            "Buka Lokasi di map ${latitude} $longitude"),
                                      ]),
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              height: verticalPadding / 2,
                            ),
                            SizedBox(
                              height: verticalPadding,
                            ),

                            Container(
                              width: double.infinity,
                              child: TextButton(
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(
                                              vertical: 16.0))),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      createDonasiHandler();
                                    }
                                  },
                                  child: Text(
                                      "${widget.id == null ? 'Buat Donasi' : 'Update Donasi'}")),
                            )
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

  Container _formInput({
    bool isNumber = false,
    required TextEditingController controller,
    required String label,
    String? initialValue,
  }) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            inputFormatters:
                isNumber ? [FilteringTextInputFormatter.digitsOnly] : null,
            controller: controller,
            decoration: InputDecoration(
              label: Text(label),
            ),
          )
        ],
      ),
    );
  }
}
