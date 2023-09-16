import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pos_flutter/commons/wrapper_lost_focus.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Map<String, dynamic>> listTile = [
    {
      'desc':
          'Reprehenderit voluptate id nostrud incididunt ullamco culpa quis consectetur aliquip est cupidatat aute.',
      'url':
          'https://img-cdn.medkomtek.com/jW-IoOcSPQ_HPIFAzpzjhCaEF9Q=/0x0/smart/filters:quality(75):strip_icc():format(webp)/article/U2FI6ujqjZNAowjKtaX3t/original/001143500_1597834555-Tips-Memilih-Popok-Dewasa-Agar-Tetap-Nyaman-dan-Percaya-Diri-By-FotoDuets-shutterstock.jpg',
      'title': 'Popok bayi',
      'author': 'Verrandy',
      'price': 'Rp. 1000.000'
    },
    {
      'desc':
          'Reprehenderit voluptate id nostrud incididunt ullamco culpa quis consectetur aliquip est cupidatat aute.',
      'url':
          'https://parenttown-prod.s3.ap-southeast-1.amazonaws.com/product_affiliate/products/1640596120262.jpg',
      'title': 'Popok bayi',
      'author': 'Verrandy',
      'price': 'Rp. 1000.000'
    },
    {
      'desc':
          'Reprehenderit voluptate id nostrud incididunt ullamco culpa quis consectetur aliquip est cupidatat aute.',
      'url':
          'https://media.suara.com/pictures/970x544/2019/10/17/71800-ilustrasi-popok-bayi.jpg',
      'title': 'Popok bayi',
      'author': 'Verrandy',
      'price': 'Rp. 1000.000'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return WrapperLostFocuse(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Popoku"),
        actions: [
          IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pushNamed(context, '/menu');
              },
              icon: Icon(Icons.person_rounded))
        ],
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: horizontalPadding / 2,
              ),
              Text(
                "Explore Popok \nTebaru",
                style: textTheme().titleLarge?.copyWith(fontSize: 24.sp),
              ),
              SizedBox(
                height: verticalPadding / 2,
              ),
              TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Cari popok yang kamu inginkan.."),
              ),
              SizedBox(
                height: verticalPadding,
              ),
              Expanded(
                  child: MasonryGridView.builder(
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) => Container(
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, '/product-detail'),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  '${listTile[index]['url']}',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${listTile[index]['title']}",
                                      style: textTheme().bodySmall,
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(
                                      "${listTile[index]['price']}",
                                      style: textTheme().titleMedium,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          top: 8,
                          left: 15,
                          child: GestureDetector(
                            child: Container(
                              height: 32,
                              width: 32,
                              child: Center(
                                  child: Icon(
                                Icons.favorite,
                                size: 14,
                              )),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.6),
                                        offset: Offset(0, 4),
                                        blurRadius: 10,
                                        spreadRadius: 2)
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                          )),
                    ],
                  ),
                ),
                itemCount: listTile.length,
              ))
            ],
          ),
        ),
      ),
    ));
  }
}
