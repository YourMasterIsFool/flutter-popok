import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/commons/loading_overflay.dart';
import 'package:pos_flutter/commons/wrapper_lost_focus.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/donation/model/donasi_model.dart';
import 'package:pos_flutter/features/donation/presentation/bloc/donasi_bloc.dart';
import 'package:pos_flutter/features/donation/presentation/bloc/donasi_state.dart';
import 'package:pos_flutter/utils/formattingDate.dart';

class DonationFormScreen extends StatefulWidget {
  const DonationFormScreen({super.key});

  @override
  State<DonationFormScreen> createState() => _DonationFormScreenState();
}

class _DonationFormScreenState extends State<DonationFormScreen> {
  final alamatDonasiController = TextEditingController();
  final jumlahDonasiController = TextEditingController();
  final dateDonasiController = TextEditingController();

  DateTime? dateDonasi = null;

  late DonasiBloc donasiBloc;

  late LoadingOverflay loadingOverflay;

  @override
  void initState() {
    donasiBloc = context.read<DonasiBloc>();
    loadingOverflay = LoadingOverflay.of(context);
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  void createDonasiHandler() async {
    loadingOverflay.open();
    DonasiModel donasiModel = new DonasiModel(
        jumlah_donasi: double.parse(jumlahDonasiController.text),
        date_donasi: dateDonasi);

    await donasiBloc.createDonasi(donasiModel).then((value) {
      loadingOverflay.close();
    });
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
          if (state is SuccessCreateDonasi) {
            navigatorKey.currentState!.pop();
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Success Membuat Donasi")));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Buat Donasi"),
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
                    Text(
                      "Buat Donasi \nPopok",
                      style: textTheme().titleLarge?.copyWith(fontSize: 24.0),
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
                                  child: Text("Buat Donasi")),
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
