import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/config/secure_storage/secure_storage.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/product/presentation/bloc/product_bloc.dart';
import 'package:pos_flutter/features/product/presentation/bloc/product_state.dart';
import 'package:pos_flutter/features/product/presentation/widget/product_widget.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late ProductBloc _productBloc;

  @override
  void initState() {
    _productBloc = context.read<ProductBloc>();
    _productBloc.getProductListBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      bloc: _productBloc,
      buildWhen: (prev, next) {
        return (next is SuccessGetListProduct || next is LoadingGetListProduct);
      },
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is LoadingGetListProduct) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is SuccessGetListProduct) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Produk"),
              actions: [
                FutureBuilder(
                    future: SecureStorage().getRole(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data == 'admin'
                            ? IconButton(
                                onPressed: () {
                                  navigatorKey.currentState
                                      ?.pushNamed('/product-form');
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
                padding: EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: verticalPadding / 2,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/popok_product.jpg',
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Container(
                    //   height: 150,
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       color: Colors.grey.shade400),
                    // ),
                    SizedBox(
                      height: verticalPadding / 2,
                    ),
                    MasonryGridView.builder(
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      gridDelegate:
                          SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) =>
                          ProductWidget(productModel: state.products[index]),
                      itemCount: state.products.length,
                      shrinkWrap: true,
                      primary: false,
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
}
