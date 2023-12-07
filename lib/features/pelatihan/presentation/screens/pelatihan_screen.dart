import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/config/secure_storage/secure_storage.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/pelatihan/domain/model/pelatihan_model.dart';
import 'package:pos_flutter/features/pelatihan/presentation/bloc/pelatihan_bloc.dart';
import 'package:pos_flutter/features/pelatihan/presentation/bloc/pelatihan_state.dart';
import 'package:pos_flutter/features/pelatihan/presentation/widget/pelatihan_card.dart';

class PelatihanScreen extends StatefulWidget {
  const PelatihanScreen({super.key});

  @override
  State<PelatihanScreen> createState() => _KegiatanScreenState();
}

class _KegiatanScreenState extends State<PelatihanScreen> {
  late PelatihanBloc pelatihanBloc;

  final statusController = TextEditingController();

  @override
  void initState() {
    pelatihanBloc = context.read<PelatihanBloc>();
    pelatihanBloc.getListPelatihan();
    statusController.addListener(() {
      pelatihanBloc.getListPelatihan(params: {'status': statusController.text});
    });
    super.initState();
  }

  List<String> listStatus = [
    "ditolak",
    "sudah join",
    "belum join",
    "sudah lewat",
    "menunggu persetujuan"
  ];
  @override
  Widget build(BuildContext context) {
    // return BlocConsumer<PelatihanBloc, PelatihanState>(
    //   listener: (context, state) {
    //     // TODO: implement listener
    //   },
    //   builder: (context, state) {

    //   },
    // );

    return BlocConsumer<PelatihanBloc, PelatihanState>(
      bloc: pelatihanBloc,
      buildWhen: (prev, next) {
        return (next is SuccessGetListPelatihan ||
            next is LoadingPelatihanState);
      },
      listener: (context, state) {
        // TODO: implement listener
        print(state);
      },
      builder: (context, state) {
        List<PelatihanModel> datas =
            (state is SuccessGetListPelatihan) ? state.listPelatihan : [];
        return Scaffold(
          appBar: AppBar(
            title: Text("Pelatihan"),
            actions: [
              FutureBuilder(
                  future: SecureStorage().getRole(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data == 'admin'
                          ? IconButton(
                              onPressed: () {
                                navigatorKey.currentState
                                    ?.pushNamed('/pelatihan-form');
                              },
                              icon: Icon(Icons.add))
                          : Container();
                    }

                    return Container();
                  })
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding / 2),
              child: Column(children: [
                SizedBox(
                  height: verticalPadding,
                ),
                FutureBuilder(
                    future: SecureStorage().getRole(),
                    builder: (context, snapshot) {
                      return snapshot.data == 'user'
                          ? Container(
                              child: ListView.builder(
                                primary: true,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        left: horizontalPadding / 2),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          statusController.text =
                                              listStatus[index];
                                        });
                                        print("status" + statusController.text);
                                      },
                                      child: Container(
                                        child: Center(
                                          child: Text(
                                            listStatus[index],
                                            style: textTheme()
                                                .bodySmall
                                                ?.copyWith(
                                                    color: statusController
                                                                .text ==
                                                            listStatus[index]
                                                        ? Colors.white
                                                        : Colors.grey.shade800),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            color: statusController.text ==
                                                    listStatus[index]
                                                ? Colors.grey.shade800
                                                : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                              width: 1,
                                              color: statusController.text ==
                                                      listStatus[index]
                                                  ? Colors.transparent
                                                  : Colors.grey.shade800,
                                            )),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: horizontalPadding / 2,
                                            vertical: 8.h),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: listStatus.length,
                              ),
                              height: 40,
                            )
                          : Container();
                    }),
                SizedBox(
                  height: verticalPadding,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: datas.length,
                    itemBuilder: (context, index) =>
                        PelatihanCard(data: datas[index]))
              ]),
            ),
          ),
        );
      },
    );
  }
}
