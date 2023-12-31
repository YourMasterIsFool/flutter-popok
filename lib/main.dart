import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/features/article/presentation/bloc/article_bloc.dart';
import 'package:pos_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pos_flutter/features/donation/presentation/bloc/donasi_bloc.dart';
import 'package:pos_flutter/features/donation/presentation/bloc/donasi_status_bloc.dart';
import 'package:pos_flutter/features/lupa_password/presentation/bloc/lupa_password_bloc.dart';
import 'package:pos_flutter/features/order/presentation/bloc/order_bloc.dart';
import 'package:pos_flutter/features/order/presentation/bloc/order_status_bloc.dart';
import 'package:pos_flutter/features/pelatihan/presentation/bloc/pelatihan_bloc.dart';
import 'package:pos_flutter/features/product/presentation/bloc/product_bloc.dart';
import 'package:pos_flutter/features/profile/presentation/bloc/user_bloc.dart';
import 'inject_container.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependecies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return MultiBlocProvider(providers: [
            BlocProvider<ProductBloc>(create: (context) => ProductBloc()),
            BlocProvider<OrderStatusBloc>(
                create: (context) => OrderStatusBloc()),
            BlocProvider<OrderBloc>(create: (context) => OrderBloc()),
            BlocProvider<DonasiStatusBloc>(
                create: (context) => DonasiStatusBloc()),
            BlocProvider<LupaPasswordBloc>(
                create: (context) => LupaPasswordBloc()),
            BlocProvider<ArticleBloc>(create: (context) => ArticleBloc()),
            BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
            BlocProvider<PelatihanBloc>(create: (context) => PelatihanBloc()),
            BlocProvider<UserBloc>(create: (context) => UserBloc()),
            BlocProvider<DonasiBloc>(create: (context) => DonasiBloc())
          ], child: App());
        });
  }
}
