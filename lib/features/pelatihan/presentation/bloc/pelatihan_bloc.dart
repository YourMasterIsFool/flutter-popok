import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pos_flutter/features/pelatihan/domain/model/pelatihan_model.dart';
import 'package:pos_flutter/features/pelatihan/presentation/bloc/pelatihan_state.dart';

import '../../domain/sevice/pelatihan_service.dart';

class PelatihanBloc extends Cubit<PelatihanState> {
  PelatihanService pelatihanService = PelatihanService();
  PelatihanBloc() : super(const InitialPelatihanState());

  Future<void> createPelatihan(PelatihanModel schema) async {
    emit(LoadingPelatihanState());
    var response = await pelatihanService.createPelatihanService(schema);

    response?.fold((l) {
      getListPelatihan();
      emit(SuccessCreatePelatihan('Successfully created donasi'));
    }, (r) => print(r));
  }

  void getListPelatihan() async {
    emit(LoadingPelatihanState());
    var response = await pelatihanService.getListPelatihanService();

    print('get list donasi response' + response.toString());
    response?.fold((l) => emit(SuccessGetListPelatihan(l)), (r) => print(r));
  }
}
