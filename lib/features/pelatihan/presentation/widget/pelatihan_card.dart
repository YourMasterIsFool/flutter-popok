import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/config/secure_storage/secure_storage.dart';
import 'package:pos_flutter/features/pelatihan/domain/model/pelatihan_member.dart';
import 'package:pos_flutter/features/pelatihan/domain/model/pelatihan_model.dart';
import 'package:pos_flutter/utils/formattingDate.dart';

import '../../../../config/style/style.dart';
import '../../../../config/theme/myTheme.dart';

class PelatihanCard extends StatelessWidget {
  const PelatihanCard({super.key, required this.data});

  final PelatihanModel data;

  @override
  Widget build(BuildContext context) {
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

    return Container(
      margin: EdgeInsets.only(bottom: verticalPadding / 2),
      child: GestureDetector(
        onTap: () {
          navigatorKey.currentState
              ?.pushNamed('/pelatihan-detail', arguments: {'id': data.id});
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
                  FutureBuilder(
                      future: SecureStorage().getRole(),
                      builder: (context, snapshot) {
                        return snapshot.data == 'admin'
                            ? Container(
                                child: Text(
                                  "total member: ${data.members!.length}",
                                  style: textTheme()
                                      .bodyMedium
                                      ?.copyWith(fontSize: 8.sp),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(100)),
                              )
                            : data.tanggal_pelatihan!
                                        .difference(DateTime.now())
                                        .inDays <
                                    0
                                ? Container(
                                    child: Text(
                                      "Sudah Lewat",
                                      style: textTheme().bodyMedium?.copyWith(
                                          fontSize: 8.sp, color: Colors.white),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                        color: Colors.red.shade600,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                  )
                                : Container(
                                    child: Text(
                                      "${status(data.is_member)['status']}",
                                      style: textTheme()
                                          .bodyMedium
                                          ?.copyWith(fontSize: 8.sp),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                        color: status(data.is_member)['color'],
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                  );
                      })
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
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                "Tanggal Pelatihan",
                style: textTheme().titleSmall,
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "${formattingDate(date: data?.tanggal_pelatihan)}",
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
