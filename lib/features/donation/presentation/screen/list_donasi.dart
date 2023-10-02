import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/donation/model/donasi_model.dart';
import 'package:pos_flutter/features/donation/presentation/bloc/donasi_bloc.dart';
import 'package:pos_flutter/features/donation/presentation/bloc/donasi_state.dart';
import 'package:pos_flutter/utils/formattingDate.dart';

class ListDonasiScreen extends StatefulWidget {
  const ListDonasiScreen({super.key});

  @override
  State<ListDonasiScreen> createState() => _ListDonasiScreenState();
}

class _ListDonasiScreenState extends State<ListDonasiScreen> {
  late DonasiBloc _donasiBloc;

  @override
  void initState() {
    _donasiBloc = context.read<DonasiBloc>();
    _donasiBloc.getListDonasi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DonasiBloc, DonasiState>(
      bloc: _donasiBloc,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is LoadingDonasiState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is SuccessGetListDonasi) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Donasi"),
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

        return Container();
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
          Text(
            "Jumlah Donasi :",
            style: textTheme().titleMedium,
          ),
          SizedBox(
            height: verticalPadding / 4,
          ),
          Text(
            "${donasiModel?.jumlah_donasi}",
          ),
          SizedBox(
            height: verticalPadding / 3,
          ),
          Text(
            "Tanggal donasi: ",
            style: textTheme().titleMedium?.copyWith(fontSize: 14.sp),
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            '${formattingDate(date: donasiModel?.date_donasi)}',
            style: textTheme().bodySmall,
          )
        ],
      ),
    );
  }
}
