import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/features/product/domain/models/product_model.dart';

import '../../../../config/theme/myTheme.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          navigatorKey.currentState?.pushNamed('/product-detail',
              arguments: {'id': productModel.id ?? 0});
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(0, 2),
                    blurRadius: 0,
                    spreadRadius: 1)
              ],
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Image.network(
                  '${dotenv.env['BASE_URL_API']}${productModel?.file_path}',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "${productModel.product_title}",
                      style: textTheme()
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      "Rp. ${productModel.product_price}",
                      style: textTheme().titleMedium,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      children: [Text("Stok: "), Text("${productModel?.stok}")],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      "${productModel.product_description}",
                      style: textTheme().bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                          overflow: TextOverflow.ellipsis),
                      maxLines: 2,
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
