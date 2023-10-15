import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/features/pelatihan/domain/model/pelatihan_model.dart';
import 'package:pos_flutter/utils/formattingDate.dart';

import '../../../../config/style/style.dart';
import '../../../../config/theme/myTheme.dart';

class PelatihanCard extends StatelessWidget {
  const PelatihanCard({super.key, required this.data});

  final PelatihanModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: verticalPadding / 2),
      child: GestureDetector(
        onTap: () {
          navigatorKey.currentState?.pushNamed('/pelatihan-form');
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Judul Pelatihan",
                    style: textTheme().titleSmall,
                  ),
                  Text(""),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "${data?.judul_pelatihan}",
                style: textTheme().bodySmall,
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                "Lokasi Pelatihan",
                style: textTheme().titleSmall,
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "${data?.lokasi_pelatihan}",
                style: textTheme().bodySmall,
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                "Deskripsi Pelatihan",
                style: textTheme().titleSmall,
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "${data?.deskripsi}",
                style: textTheme().bodySmall,
              )
            ],
          ),
          padding: EdgeInsets.symmetric(
              vertical: verticalPadding / 2, horizontal: horizontalPadding / 2),
        ),
      ),
    );
  }
}
