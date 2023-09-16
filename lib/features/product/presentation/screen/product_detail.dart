import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key, this.id});
  final String? id;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  Future<void> showModalSheet(context) async {
    return await showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              height: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding / 2,
                        vertical: verticalPadding / 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Pesan Popok"),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close)),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding / 2,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Price: "),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          "Rp. 17.000.000",
                          style: textTheme().titleLarge,
                        ),
                        SizedBox(
                          height: verticalPadding / 2,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding / 3, vertical: 4.h),
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(100)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  )),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: horizontalPadding),
                                child: Text(
                                  "17",
                                  style: textTheme()
                                      .titleMedium
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100))),
                            padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    horizontal: horizontalPadding,
                                    vertical: verticalPadding / 2))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Process to payment"),
                            Text("Rp. 17.000.000")
                          ],
                        )),
                  ),
                  SizedBox(
                    height: verticalPadding,
                  ),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Product Name"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => showModalSheet(context),
          label: Container(
            width: 200.w,
            child: Center(
              child: Text("Buy popok Rp. 17.000.000"),
            ),
            padding: EdgeInsets.symmetric(
              vertical: verticalPadding / 3,
              horizontal: horizontalPadding / 2,
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://media.suara.com/pictures/970x544/2019/10/17/71800-ilustrasi-popok-bayi.jpg',
              height: 250.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: verticalPadding / 2,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rp. 1.700.000",
                    style: textTheme().titleLarge,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "Veniam commodo quis nulla reprehenderit dolore.",
                    style: textTheme()
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(200)),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        "Verrandy bagus",
                        style: textTheme().bodySmall,
                      )
                    ],
                  ),
                  SizedBox(
                    height: verticalPadding / 2,
                  ),
                  Divider(),
                  SizedBox(
                    height: verticalPadding / 2,
                  ),
                  Text(
                    "Deskripsi Product",
                    style: textTheme().titleLarge,
                  ),
                  SizedBox(
                    height: verticalPadding / 2,
                  ),
                  Text(
                    "Ea esse nisi veniam fugiat Lorem duis commodo exercitation deserunt sunt. Sit elit quis sint ut excepteur duis Lorem id aliqua tempor Lorem veniam occaecat elit. Sint officia qui excepteur ad ut consectetur cillum fugiat amet occaecat in eiusmod sit tempor. Ut officia tempor eu quis ullamco commodo ullamco officia laborum et culpa. Minim veniam sint est adipisicing est elit ad elit. Ea duis anim minim mollit. Velit proident reprehenderit enim ipsum velit consequat dolore nostrud sint labore mollit nulla.",
                    style: textTheme().bodyMedium?.copyWith(height: 1.5),
                  )
                ],
              ),
            ),
            SizedBox(
              height: verticalPadding * 4,
            ),
          ],
        ),
      ),
    );
  }
}
