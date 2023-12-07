import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pos_flutter/features/donation/presentation/bloc/donasi_state.dart';
import 'package:pos_flutter/features/donation/presentation/bloc/donasi_status_state.dart';

import '../../domain/service/donasi_status_service.dart';

class DonasiStatusBloc extends Cubit<DonasiStatusState> {
  DonasiStatusBloc() : super(const LoadingGetDonasiStatus());

  Future<void> getDonasiStatusListBloc() async {
    emit(LoadingGetDonasiStatus());

    var response = await DonasiStatusService().getListDonasiStatusService();
    response?.fold((l) {
      emit(SuccessGetDonasiStatus(l));
    }, (r) {
      print(r.response.toString());
    });
  }
}
