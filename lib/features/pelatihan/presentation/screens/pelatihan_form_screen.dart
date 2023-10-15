import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/commons/date_input.dart';
import 'package:pos_flutter/commons/loading_overflay.dart';
import 'package:pos_flutter/commons/wrapper_lost_focus.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/pelatihan/domain/model/pelatihan_model.dart';
import 'package:pos_flutter/features/pelatihan/presentation/bloc/pelatihan_bloc.dart';
import 'package:pos_flutter/features/pelatihan/presentation/bloc/pelatihan_state.dart';

class PelatihanFormScreen extends StatefulWidget {
  const PelatihanFormScreen({super.key});

  @override
  State<PelatihanFormScreen> createState() => _PelatihanFormScreenState();
}

class _PelatihanFormScreenState extends State<PelatihanFormScreen> {
  DateTime? date = null;
  final judulController = TextEditingController();
  final lokasiController = TextEditingController();
  final deskripsiController = TextEditingController();

  late PelatihanBloc pelatihanBloc;
  LoadingOverflay? loadingOverflay;

  @override
  void initState() {
    pelatihanBloc = context.read<PelatihanBloc>();
    loadingOverflay = LoadingOverflay.of(context);
    super.initState();
  }

  void createPelatihanHandler() async {
    loadingOverflay?.open();
    PelatihanModel schema = new PelatihanModel(
        judul_pelatihan: judulController.text,
        deskripsi: deskripsiController.text,
        lokasi_pelatihan: lokasiController.text,
        tanggal_pelatihan: date);

    await pelatihanBloc.createPelatihan(schema).then((value) {
      loadingOverflay?.close();
    });
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PelatihanBloc, PelatihanState>(
      bloc: pelatihanBloc,
      listener: (context, state) {
        if (state is SuccessCreatePelatihan) {
          navigatorKey.currentState?.pop();
          ScaffoldMessenger.of(context)
              .showSnackBar(new SnackBar(content: Text("${state.success}")));
        }

        print(state);
        // TODO: implement listener
      },
      builder: (context, state) {
        return WrapperLostFocuse(
          child: Scaffold(
            appBar: AppBar(
              title: Text("Create Pelatihan"),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: horizontalPadding / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: verticalPadding,
                    ),
                    Text(
                      "Buat Pelatihan \nBaru",
                      style: textTheme().titleLarge,
                    ),
                    SizedBox(
                      height: verticalPadding / 2,
                    ),
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Judul Pelatihan tidak boleh kosong';
                                }
                              },
                              controller: judulController,
                              decoration: InputDecoration(
                                  label: Text("Judul Pelatihan")),
                            ),
                            SizedBox(
                              height: verticalPadding / 2,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Lokasi Pelatihan tidak boleh kosong';
                                }
                              },
                              controller: lokasiController,
                              minLines: 5,
                              maxLines: 6,
                              decoration: InputDecoration(
                                  label: Text("Lokasi Pelatihan"),
                                  alignLabelWithHint: true),
                            ),
                            SizedBox(
                              height: verticalPadding / 2,
                            ),
                            DateInput(
                              initalDate: date,
                              label: "Tanggal Pelatihan",
                              onChange: (value) {
                                setState(() {
                                  date = value;
                                });
                              },
                            ),
                            SizedBox(
                              height: verticalPadding / 2,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Deskripsi Pelatihan tidak boleh kosong';
                                }
                              },
                              controller: deskripsiController,
                              minLines: 5,
                              maxLines: 6,
                              decoration: InputDecoration(
                                  label: Text("Deskripsi Pelatihan"),
                                  alignLabelWithHint: true),
                            ),
                            SizedBox(
                              height: verticalPadding / 2,
                            ),
                            Container(
                              width: double.infinity,
                              child: TextButton(
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.all(16))),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      createPelatihanHandler();
                                    }
                                  },
                                  child: Text("Buat Pelatihan")),
                            )
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
