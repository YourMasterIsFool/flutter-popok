import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_flutter/app.dart';
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

  @override
  void initState() {
    pelatihanBloc = context.read<PelatihanBloc>();
    pelatihanBloc.getListPelatihan();
    super.initState();
  }

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
              IconButton(
                  onPressed: () {
                    navigatorKey.currentState?.pushNamed('/pelatihan-form');
                  },
                  icon: Icon(Icons.add))
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding / 2),
              child: Column(children: [
                SizedBox(
                  height: verticalPadding / 3,
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
